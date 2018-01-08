extends KinematicBody2D
#AI Enemy
var wait_time = 0.0
var end_time = 0.1
var destroy_time = 0.17

func _ready():
	set_process(true)
	pass

func _process(delta):
	#Gravity
	move(Vector2(0,15))
	#SimpleMovement
	translate(Vector2(-1,0))
	
	if self.is_colliding():
		if self.get_collider().get_name() == "bullet(Clone)":
			#print (self.get_collider().get_name())
			wait_time += delta
			print ("Hit")
			if wait_time > end_time:
				get_node("CollisionShape2D").set_trigger(true)
				if wait_time >= destroy_time:
					destroy()

func destroy():
    queue_free()