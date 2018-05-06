extends Node2D

func _ready():
	global.spawn1 = get_node("Map/Spawn1").get_global_position()
	global.spawn2 = get_node("Map/Spawn2").get_global_position()
	global.spawn3 = get_node("Map/Spawn3").get_global_position()
	global.spawn4 = get_node("Map/Spawn4").get_global_position()

func _process(delta):
	if get_tree().get_current_scene().get_name() == "Main Menu":
		self.queue_free()