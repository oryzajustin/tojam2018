extends KinematicBody2D

# Constants
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const MAX_SPEED = 300
const MAX_TRAP = 2
const MAX_SHURIKEN = 3

# Variables
var speed = 0
var velocity = Vector2()
var direction = Vector2()

# Player inventory on spawn
var curr_num_trap = 1
var curr_num_shuriken = 1

onready var parent = get_owner()
onready var player = get_node("Sprite")

###
onready var anim = get_node("AnimationPlayer")
###

onready var shuriken = preload("res://Scenes/shuriken.tscn")
onready var shuriken_container = get_node("Shuriken Container")
onready var shuriken_timer = get_node("Shuriken Timer")
onready var trap = preload("res://Scenes/trap.tscn")
onready var trap_container = get_node("Trap Container")
onready var trap_timer = get_node("Trap Timer")

func _ready():
	set_physics_process(true)

func _process(delta):
	if Input.is_action_pressed(parent.getActionThrowShurikenKey()):
		if shuriken_timer.get_time_left() == 0:
			throw_shuriken()
	if Input.is_action_pressed(parent.getActionPlaceTrapKey()):
		if trap_timer.get_time_left() == 0:
			place_trap()

func _physics_process(delta):
	if Input.is_action_pressed(parent.getActionUpKey()):
		speed = MAX_SPEED
		direction = UP
	elif Input.is_action_pressed(parent.getActionDownKey()):
		speed = MAX_SPEED
		direction = DOWN
	elif Input.is_action_pressed(parent.getActionLeftKey()):
		speed = MAX_SPEED
		direction = LEFT
	elif Input.is_action_pressed(parent.getActionRightKey()):
		speed = MAX_SPEED
		direction = RIGHT
	else:
		speed = 0
	velocity = speed * direction * delta
	if Input.is_action_just_pressed(parent.getActionRightKey()) or Input.is_action_just_released(parent.getActionRightKey()) or Input.is_action_just_pressed(parent.getActionLeftKey()) or Input.is_action_just_released(parent.getActionLeftKey()) or Input.is_action_just_pressed(parent.getActionUpKey()) or Input.is_action_just_released(parent.getActionUpKey()) or Input.is_action_just_pressed(parent.getActionDownKey()) or Input.is_action_just_released(parent.getActionDownKey()):
		animation(direction, speed)
	move_and_collide(velocity)
	
func animation(dir, speed):
	if dir == LEFT and speed != 0:
		anim.play("walk_left")
	elif dir == LEFT and speed == 0:
		anim.play("idle_left")
		
	if dir == RIGHT and speed != 0:
		anim.play("walk_right")
	elif dir == RIGHT and speed == 0:
		anim.play("idle_right")
		
	if dir == DOWN and speed != 0:
		anim.play("walk_down")
	elif dir == DOWN and speed == 0:
		anim.play("idle_down")
		
	if dir == UP and speed != 0:
		anim.play("walk_up")
	elif dir == UP and speed == 0:
		anim.play("idle_up")
	
func throw_shuriken():
	if curr_num_shuriken > 0:
		curr_num_shuriken -= 1
		shuriken_timer.start()
		var s = shuriken.instance()
		shuriken_container.add_child(s)
		s.start_at(rotation, get_node("Throw Start").global_position)

func pickup_shuriken(pickup):
	print("Going to try to pick up shuriken")
	if curr_num_shuriken < MAX_SHURIKEN:
		print("Picked up shuriken!!")
		curr_num_shuriken += 1
		pickup.queue_free()
		
func place_trap():
	if curr_num_trap > 0:
		curr_num_trap -= 1
		trap_timer.start()
		var t = trap.instance()
		trap_container.add_child(t)
		t.set_trap(position)

func defuse_trap(defused_trap):
	print("Going to try to defuse trap")
	if curr_num_trap < MAX_TRAP:
		print("Defused trap!!")
		curr_num_trap += 1
		defused_trap.queue_free()

func death():
	print("This guy has died!!! Do respawn...")
	get_node("CollisionPolygon2D").disabled = true
	# Teleport to jail instead of deleting...
	anim.play("player_death")
