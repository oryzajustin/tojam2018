extends Node2D

var visible_player_counter = 0
var defused = false
var defuser = null
onready var defuse_timer = get_node("Defuse Timer")

func _ready():
	pass

func _process(delta):
	if defused and defuse_timer.get_time_left() == 0:
		defuser.defuse_trap(self)
	
func set_trap(pos):
	position = pos

func _on_Trigger_Radius_body_entered(body):
	if body.is_in_group("players"):
			body.trigger_trap()
			self.queue_free()

func _on_Defuse_Radius_body_entered(body):
	if body.is_in_group("players"):
		defused = true
		defuser = body
		defuse_timer.start()


func _on_Defuse_Radius_body_exited(body):
	if body.is_in_group("players"):
		defused = false
		defuser = null
		defuse_timer.stop()


func _on_Visible_Radius_body_entered(body):
	if body.is_in_group("players"):
		visible_player_counter += 1
		self.show()


func _on_Visible_Radius_body_exited(body):
	if body.is_in_group("players"):
		if visible_player_counter > 0:
			visible_player_counter -= 1
		if visible_player_counter == 0:
			self.hide()
