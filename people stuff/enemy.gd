extends CharacterBody2D


@export var gun: Resource
@export var stats: Resource

var knockback = Vector2.ZERO

func _ready() -> void:
	if stats != null:
		stats = stats.duplicate()

func _physics_process(delta: float) -> void:


	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	if knockback != Vector2.ZERO:
		velocity = knockback
		knockback.x = move_toward(knockback.x, 0, 1)
		knockback.y = move_toward(knockback.y, 0, 1)

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
