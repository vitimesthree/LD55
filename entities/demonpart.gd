extends Node2D

@export var part_type : String = "body"
@export var demon_type : String = "devil"

@onready var init_pos : Vector2
@onready var offset : float = -0.01
@onready var animator : AnimatedSprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# debug
	createPart()
	init_pos = position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += offset
	
	if(position.y <= (init_pos.y - 1)):
		offset = 0.01
	if(position.y >= (init_pos.y + 1)):
		offset = -0.01
	print(position.y)
	pass

# Type: 0 = Devil, 1 = Bird, 2 = Horror, 3 = Crab
# Part: 0 = body, 1 = head, 2 = left arm, 3 = right arm, 4 = left leg, 5 = right leg
func createPart(type = 0, part = 0):
	match part:
		0:
			part_type = "body"
			animator.play("bodies")
		1:
			part_type = "head"
			animator.play("heads")
		2:
			part_type = "arm_l"
			animator.play("arms_l")
		3:
			part_type = "arm_r"
			animator.play("arms_r")
		4:
			part_type = "leg_l"
			animator.play("legs_l")
		5:
			part_type = "leg_r"
			animator.play("legs_r")
	match type:
		0:
			demon_type = "devil"
			animator.frame = 0
		1:
			demon_type = "bird"
			animator.frame = 1
		2:
			demon_type = "horror"
			animator.frame = 2
		3:
			demon_type = "crab"
			animator.frame = 3
	animator.pause()
