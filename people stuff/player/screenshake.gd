extends Node

var shake_strength = 0
var shake_freq = 10
var iterations = 0

var target = Vector2.ZERO

func _ready() -> void:
	Global.screenshake = self


func _physics_process(delta: float) -> void:
	
	if $"../Camera2D".offset != target:
	#if is_equal_approx($"../Camera2D".offset.x, target.x) and is_equal_approx($"../Camera2D".offset.y, target.y):
	#	$"../Camera2D".offset += target / shake_freq
		$"../Camera2D".offset = lerp($"../Camera2D".offset, target, delta)
		
	#	$"../Camera2D".offset.x = lerpf($"../Camera2D".offset.x, target.x, target.x / shake_freq)
	#	$"../Camera2D".offset.y = lerpf($"../Camera2D".offset.y, target.y, target.y / shake_freq)
		print(target / shake_freq)
	elif iterations > 0:
		find_rng()
	#shake_strength -= shake_fade

func shake(strength, freq, iter):
	shake_strength = strength
	shake_freq = freq
	iterations = iter
	
	find_rng()


func find_rng():
	print("works")
	var max_val = shake_strength * 10
	var x1
	var x2
	x1 = randi_range(-shake_strength, shake_strength)
	x2 = max_val - abs(x1)
	target = Vector2(x1, x2) / 10
	shake_strength / 2
	iterations -= 1
