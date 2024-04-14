extends Node2D

@onready var label: Node = $Demon

const devil: Array = ['Brimstone', 'Horns & Pitchfork', 'Sinful']
const bird: Array = ['Sky Reign', 'Molting Beak', 'Wing of Night']
const horror: Array = ['Home Intruder', 'Starved', 'Lanky Freak']
const crab: Array = ['Cancer', 'Dredge of the Deep', 'Smell of Seafoam']
const demons: Array = [devil, bird, horror, crab]

# Called when the node enters the scene tree for the first time.
func _ready():
	var demon: Array = demons.pick_random()
	match demon:
		devil: 
			Global.required_demon = "devil"
			Global.prompt = 0
		bird: 
			Global.required_demon = "bird"
			Global.prompt = 1
		horror: 
			Global.required_demon = "horror"
			Global.prompt = 2
		crab: 
			Global.required_demon = "crab"
			Global.prompt = 3
	label.text = str(demon.pick_random())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene_to_file('res://main.tscn')
