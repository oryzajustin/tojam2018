extends KinematicBody2D

var vel = Vector2(0, 0)
export var speed = 380

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var collision_info = move_and_collide(vel * delta)
	if collision_info: # True after collision
		print("Hit something...")
		vel = Vector2(0, 0) # Stop shuriken movement
		if collision_info.collider.is_in_group("players"):
			print("Hit a guy!!!")
			collision_info.collider.death()
			# Could do a screen shake here
			# Projectile should continue
			vel = Vector2(speed, 0).rotated(rotation)

func start_at(dir, pos):
	rotation = dir
	position = pos
	vel = Vector2(speed, 0).rotated(dir)

func _on_Pickup_Radius_body_entered(body):
	if vel == Vector2(0, 0): # Check if shuriken is stationary
		if body.is_in_group("players"):
			body.pickup_shuriken(self)
