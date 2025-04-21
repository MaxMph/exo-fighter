extends Control

var is_open = false
var cur_item

var toberemoved

@onready var item_text = $PanelContainer2/MarginContainer/HBoxContainer/RichTextLabel
@onready var price_text = $PanelContainer2/MarginContainer/HBoxContainer/VBoxContainer/Label

@export var item_res: Dictionary = {
	0: preload("res://items/weighted_gloves.tres"),
	1: preload("res://items/heavy weighted gloves.tres"),
	2: preload("res://items/carbonfiber frame.tres"),
	3: preload("res://items/muscle sensors.tres"),
	4: preload("res://items/quality_arm_extender.tres")
}


func open():
	Global.in_menu = true
	Global.can_walk = false
	visible = true
	is_open = true
	Global.player.whoosh.play()
	
	$"PanelContainer/VBoxContainer/weighted gloves".grab_focus()

func close():
	visible = false
	Global.in_menu = false
	Global.can_walk = true
	is_open = false
	Global.player.whoosh.play()


func _input(event: InputEvent) -> void:
	if is_open:
		if Input.is_action_just_pressed("exit"):
			close()
