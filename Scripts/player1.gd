extends KinematicBody2D

const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 250
const MAX_TRAP = 2

var speed = 0
var idle = true
var velocity = Vector2()
var direction = Vector2()
var curr_num_trap = 0

onready var player = get_node("Sprite")
onready var animation_player = get_node("Sprite/AnimationPlayer")
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
	if Input.is_action_pressed("player1_throw"):
		if shuriken_timer.get_time_left() == 0:
			throw()
	if Input.is_action_pressed("player1_trap"):
		if trap_timer.get_time_left() == 0:
			place_trap()
			curr_num_trap += 1
			print(curr_num_trap)

func _physics_process(delta):
	if Input.is_action_pressed("player1_up"):
		speed = MAX_SPEED
		direction = UP
		idle = false
		#rotation = 3 * PI/2
	elif Input.is_action_pressed("player1_down"):
		speed = MAX_SPEED
		direction = DOWN
		idle = false
		#rotation = PI/2
	elif Input.is_action_pressed("player1_left"):
		speed = MAX_SPEED
		direction = LEFT
		idle = false
		#rotation = PI
	elif Input.is_action_pressed("player1_right"):
		speed = MAX_SPEED
		direction = RIGHT
		#idle = false
		#rotation = 2 * PI
	else:
		speed = 0
		idle = true
	#idle(direction, idle)
	velocity = speed * direction * delta
	if Input.is_action_just_pressed("player1_right") or Input.is_action_just_released("player1_right") or Input.is_action_just_pressed("player1_left") or Input.is_action_just_released("player1_left") or Input.is_action_just_pressed("player1_up") or Input.is_action_just_released("player1_up") or Input.is_action_just_pressed("player1_down") or Input.is_action_just_released("player1_down"):
		animation(direction, speed)
	move_and_collide(velocity) 

func animation(dir, speed):
	if dir == LEFT and speed != 0:
		animation_player.play("walk_left")
	elif dir == LEFT and speed == 0:
		animation_player.play("idle_left")
	if dir == RIGHT and speed != 0:
		animation_player.play("walk_right")
	elif dir == RIGHT and speed == 0:
		animation_player.play("idle_right")
	if dir == UP and speed != 0:
		animation_player.play("walk_up")
	elif dir == UP and speed == 0:
		animation_player.play("idle_up")
	if dir == DOWN and speed != 0:
		animation_player.play("walk_down")
	elif dir == DOWN and speed == 0:
		animation_player.play("idle_down")

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
