extends Node2D

@onready var label: Node = $Demon

const devil: Array = ['the beast', 'the thing', 'evil']
const bird: Array = ['the bird', 'the flyer', 'lays']
const horror: Array = ['scary af', 'the horror', 'be afraid']
const crab: Array = ['the crab', 'loves water', 'claws']
const demons: Array = [devil, bird, horror, crab]

# Called when the node enters the scene tree for the first time.
func _ready():
	var demon: Array = demons.pick_random()
	match demon:
		devil: Global.required_demon = "devil"
		bird: Global.required_demon = "bird"
		horror: Global.required_demon = "horror"
		crab: Global.required_demon = "crab"
	label.text = str(demon.pick_random())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene_to_file('res://main.tscn')
