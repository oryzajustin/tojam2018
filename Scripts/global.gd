extends Node

var player1_score = 0
var player2_score = 0
var player3_score = 0
var player4_score = 0

var spawn1 = Vector2(250, 200)
var spawn2 = Vector2(1250, 200)
var spawn3 = Vector2(650, 200)
var spawn4 = Vector2(1250, 650)

func _process(delta):
	get_node("/root/Node2D/GUI/Scores/Player 1 Score").set_text(str(player1_score))
	get_node("/root/Node2D/GUI/Scores/Player 2 Score").set_text(str(player2_score))
	get_node("/root/Node2D/GUI/Scores/Player 3 Score").set_text(str(player3_score))
	get_node("/root/Node2D/GUI/Scores/Player 4 Score").set_text(str(player4_score))