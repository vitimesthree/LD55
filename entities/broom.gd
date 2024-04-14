extends Node2D

var init_pos : Vector2
var offset : float = -0.01
var get_msg : String = "BROOM GET!\nPRESS X!"
var notif_text = preload("res://ui/notif.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position.y += offset
	if(position.y <= (init_pos.y - 1)):
		offset = 0.01
	if(position.y >= (init_pos.y + 1)):
		offset = -0.01

func set_pos():
	init_pos = position

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var player = get_tree().root.get_child(1).get_node('Player')
	player.broom_unlocked = true
	
	var notif = notif_text.instantiate()
	var hud = get_tree().root.get_child(1).get_child(1).get_child(0)
	hud.add_child(notif)
	
	notif.position = init_pos
	notif.appear(get_msg)
	
	self.queue_free()
