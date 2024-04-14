extends Node2D

var init_pos : Vector2
var offset : float = -0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += offset
	if(position.y <= (init_pos.y - 1)):
		offset = 0.01
	if(position.y >= (init_pos.y + 1)):
		offset = -0.01

func set_pos():
	init_pos = position

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var player = get_tree().root.get_child(1).get_child(3)
	player.broom_unlocked = true
	self.queue_free()
