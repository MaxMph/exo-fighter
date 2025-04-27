extends Node

@onready var player: CharacterBody2D
@onready var screenshake: Node

var in_menu = false
var can_interact = false
var can_walk = true

var money = 0
