extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var anim = get_node("AnimationPlayer")

func _ready():
	anim.play("explosion")
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
