extends MarginContainer

func _ready():
	get_node("VBoxContainer/Text/VBoxContainer/Win Text").hide()
	get_node("VBoxContainer/Text/VBoxContainer/Restart").hide()

func _process(delta):
	if !global.gameover:
		get_node("VBoxContainer/Scores/Player 1 Score").set_text(str(global.player1_score))
		get_node("VBoxContainer/Scores/Player 2 Score").set_text(str(global.player2_score))
		get_node("VBoxContainer/Scores/Player 3 Score").set_text(str(global.player3_score))
		get_node("VBoxContainer/Scores/Player 4 Score").set_text(str(global.player4_score))
	else:
		get_node("VBoxContainer/Scores/").hide()
		get_node("VBoxContainer/Text/VBoxContainer/Win Text").show()
		get_node("VBoxContainer/Text/VBoxContainer/Winner").set_text(str(global.winner))
		get_node("VBoxContainer/Text/VBoxContainer/Restart").show()
