extends KinematicBody2D
var bullet = preload("res://bullet.xml") 

var input_direction = 0
var direction = 0
var speed = 0
var velocity = 1

const MAX_SPEED = 600
const ACCELERATION = 1000
const DECELERATION = 2000
const JUMP_FORCE = 20.0

var anim
var isShootPressed = false
var fire_rate = 0.0
var next_fire = 0.5

var jump_rate = 0.0
var next_jump = 0.3

func _ready():
	set_process(true)
	anim = get_node( "AnimatedSprite" )
	pass

func _process(delta):
	#SeT Gravity
	move( Vector2(0,10))
	
	#Input
	if input_direction:
		direction = input_direction
		global.global_direction = input_direction
		
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		input_direction = -1
		anim.set_flip_h( true )
		anim.play("walk")		
	elif Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		input_direction = 1
		anim.set_flip_h( false )
		anim.play("walk")		
	else:
		input_direction = 0
		anim.play("idle")
	#Check Fire Animation
	
	# Movement
	if input_direction == - direction:
		speed /= 3

	if input_direction:
		speed += ACCELERATION * delta
	else:
		speed -= DECELERATION * delta

	speed = clamp(speed, 0, MAX_SPEED)	
	velocity = speed * delta * direction
	move(Vector2(velocity, 0))
	
	#Splash Attack
	if Input.is_key_pressed(KEY_X):
		anim.play("attack")
		move(Vector2(20 * input_direction, 0))
	
	#Fire
	if Input.is_key_pressed(KEY_Z):
		anim.play("attack")
		if isShootPressed == false:
			fire()
			isShootPressed = true
	
	#Check FireRate
	fire_rate += delta
	if fire_rate >= next_fire:
		fire_rate = 0.0
		isShootPressed = false	
		anim.play("idle")
	
	#Jump
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W) and jump_rate <= next_jump:
		anim.play("jump")
		#Check FireRate
		jump_rate += delta
		move(Vector2(0, -JUMP_FORCE))
		if jump_rate >= next_jump:
			jump_rate = 0.0
			
	
	if self.is_colliding():
		anim.play("death")
		move(Vector2(10 * -global.global_direction, 0))
        #print (self.get_collider().get_name())
	
func fire():
		var bullet_instance = bullet.instance()
		bullet_instance.set_name("bullet(Clone)")
		get_node("shootArea").add_child(bullet_instance)