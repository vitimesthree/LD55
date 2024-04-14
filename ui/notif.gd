extends Marker2D

# Called when the node Senters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func appear(message):
	var init_pos = position
	$Label.text = message
	$Timer.start()
	while position.y > (init_pos.y - 30):
		position.y -= 0.01

func _on_timer_timeout():
	self.queue_free()
