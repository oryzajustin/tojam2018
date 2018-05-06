extends KinematicBody2D

# Constants
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)

# Variables
var speed = 0
var velocity = Vector2(0, 0)
var direction = Vector2(0, 0)
var is_dead = false
var is_stunned = false
var is_flag_holder = false
var flag = null

# Player stats/gear
export var MAX_SPEED = 300
export var MAX_TRAP = 1
export var MAX_SHURIKEN = 1
export var curr_num_trap = 1
export var curr_num_shuriken = 1

onready var parent = get_owner()
onready var player = get_node("Sprite")
onready var anim = get_node("AnimationPlayer")
onready var shuriken = preload("res://Scenes/shuriken.tscn")
onready var shuriken_container = get_node("Shuriken Container")
onready var shuriken_timer = get_node("Shuriken Timer")
onready var trap = preload("res://Scenes/trap.tscn")
onready var trap_container = get_node("Trap Container")
onready var trap_timer = get_node("Trap Timer")
onready var death_timer = get_node("Death Timer")
onready var stun_timer = get_node("Stun Timer")
onready var zap_sound = get_node("zap")
onready var throw_sound = get_node("throw")

func _ready():
	# Play spawning animation
	anim.play("spawn")
	# Hacky fix for the way the ninjas spawn...
	direction = DOWN
	set_physics_process(true)

func _process(delta):
	if Input.is_action_just_released(parent.getActionThrowShurikenKey()):
		animation(direction, speed)
	if is_stunned and stun_timer.get_time_left() == 0:
		print("Player is stunned... but now free!!!")
		is_stunned = false
		anim.play("idle_down")
	if !is_dead and !is_stunned:
		if Input.is_action_pressed(parent.getActionThrowShurikenKey()):
			if shuriken_timer.get_time_left() == 0:
				throw_shuriken()
		if Input.is_action_pressed(parent.getActionPlaceTrapKey()):
			if trap_timer.get_time_left() == 0:
				place_trap()
	if is_dead:
		if death_timer.get_time_left() == 0:
			respawn()

func _physics_process(delta):
	if !is_dead and !is_stunned:
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
		throw_sound.play()
		shuriken_timer.start()
		var s = shuriken.instance()
		shuriken_container.add_child(s)
		if direction == UP:
			anim.play("player_throw_up")
			s.start_at(3 * PI/2, get_node("Up").global_position)
		elif direction == DOWN:
			anim.play("player_throw_down")
			s.start_at(PI/2, get_node("Down").global_position)
		elif direction == LEFT:
			anim.play("player_throw_left")
			s.start_at(PI, get_node("Left").global_position)
		elif direction == RIGHT:
			anim.play("player_throw_right")
			s.start_at(2 * PI, get_node("Right").global_position)
	
		

func pickup_shuriken(pickup):
	print("Going to try to pick up shuriken")
	if curr_num_shuriken < MAX_SHURIKEN:
		print("Picked up shuriken!!")
		var pickup_sound = get_node("pickup").play()
		curr_num_shuriken += 1
		pickup.queue_free()
		
func place_trap():
	# Check if trap placement is valid location first
	# Play a indicator that player has placed a trap
	if curr_num_trap > 0:
		curr_num_trap -= 1
		trap_timer.start()
		var t = trap.instance()
		trap_container.add_child(t)
		if direction == UP:
			t.set_trap(get_node("Up").global_position)
		elif direction == DOWN:
			t.set_trap(get_node("Down").global_position)
		elif direction == LEFT:
			t.set_trap(get_node("Left").global_position)
		elif direction == RIGHT:
			t.set_trap(get_node("Right").global_position)

func defuse_trap(defused_trap):
	print("Going to try to defuse trap")
	if curr_num_trap < MAX_TRAP:
		print("Defused trap!!")
		curr_num_trap += 1
		defused_trap.queue_free()

func trigger_trap():
	print("Player has triggered trap!!!")
	zap_sound.play()
	stun_timer.start()
	is_stunned = true
	anim.play("player_stun")

func pickup_flag(picked_up_flag):
	var flag_sound = get_node("flag").play()
	is_flag_holder = true
	flag = picked_up_flag

func death():
	print("This guy has died!!! Do respawn...")
	if is_flag_holder:
		flag.dropped()
		is_flag_holder = false
		#flag.global_position = self.get_global_position()
	death_timer.start()
	is_dead = true
	get_node("CollisionPolygon2D").disabled = true
	anim.play("player_death")

func respawn():
	anim.play("idle_down")
	is_dead = false
	get_node("CollisionPolygon2D").disabled = false
	# Reset inventory
	curr_num_shuriken = 1
	curr_num_trap = 1
	# Need to get node positions from global variables...
	self.global_position = Vector2(320, 320)
