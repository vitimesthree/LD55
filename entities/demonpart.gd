extends Node2D

@export var part_type : String = "body"
@export var demon_type : String = "devil"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Type: 0 = Devil, 1 = Bird, 2 = Horror, 3 = Crab
# Part: 0 = body, 1 = head, 2 = left arm, 3 = right arm, 4 = left leg, 5 = right leg
func createPart(type = 0, part = 0):
	match part:
		0:
			part_type = "body"
		1:
			part_type = "head"
		2:
			part_type = "arm_l"
		3:
			part_type = "arm_r"
		4:
			part_type = "leg_l"
		5:
			part_type = "leg_r"
	match type:
		0:
			demon_type = "devil"
		1:
			demon_type = "bird"
		2:
			demon_type = "horror"
		3:
			demon_type = "crab"

	
	
