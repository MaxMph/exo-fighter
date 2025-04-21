extends Control


func _on_timer_timeout() -> void:
	if randi_range(0, 10) > 4:
		$fighter.attack()
	
	if randi_range(0, 10) > 4:
		$enemy.attack()
