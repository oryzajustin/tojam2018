extends Node2D

# Variables
onready var ACTION_UP = "ninja1_up"
onready var ACTION_DOWN = "ninja1_down"
onready var ACTION_LEFT = "ninja1_left"
onready var ACTION_RIGHT = "ninja1_right"
onready var ACTION_THROW_SHURIKEN = "ninja1_throw_shuriken"
onready var ACTION_PLACE_TRAP = "ninja1_place_trap"

func updateScore():
	global.player1_score += 10

func getRespawnLocation():
	return global.spawn1

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
