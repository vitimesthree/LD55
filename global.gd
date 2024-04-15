extends Node

var prompt : int = 0
var clue : String = ''
var required_demon: String = ''
var score : int = 0
var demon_hex = "ffffff"

@onready var window_size: Vector2 = get_window().size
var window_scale: int = 1
const max_scale: int = 4
var is_fullscreen: bool = false

# Parts stored as mini-arrays [0,1]
# 0 is the part type (head, body, etc)
# 1 is the demon type (devil, bird, etc)
var parts_collected : Array = []

var ghost : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("window_size"):
		if window_scale < max_scale:
			window_scale = window_scale + 1
		else:
			window_scale = 1
		get_window().size = window_size * window_scale
	if event.is_action_pressed("fullscreen"):
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			is_fullscreen = false
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			is_fullscreen = true
