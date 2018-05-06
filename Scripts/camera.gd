extends Node2D

var magnitude = 8
var time = 0
var duration = 0.2

onready var camera = get_node("camera")

func shake():
	print("shake")
	while time < duration:
		time += get_process_delta_time()
		
		var offset = Vector2()
		randomize()
		offset.x = rand_range(-magnitude, magnitude)
		offset.y = rand_range(-magnitude, magnitude)
		camera.set_offset(offset)
		
		yield(get_tree(), "idle_frame")
	time = 0
