extends Node2D

onready var camera = get_node("Camera2D")
var magnitude = 60
var duration = 1.5
var time = 0

func _ready():
	var bg = get_node("bg").play()
	shake()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func shake():
	while time < duration:
		time += get_process_delta_time()
		
		var offset = Vector2()
		randomize()
		offset.x = rand_range(-magnitude, magnitude)
		offset.y = rand_range(-magnitude, magnitude)
	camera.set_offset(offset)
		
		yield(get_tree(), "idle_frame")
	time = 0