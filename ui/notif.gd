extends Marker2D

# Called when the node Senters the scene tree for the first time.
func _ready():
	appear("TEST")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func appear(message):
	var init_pos = position
	$Label.text = message
	$Timer.start()
	#while position.y > (position.y - 30):
	#	position.y -= 1

func _on_timer_timeout():
	print("timer ran out")
	#self.queue_free()
