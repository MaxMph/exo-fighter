extends Control

var all_buttons: Array


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inv"):
		if visible == false:
			open()
		else:
			close()

func open():
	if Global.in_menu == false:
		print("inv")
		Global.in_menu = true
		visible = true
		all_buttons.clear()
		all_buttons += $AspectRatioContainer/TextureRect.get_children()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)



func close():
	if visible == true:
		visible = false
		Global.in_menu = false
