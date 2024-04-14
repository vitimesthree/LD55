extends Node2D

@onready var smarts : int = 0

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
		get_tree().change_scene_to_file('res://main.gd')

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
	elif(smarts >= 3500):
		$Good.visible = true
	else:
		$Fail.visible = true
