extends CanvasLayer



func _process(delta: float) -> void:
	$Control/money.text = "$" + str(Global.money)
