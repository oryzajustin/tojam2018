extends KinematicBody2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 300

var speed = 0
var velocity = Vector2()
var direction = Vector2()

onready var player = get_node("Sprite")
onready var shuriken = preload("res://Scenes/shuriken.tscn")
onready var shuriken_container = get_node("shuriken_container")
onready var shuriken_timer = get_node("shuriken_timer")
onready var hitbox = get_node("hitbox")

func _ready():
	set_physics_process(true)

func _process(delta):
	if Input.is_action_pressed("player1_throw"):
		if shuriken_timer.get_time_left() == 0:
			throw()

func _physics_process(delta):
	speed = MAX_SPEED
	if Input.is_action_pressed("player1_up"):
		direction = UP
		rotation = 3 * PI/2
	elif Input.is_action_pressed("player1_down"):
		direction = DOWN
		rotation = PI/2
	elif Input.is_action_pressed("player1_left"):
		direction = LEFT
		rotation = PI
	elif Input.is_action_pressed("player1_right"):
		direction = RIGHT
		rotation = 2 * PI
	else:
		speed = 0
	velocity = speed * direction * delta
	move_and_collide(velocity)

func throw():
	shuriken_timer.start()
	var s = shuriken.instance()
	shuriken_container.add_child(s)
	s.start_at(rotation, get_node("throw_start").global_position)
