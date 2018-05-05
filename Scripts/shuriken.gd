extends Area2D

var vel = Vector2()
export var speed = 300


func _ready():
	set_physics_process(true)

func _physics_process(delta):
	position = position + vel * delta

func start_at(dir, pos):
	rotation = dir
	position = pos
	vel = Vector2(speed, 0).rotated(dir)
