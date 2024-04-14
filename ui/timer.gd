extends Timer

var cut_in_half: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = str("%03d" % time_left)
	if not Global.ghost and not cut_in_half:
		cut_in_half = true
		wait_time = time_left / 2
		start()


func _on_timeout():
	get_tree().change_scene_to_file('res://screens/dead.tscn')
