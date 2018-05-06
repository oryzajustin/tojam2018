extends MarginContainer

onready var bg_song = get_node("gui_background")

func _ready():
	bg_song.play()

func _process(delta):
	if get_tree().get_current_scene().get_name() != "Main Menu":
		self.queue_free()
	
func _on_2_Players_pressed():
	global.current_scene_name = "Two Player Map"
	get_tree().change_scene(global.two_player_scene_path)

func _on_3_Players_pressed():
	global.current_scene_name = "Three Player Map"
	get_tree().change_scene(global.three_player_scene_path)

func _on_4_Players_pressed():
	global.current_scene_name = "Four Player Map"
	get_tree().change_scene(global.four_player_scene_path)