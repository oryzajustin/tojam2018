extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 350

var speed = 0
var velocity = Vector2()
var direction = Vector2()


func _ready():
	set_physics_process(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var is_moving = Input.is_action_pressed("player1_checkmove")
	if is_moving:
		speed = MAX_SPEED
		if Input.is_action_pressed("player1_up"):
			direction = UP
		elif Input.is_action_pressed("player1_down"):
			direction = DOWN
		elif Input.is_action_pressed("player1_left"):
			direction = LEFT
		elif Input.is_action_pressed("player1_right"):
			direction = RIGHT
	else:
		speed = 0
	
	velocity = speed * direction * delta
	move_and_collide(velocity)
	
