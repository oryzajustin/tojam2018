extends Node2D

var magnitude = 8
var time = 0
var duration = 0.2

onready var camera = get_node("camera")

func _ready():
	if global.current_scene_name == "Two Player Map":
		global.spawn1 = get_node("Map/Spawn1").get_global_position()
		global.spawn4 = get_node("Map/Spawn4").get_global_position()
	elif global.current_scene_name == "Four Player Map":
		global.spawn1 = get_node("Map/Spawn1").get_global_position()
		global.spawn2 = get_node("Map/Spawn2").get_global_position()
		global.spawn3 = get_node("Map/Spawn3").get_global_position()
		global.spawn4 = get_node("Map/Spawn4").get_global_position()

func _process(delta):
	if get_tree().get_current_scene().get_name() == "Main Menu":
		self.queue_free()

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


