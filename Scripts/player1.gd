extends KinematicBody2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 350

var speed = 0
var rot = 0
var velocity = Vector2()
var direction = Vector2()
onready var player = get_node("Sprite")
onready var shuriken = preload("res://Scenes/shuriken.tscn")
onready var shuriken_container = get_node("shuriken_container")

func _ready():
	set_physics_process(true)

func _process(delta):
	if Input.is_action_pressed("player1_throw"):
		throw()

func _physics_process(delta):
	var is_moving = Input.is_action_pressed("player1_checkmove")
	if is_moving:
		speed = MAX_SPEED
		if Input.is_action_pressed("player1_up"):
			direction = UP
			rot = rot * delta
		elif Input.is_action_pressed("player1_down"):
			direction = DOWN
		elif Input.is_action_pressed("player1_left"):
			direction = LEFT
		elif Input.is_action_pressed("player1_right"):
			direction = RIGHT
	else:
		speed = 0
	
	rotation = rot
	velocity = speed * direction * delta
	move_and_collide(velocity)

func throw():
	var s = shuriken.instance()
	shuriken_container.add_child(s)
	s.start_at(rotation, get_node("throw_start").global_position)
