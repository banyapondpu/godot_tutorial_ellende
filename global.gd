extends Node2D
var global_direction = 0
var random_spawn = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	random_spawn = randi() % 300
	pass