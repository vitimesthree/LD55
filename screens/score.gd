extends Node2D

@onready var smarts : int = 0
@onready var next_scene : String = "res://screens/tutorial.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Clue.text = Global.clue
	
	calculate_score()
	$Score.text = str(smarts)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene_to_file(next_scene)

func calculate_score():
	var prompt = Global.required_demon
	var collected = Global.parts_collected
	
	for r in range(0,6):
		var current = collected[r]
		if current[1] == prompt:
			smarts += 1000
		else:
			smarts += 500

	if(smarts == 6000):
		smarts = 999999
		$Perfect.visible = true
		next_scene = "res://screens/good_ending.tscn"
	elif(smarts >= 3500):
		$Good.visible = true
		next_scene = "res://screens/good_ending.tscn"
	else:
		$Fail.visible = true
		next_scene = "res://screens/bad_ending.tscn"
