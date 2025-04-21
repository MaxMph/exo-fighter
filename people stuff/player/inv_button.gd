extends TextureButton

@export var header: String

func _ready() -> void:
	pressed.connect(clicked)
	
	

func clicked():
	for button in $"../../..".all_buttons:
		if button != self:
			button.button_pressed = false
	
	$"../../../AspectRatioContainer2/PanelContainer/header".text = header
