extends Node2D

@onready var smarts : int = 0
@onready var next_scene : String = "res://screens/tutorial.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Clue.text = Global.clue
	$Clue.set("theme_override_colors/font_color",Color(Global.demon_hex))
	
	smarts = Global.score
	$Score.text = str(smarts)
	set_next_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("jump"):
		get_tree().change_scene_to_file(next_scene)

func set_next_scene():
	if(smarts == 999999):
		$Perfect.visible = true
		next_scene = "res://screens/end_screen.tscn"
	elif(smarts >= 3500):
		$Good.visible = true
		next_scene = "res://screens/tutorial.tscn"
	else:
		$Fail.visible = true
		next_scene = "res://screens/tutorial.tscn"

