extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Label.text = str("%03d" % time_left)
	# $Label.set_text(str(minutes, " : ", str(seconds).pad_zeros(2)))


func _on_timeout():
	get_tree().change_scene_to_file('res://screens/dead.tscn')
