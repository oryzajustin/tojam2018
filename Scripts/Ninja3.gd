extends Node2D

# Variables
onready var ACTION_UP = "ninja3_up"
onready var ACTION_DOWN = "ninja3_down"
onready var ACTION_LEFT = "ninja3_left"
onready var ACTION_RIGHT = "ninja3_right"
onready var ACTION_THROW_SHURIKEN = "ninja3_throw_shuriken"
onready var ACTION_PLACE_TRAP = "ninja3_place_trap"
signal player3_death

func updateScore():
	global.player3_score += 10
	
func getRespawnLocation():
	return global.spawn3
	
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
	emit_signal("player3_death")
