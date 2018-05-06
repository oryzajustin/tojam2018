extends KinematicBody2D

var velocity = Vector2(0, 0)
export var speed = 400

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: # True after collision
		if collision_info.collider.is_in_group("players"):
			# Could do a screen shake here
			var onhit = get_node("onhit").play()
			collision_info.collider.death()
			# Projectile continues flying
			velocity = Vector2(speed, 0).rotated(rotation)
		else:
			var stuck_sound = get_node("stuck").play()
			velocity = Vector2(0, 0) # Stop shuriken movement
			get_node("CollisionPolygon2D").disabled = true # Allow players to move through stopped shuriken (if they can't pick up)

func start_at(dir, pos):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)

func _on_Pickup_Radius_body_entered(body):
	if velocity == Vector2(0, 0): # Check if shuriken is stationary
		if body.is_in_group("players"):
			body.pickup_shuriken(self)

