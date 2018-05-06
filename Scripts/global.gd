extends Node

# Global file holds global variables and handles scene switching

# Constants
const MAX_SCORE = 10

# Variables
var current_scene_name = null
var gameover = false
var winner = null
var player1_score = 0
var player2_score = 0
var player3_score = 0
var player4_score = 0

# Corner spawns
var spawn1 = null
var spawn2 = null
var spawn3 = null
var spawn4 = null

# Scenes
var two_player_scene_path = "res://Scenes/main.tscn"
var three_player_scene_path = "res://Scenes/main.tscn"
var four_player_scene_path = "res://Scenes/main.tscn"

func _ready():
	current_scene_name = "Main Menu"
	
func _process(delta):
	# Check what the current scene is
	if current_scene_name != "Main Menu":
		if !gameover:
			if player1_score >= MAX_SCORE:
				winner = "Player 1"
				gameover = true
			if player2_score >= MAX_SCORE:
				winner = "Player 2"
				gameover = true
			if player3_score >= MAX_SCORE:
				winner = "Player 3"
				gameover = true
			if player4_score >= MAX_SCORE:
				winner = "Player 4"
				gameover = true
		else:
			if Input.is_action_pressed("restart"):
				print("Press restart!!")
				current_scene_name = "Main Menu"
				gameover = false
				winner = null
				player1_score = 0
				player2_score = 0
				player3_score = 0
				player4_score = 0
				get_tree().change_scene("res://GUI/MainMenu.tscn")