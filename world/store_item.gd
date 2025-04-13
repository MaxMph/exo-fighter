extends Button
class_name shop_button

@onready var item_text: RichTextLabel = $"../../../PanelContainer2/MarginContainer/HBoxContainer/RichTextLabel"
@onready var price_text: Label = $"../../../PanelContainer2/MarginContainer/HBoxContainer/VBoxContainer/Label"

@export var item_res: Resource

var purchased = false

func _input(event: InputEvent) -> void:
	if has_focus():
		item_text.text = item_res.description
		price_text.text = "$" + str(item_res.price)
		self.connect("pressed", "button_clicked")

func button_clicked():
	if item_res.price <= Global.money and purchased == false:
		Global.money -= item_res.price
		purchased = true
