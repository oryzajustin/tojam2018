extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var song1 = get_node("bg")
onready var song2 = get_node("bg2")
onready var song3 = get_node("bg3")

var songs = []

func _ready():
	songs.append(song1)
	songs.append(song2)
	songs.append(song3)
	randomize()
	var random = int(floor(rand_range(0, 3)))
	songs[random].play()