extends Node2D

# Variables
onready var ACTION_UP = "ninja4_up"
onready var ACTION_DOWN = "ninja4_down"
onready var ACTION_LEFT = "ninja4_left"
onready var ACTION_RIGHT = "ninja4_right"
onready var ACTION_THROW_SHURIKEN = "ninja4_throw_shuriken"
onready var ACTION_PLACE_TRAP = "ninja4_place_trap"

func updateScore():
	global.player4_score += 10
	
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
