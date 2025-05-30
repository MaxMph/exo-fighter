extends CharacterBody2D


const SPEED = 14.0
var sprint_mod: float = 1.0
var fric = 2

var interaction

@export var stats: Resource

#sounds
@onready var buy = $sound/buy
@onready var whoosh = $sound/whoosh
@onready var shoot_sound = $sound/shoot
@onready var gravel_step = $sound/gravel_step

#gun
@onready var line = $gunpath/Line2D
@onready var norm_line_color
@onready var gunpath = $gunpath
var recoil = Vector2.ZERO
var recoil_power = -10
var spread = 0.05
var single_fire = false

func  _ready() -> void:
	Global.player = self
	norm_line_color = line.default_color

func _physics_process(delta: float) -> void:
	
	#print(stats.damage)
	
	if Input.is_action_pressed("sprint"):
		sprint_mod = 1.4
	elif sprint_mod != 1:
		sprint_mod = 1
	
	if Global.can_walk == true:
		#if Input.get_vector("left","right","up","down") != Vector2.ZERO:
		#velocity = Input.get_vector("left","right","up","down") * (SPEED * sprint_mod)

		var direction := Input.get_vector("left","right","up","down").normalized()
		if direction != Vector2.ZERO:
			velocity.x = direction.x * (SPEED * sprint_mod)
			velocity.y = direction.y * (SPEED * sprint_mod)
		else:
			velocity.x = move_toward(velocity.x, 0, fric)
			velocity.y = move_toward(velocity.y, 0, fric)

	
	#if velocity != Vector2.ZERO:
		#if gravel_step.playing == false:
			#gravel_step.play()
	#else:
		#gravel_step.stop
	
		if Input.is_action_just_pressed("interact") and Global.can_interact:
			interaction.interact()
		
	
	if Global.can_interact == true and Global.in_menu == false:
		$CanvasLayer/interaction_indicator.visible = true
	else:
		$CanvasLayer/interaction_indicator.visible = false
	

	if Global.in_menu == false and Input.mouse_mode != Input.MOUSE_MODE_HIDDEN:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


	if Global.in_menu == false:
		
		
	#	var ray_angle = 
		$gunpath.look_at(get_global_mouse_position())
		$gunpath/Sprite2D2.global_position = get_global_mouse_position()
		if $gunpath.is_colliding():
			$gunpath/Line2D.global_rotation = 0
			$gunpath/Line2D.set_point_position(1, to_local($gunpath.get_collision_point()))
			$gunpath/Sprite2D.global_position = to_global($gunpath/Line2D.get_point_position(1))
			#$gunpath.get_collision_point()
		else:
			pass
		
		if Input.is_action_pressed("shoot") and $firerate.is_stopped() and single_fire == false:
			shoot()
		
		if Input.is_action_just_pressed("shoot") and single_fire == true and $firerate.is_stopped():
			shoot()
	
	if recoil != Vector2.ZERO:
		#velocity = recoil
		recoil.x = move_toward(recoil.x, 0, 1)
		recoil.y = move_toward(recoil.y, 0, 1)
		velocity = velocity * 0.8
		velocity += recoil
	
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.can_interact = true
	interaction = area
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	Global.can_interact = false


func _on_one_sec_timeout() -> void:
	if stats.health != 100:
		stats.health += 4
	if stats.hunger != 0:
		stats.hunger -= 1

func shoot():
	$firerate.start()
	$gunpath/Line2D.default_color = Color.ORANGE
	shoot_sound.play()
	recoil = global_position.direction_to($gunpath/Sprite2D2.global_position) * recoil_power
	Global.screenshake.shake(0.5, 0.2)
	var real_spread = randf_range(-spread, spread)
	gunpath.rotation += real_spread
	if $gunpath.is_colliding() and $gunpath.get_collider().is_in_group("hitable"):
		$gunpath.get_collider().hit(20, recoil)
		
	await get_tree().create_timer(0.1).timeout
	gunpath.rotation -= real_spread
	$gunpath/Line2D.default_color = norm_line_color

func hit(dmg):
	stats.health -= dmg
	$CanvasLayer/Control/ProgressBar.value = stats.health
	whoosh.play()
	if stats.health <= 0:
		get_tree().change_scene_to_file("res://world/main.tscn")
