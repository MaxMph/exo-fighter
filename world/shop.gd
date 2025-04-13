extends Control

var is_open = false
#var item_buttons: Array = []
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
	visible = true
	is_open = true
	
	$"PanelContainer/VBoxContainer/weighted gloves".grab_focus()

func close():
	visible = false
	Global.in_menu = false
	is_open = false


func _input(event: InputEvent) -> void:
	if is_open:
		#find_item()
		if Input.is_action_just_pressed("exit"):
			close()
		#if Input.is_action_just_pressed("interact"):
		#	if cur_item.price <= Global.money:
		#		Global.money -= cur_item.price
				#NodePath(get_viewport().egui_get_focus_owner())


#func find_item():
	#for i in item_buttons:
		#if i == get_viewport().gui_get_focus_owner():
			#cur_item = item_res[item_buttons.find(i)]
			#item_text.text = cur_item.description
			#price_text.text = "$" + str(cur_item.price)
