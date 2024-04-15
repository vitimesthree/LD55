extends Node2D

@export var player : Node2D = null
@onready var dest_a : Vector2 = Vector2(0,0)
@onready var dest_b : Vector2 = Vector2(0,0)
@onready var destination : Vector2
@onready var imdead : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var marker_a = get_node("dest_a")
	var marker_b = get_node("dest_b")
	if marker_a:
		dest_a = marker_a.global_position
	if marker_b:
		dest_b = marker_b.global_position
	
	destination = dest_b

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position == dest_b:
		$AnimatedSprite2D.flip_h = true
		destination = dest_a
	if position == dest_a:
		$AnimatedSprite2D.flip_h = false
		destination = dest_b
	
	if !imdead:
		$AnimatedSprite2D.play("walk")
		position = position.move_toward(destination, 40 * delta)

func _on_hitbox_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if !imdead:
		var knockback_x = -1
		if player.position.x > position.x:
			knockback_x = 1
		
		var knockback_y = -1
		if position.y < player.position.y:
			knockback_y = 1

		player.velocity.x = player.speed * 3 * knockback_x
		player.velocity.y = player.jump_velocity * 3 * knockback_y
		player.hurt_sound.play()
		
		var hud = get_tree().root.get_child(1).get_node("CanvasLayer")
		var timer = hud.get_child(0).get_node("Timer")
		timer.get_hurt()

func _on_hitbox_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.


func _on_stompbox_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
		if !imdead:
			player.velocity.y = -player.jump_velocity * 5
			$Timer.start()
			$AnimatedSprite2D.play("ded")
		imdead = true

func _on_timer_timeout():
	queue_free()
