extends Node
class_name fighter

@export var opponent: Node
@export var healthbar: ProgressBar


var agro_check = 10

@export var stat_res: Resource

func _ready() -> void:
	healthbar.value = stat_res.health

func attacked(dmg, speed):
	if (randf_range(0,100) + speed) <= stat_res.agility:
		attempt_counter()
	elif randf_range(0,100) <= stat_res.agility:
		pass
	else:
		
		
		
		stat_res.health -= dmg
		if stat_res.health <= 0:
			die()
		else:
			healthbar.value = stat_res.health

func attack():
	opponent.attacked(stat_res.damage, stat_res.attack_speed)
	#opponent.attacked(10, stat_res.attack_speed)
	

func attempt_counter():
	attack()

func die():
	get_tree().change_scene_to_file("res://world/main.tscn")
