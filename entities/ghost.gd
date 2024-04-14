extends Area2D

@export var player: Node2D = null
@export var speed: float = 50

@onready var sprite: Node2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.play("default")
	position = position.move_toward(player.position, speed * delta)
	if !Global.ghost:
		queue_free()
