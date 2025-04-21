extends Node

var shake_strength = 0
var shake_length = 0
var shake_fade = 2

var shake_time = 0
var shake_time_speed = 10.0

var noise = FastNoiseLite.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.screenshake = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if shake_length > 0:
		shake_time += delta * shake_time_speed
		shake_length -= delta
		
		$"../Camera2D".offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_strength,
			noise.get_noise_2d(0, shake_time) * shake_strength
		)
		shake_strength = max(shake_strength - shake_fade * delta, 0)
	else:
		$"../Camera2D".offset = lerp($"../Camera2D".offset, Vector2.ZERO, 10.5 * delta)

func shake(intesity, time):
	randomize()
	noise.seed = randi()
	noise.frequency = 2
	
	shake_strength = intesity
	shake_length = time
	shake_time = 0
