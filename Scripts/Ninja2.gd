extends Node2D

# Variables
onready var ACTION_UP = "ninja2_up"
onready var ACTION_DOWN = "ninja2_down"
onready var ACTION_LEFT = "ninja2_left"
onready var ACTION_RIGHT = "ninja2_right"
onready var ACTION_THROW_SHURIKEN = "ninja2_throw_shuriken"
onready var ACTION_PLACE_TRAP = "ninja2_place_trap"
signal player2_death

func updateScore():
	global.player2_score += 10
	
func getRespawnLocation():
	return global.spawn2
	
func getActionUpKey():
	return ACTION_UP

func getActionDownKey():
	return ACTION_DOWN
	
func getActionLeftKey():
	return ACTION_LEFT

func getActionRightKey():
	return ACTION_RIGHT

func getActionThrowShurikenKey():
	return ACTION_THROW_SHURIKEN

func getActionPlaceTrapKey():
	return ACTION_PLACE_TRAP


func _on_Player_died():
	emit_signal("player2_death")
