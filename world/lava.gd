extends Node2D

@export var player: Node2D = null
@onready var sprite: Node2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	sprite.play("default")

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	player.velocity.y = -player.jump_velocity * 10
	player.hurt_sound.play()
	
	var hud = get_tree().root.get_child(1).get_node("CanvasLayer")
	var timer = hud.get_child(0).get_node("Timer")
	timer.get_hurt()

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
