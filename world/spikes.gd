extends Node2D

@export var player: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var knockback_x = player.dir * -1
	
	var knockback_y = -1
	if position.y < player.position.y:
		knockback_y = 1

	player.velocity.x = player.speed * 2 * knockback_x
	player.velocity.y = player.jump_velocity * 8 * knockback_y
	player.hurt_sound.play()
	
func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
