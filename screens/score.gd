extends Node2D

@onready var smarts : int = 0
@onready var next_scene : String = "res://screens/tutorial.tscn"
@onready var score_table : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	make_score_table()
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
	var prompt = Global.prompt
	var collected = Global.parts_collected
	
	# Gets the index number for which Demon is the Best
	var prompt_index = score_table[prompt]
	
	for r in range(0,6):
		var current = collected[r]
		
		# Gets the demon type of the current part
		var which_demon = current[1]
		var demon_index = 0
		
		match which_demon:
			"devil": demon_index = 0
			"bird": demon_index = 1
			"horror": demon_index = 2
			"crab": demon_index = 3
		
		# Adds score based on how much the current demon type
		# is worth, based on the tutorial clue
		var add_score = prompt_index[demon_index]
		smarts += add_score
		print(smarts)

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

func make_score_table():
	# Prompt: Devil
	score_table.append([1000, 200, 450, 100])
	
	# Prompt: Bird
	score_table.append([50, 1000, 200, 650])
	
	# Prompt: Horror
	score_table.append([400, 250, 1000, 100])
	
	# Prompt: Crab
	score_table.append([100, 350, 500, 1000])
