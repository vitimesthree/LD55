extends Node2D

@onready var frame: Node2D = $Frame
@onready var timer: Node = $Timer
@onready var music: Node = $Music
var fade_speed: float = 5

@export var music_stream : AudioStream = null
@export var starting_frame: int = 0
@export var ending_frame: int = 1
@export var next_scene: String = ''
@export var the_end: bool = false
var fade: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	frame.frame = starting_frame
	if music_stream != null:
		music.stream = music_stream
		music.play()
	frame.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# If fading is off then unfade.
	if fade == false:
		frame.modulate.a = clamp(frame.modulate.a + (fade_speed * delta), 0, 1)
	# If fading is on then fade.
	else:
		frame.modulate.a = clamp(frame.modulate.a - (fade_speed * delta), 0, 1)
	
	# Finally check if we can go to the next frame.
	if frame.modulate.a == 0:
		fade = false
		frame.frame = frame.frame + 1
	
	if the_end:
		if frame.frame == ending_frame:
			timer.stop()
		if Input.is_action_just_pressed("jump"):
			get_tree().change_scene_to_file(next_scene)
	else:
		if frame.frame == ending_frame:
			music.volume_db = music.volume_db - 0.1
			
		if frame.frame > ending_frame or Input.is_action_just_pressed("jump"):
			get_tree().change_scene_to_file(next_scene)
func _on_timer_timeout():
	fade = true
