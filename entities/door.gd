extends Area2D

var player_touch : bool = false

# For calculating score in advance
@onready var smarts : int = 0
@onready var score_table : Array = []
@onready var next_scene : String = "res://screens/tutorial.tscn"

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	player_touch = true

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	player_touch = false
	
func _input(event):
	if Input.is_action_just_pressed("jump"):
		if Global.parts_collected.size() == 6 && player_touch == true:
			calculate_score()
			get_tree().change_scene_to_file(next_scene)

func calculate_score():
	make_score_table()
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
	Global.score = smarts
	
	if(smarts >= 3500):
		next_scene = "res://screens/good_ending.tscn"
	else:
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
