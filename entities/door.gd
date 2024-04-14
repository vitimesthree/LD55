extends Area2D

var player_touch : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	player_touch = true
	print(player_touch)

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	player_touch = false
	print(player_touch)
	
func _input(event):
	if Input.is_action_just_pressed("jump"):
		if Global.parts_collected.size() == 6 && player_touch == true:
			get_tree().change_scene_to_file("res://screens/score.tscn")
