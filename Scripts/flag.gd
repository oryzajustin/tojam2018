extends Node2D

var current_holder = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if current_holder != null:
		self.global_position = current_holder.get_global_position()

func dropped():
	current_holder = null

func _on_Pickup_Area_body_entered(body):
	if body.is_in_group("players"):
		body.pickup_flag(self)
		current_holder = body
