extends Node2D

onready var anim = get_node("AnimationPlayer")

var current_flag_holder = null
var flag_active = false
var flag_spawn_position = Vector2()
onready var drop_timer = get_node("Drop Timer")

func _ready():
	anim.play("flag_wiggle")
	flag_spawn_position = self.get_global_position()

func _process(delta):
	if flag_active:
		self.global_position = current_flag_holder.get_global_position()
	else:
		if drop_timer.get_time_left() == 0:
			self.global_position = flag_spawn_position

func dropped():
	print("Flag was dropped!!!")
	drop_timer.start()
	flag_active = false
	current_flag_holder = null

func _on_Pickup_Area_body_entered(body):
	if body.is_in_group("players"):
		body.pickup_flag(self)
		current_flag_holder = body
		flag_active = true

func _on_Pickup_Area_body_exited(body):
	if body.is_in_group("players"):
		body.flag_stolen()
