extends CharacterBody2D


@export var gun: Resource
@export var stats: Resource

var player_inrange = false
var opp

var knockback = Vector2.ZERO

func _ready() -> void:
	if stats != null:
		stats = stats.duplicate()

func _physics_process(delta: float) -> void:
	
	if player_inrange and abs($head/probe.get_angle_to(opp.global_position)) <= 1.2:
		$head/probe.look_at(opp.global_position)
		if $head/probe.is_colliding() and $head/probe.get_collider().is_in_group("player"):
			attack(opp.global_position)

	if knockback != Vector2.ZERO:
		knockback.x = move_toward(knockback.x, 0, 1)
		knockback.y = move_toward(knockback.y, 0, 1)
		velocity = knockback

	move_and_slide()


func hit(dmg, knock):
	stats.health -= dmg
	$AudioStreamPlayer2D.play()
	knockback = knock * -1
	
	$GPUParticles2D.emitting = true
	if stats.health <= 0:
		die()
	else:
		$Sprite2D.self_modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		$Sprite2D.self_modulate = Color.WHITE

func die():
	queue_free()


func _on_sense_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		opp = body
		player_inrange = true


func _on_sense_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inrange = false


func attack(probe_rot):
	await get_tree().create_timer(0.1).timeout
	#$head/gun_ray.rotation = move_toward($head/gun_ray.rotation, $head/probe.rotation, 0.01 + (0.1 * abs($head/gun_ray.rotation - $head/probe.rotation)))
	#$head/gun_ray.look_at(opp.global_position)
	#print(0.1 * abs($head/gun_ray.rotation - $head/probe.rotation))
	$head/gun_ray.look_at(probe_rot)
	
