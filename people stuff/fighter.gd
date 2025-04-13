extends ProgressBar

@export var opponent: Node
@export var healthbar: ProgressBar

var health = 100
var blockcheck = 40
var agro_check = 10


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func attacked(dmg):
	
	if randf_range(0,100) <= agro_check:
		attempt_parry()
	elif randf_range(0,100) <= blockcheck:
		pass
	else:
		health -= dmg
		if health <= 0:
			die()
		else:
			healthbar.value = health

func attack():
	pass
	

func attempt_parry():
	pass

func die():
	pass
