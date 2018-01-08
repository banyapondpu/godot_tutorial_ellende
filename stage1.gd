extends Node2D
var enemy = preload("res://Enemy.xml") 

var sp_random

func _ready():
	set_process(true)
	pass

func _process(delta):
	sp_random = global.random_spawn
	if sp_random == 199:
		var enemy_instance = enemy.instance()
		enemy_instance.set_name("enemy(Clone)")
		get_node("Node2D-Spawn").add_child(enemy_instance)
	pass
