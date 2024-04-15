extends Area2D

@export var player: Node2D = null
var speed: float = 25

@onready var sprite: Node2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.play("default")
	
	if player.position.x < position.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	position = position.move_toward(player.position, speed * delta)
	if !Global.ghost:
		queue_free()
