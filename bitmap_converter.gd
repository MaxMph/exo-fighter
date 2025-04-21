extends Node

@onready var img = "res://people stuff/player/art/inv/Group 1/arm_bitmap.png"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BitMap.new().create_from_image_alpha(img)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
