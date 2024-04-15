extends AnimatedSprite2D

@onready var start_frame : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()
	ghosting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_property(tx_pos, tx_scale):
	position = tx_pos
	scale = tx_scale

func ghosting():
	var tween_fade = get_tree().create_tween()
	
	tween_fade.tween_property(self, "self_modulate",Color(1, 1, 1, 0), 1.5)
	await tween_fade.finished
	
	queue_free()
