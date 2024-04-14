extends Node2D

@onready var pieces : Array = self.get_children()

# Called when the node enters the scene tree for the first time.
func _ready():
	assemble_demon()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func assemble_demon():
	var parts = Global.parts_collected
	for r in range (0,6):
		var current_part = parts[r]
		var part_type = current_part[0]
		var demon_type = current_part[1]
		
		var piece_edited : AnimatedSprite2D
		match part_type:
			"head":
				piece_edited = $Head
			"body":
				piece_edited = $Body
			"arm_l":
				piece_edited = $ArmL
			"arm_r":
				piece_edited = $ArmR
			"leg_l":
				piece_edited = $LegL
			"leg_r":
				piece_edited = $LegR
		piece_edited.play()
		
		match demon_type:
			"devil":
				piece_edited.frame = 0
			"bird":
				piece_edited.frame = 1
			"horror":
				piece_edited.frame = 2
			"crab":
				piece_edited.frame = 3
		piece_edited.pause()
