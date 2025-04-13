extends CharacterBody2D


const SPEED = 16.0

var interaction

func _physics_process(delta: float) -> void:
	
	if Global.in_menu == false:
		velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down") * SPEED
	
		if Input.is_action_just_pressed("interact") and Global.can_interact:
			interaction.interact()
	
	if Global.can_interact == true and Global.in_menu == false:
		$CanvasLayer/interaction_indicator.visible = true
	else:
		$CanvasLayer/interaction_indicator.visible = false
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.can_interact = true
	interaction = area
	


func _on_area_2d_area_exited(area: Area2D) -> void:
	Global.can_interact = false
