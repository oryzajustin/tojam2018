extends Node2D

var current_holder = null
onready var flag_spawn_position = self.get_global_position()
onready var anim = get_node("AnimationPlayer")

func _ready():
	anim.play("flag_wiggle")

func _process(delta):
	if current_holder != null:
		self.global_position = current_holder.get_global_position()
	else:
		self.global_position = flag_spawn_position

func dropped():
	current_holder = null

func _on_Pickup_Area_body_entered(body):
	if body.is_in_group("players"):
		body.pickup_flag(self)
		current_holder = body


func _on_Pickup_Area_body_exited(body):
	if body.is_in_group("players"):
		body.flag_stolen()
