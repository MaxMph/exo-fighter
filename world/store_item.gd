extends Button
class_name shop_button

@onready var item_text: RichTextLabel = $"../../../PanelContainer2/MarginContainer/HBoxContainer/RichTextLabel"
@onready var price_text: Label = $"../../../PanelContainer2/MarginContainer/HBoxContainer/VBoxContainer/Label"

@export var item_res: Resource

var purchased = false

func _ready() -> void:
	pressed.connect(clicked)
	
	if disabled == true:
		text = item_res.title + "(owned)"
	else:
		text = item_res.title + "($" + str(item_res.price) + ")"

func _input(event: InputEvent) -> void:
	if has_focus():
		item_text.text = item_res.description
		if disabled == true:
			price_text.text = "(owned)"
		else:
			price_text.text = "$" + str(item_res.price)
		text = item_res.title + price_text.text
		


func clicked():
	if item_res.price <= Global.money and purchased == false:
		Global.money -= item_res.price
		purchased = true
		disabled = true
		Global.player.buy.play()
	else:
		Global.player.whoosh.play()
