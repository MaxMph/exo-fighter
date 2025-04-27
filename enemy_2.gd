extends CharacterBody2D


@export var speed = 1
@export var view_dist = 26
@export var health = 100
@export var dmg = 10

@onready var ray = $RayCast2D

var last_target_pos
var is_hunting = false

var in_range = false

var knockback = Vector2.ZERO

func _ready() -> void:
	ray.target_position.x = view_dist
	last_target_pos = global_position

func _physics_process(delta: float) -> void:
	
	if global_position != last_target_pos:
		velocity = (last_target_pos - global_position) * speed
		is_hunting = true
	else:
		is_hunting = false

	if knockback != Vector2.ZERO:
		knockback.x = move_toward(knockback.x, 0, 1)
		knockback.y = move_toward(knockback.y, 0, 1)
		velocity = knockback

	move_and_slide()



func on_tic() -> void:
	ray.look_at(Global.player.global_position)
	if ray.is_colliding() and ray.get_collider().is_in_group("player"):
			last_target_pos = Global.player.position

func hit(dmg, knock):
	
	if is_hunting == false:
		last_target_pos = Global.player.global_position
	
	find_friends()
	
	health -= dmg
	$AudioStreamPlayer2D.play()
	knockback = knock * -1
	
	$GPUParticles2D.emitting = true
	if health <= 0:
		die()
	else:
		$Sprite2D.self_modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		$Sprite2D.self_modulate = Color.WHITE

func die():
	Global.money += randi_range(40, 80)
	Global.player.buy.play()
	queue_free()

func friendhit(pos):
	var friend_cast = $RayCast2D2# = RayCast2D.new()
	#friend_cast.target_position = Vector2(view_dist, 0)
	friend_cast.look_at(pos)
	if friend_cast.is_colliding() and friend_cast.get_collider().is_in_group("enemies"):
		print("find")
		if is_hunting == false:
			last_target_pos = pos

func find_friends():
	var cur_friends
	cur_friends = get_tree().get_nodes_in_group("enemies")
	for i in cur_friends:
		i.friendhit(global_position)
	


func _on_attack_area_body_entered(body: Node2D) -> void:
	in_range = true
	$attack_timer.start()


func _on_attack_area_body_exited(body: Node2D) -> void:
	in_range = false
	$attack_timer.stop()



func _on_attack() -> void:
	if in_range:
		Global.player.hit(dmg)
		$attack_timer.start()
