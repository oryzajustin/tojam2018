extends KinematicBody2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 300
const MAX_TRAP = 2

var speed = 0
var velocity = Vector2()
var direction = Vector2()
var curr_num_trap = 0

onready var player = get_node("Sprite")
onready var shuriken = preload("res://Scenes/shuriken.tscn")
onready var shuriken_container = get_node("shuriken_container")
onready var trap = preload("res://Scenes/trap.tscn")
onready var trap_container = get_node("trap_container")
onready var shuriken_timer = get_node("shuriken_timer")
onready var trap_timer = get_node("trap_timer")
onready var hitbox = get_node("hitbox")

func _ready():
	set_physics_process(true)

func _process(delta):
	if Input.is_action_pressed("test_throw"):
		if shuriken_timer.get_time_left() == 0:
			throw()
	if Input.is_action_pressed("test_trap"):
		if trap_timer.get_time_left() == 0:
			place_trap()
			curr_num_trap += 1
			print(curr_num_trap)

func _physics_process(delta):
	speed = MAX_SPEED
	if Input.is_action_pressed("test_up"):
		direction = UP
		rotation = 3 * PI/2
	elif Input.is_action_pressed("test_down"):
		direction = DOWN
		rotation = PI/2
	elif Input.is_action_pressed("test_left"):
		direction = LEFT
		rotation = PI
	elif Input.is_action_pressed("test_right"):
		direction = RIGHT
		rotation = 2 * PI
	else:
		speed = 0
	velocity = speed * direction * delta
	move_and_collide(velocity)

func place_trap():
	if curr_num_trap < MAX_TRAP:
		trap_timer.start()
		var t = trap.instance()
		trap_container.add_child(t)
		t.set_trap(position)

func throw():
	shuriken_timer.start()
	var s = shuriken.instance()
	shuriken_container.add_child(s)
	s.start_at(rotation, get_node("throw_start").global_position)
	
func death():
	print("This guy has died!!! Do respawn...")
	# Teleport to jail instead of deleting...
	self.queue_free()
