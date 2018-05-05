extends Node2D

# Variables
onready var ACTION_UP = "ninja2_up"
onready var ACTION_DOWN = "ninja2_down"
onready var ACTION_LEFT = "ninja2_left"
onready var ACTION_RIGHT = "ninja2_right"
onready var ACTION_THROW_SHURIKEN = "ninja2_throw_shuriken"
onready var ACTION_PLACE_TRAP = "ninja2_place_trap"

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
