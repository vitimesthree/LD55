extends CharacterBody2D

@onready var sprite: Node2D = $Sprite
@onready var collision: Node2D = $Collision

@export var speed: float = 80
@export var jump_velocity: float = -250
@export var acceleration: float = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	# Moving.
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
	# Not moving.
	else:
		velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
	
	move_and_slide()
	
	# Handle animations.
	if is_on_floor():
		# Moving on floor.
		if direction:
			sprite.play("move")
			if (velocity.x > 0):
				sprite.flip_h = false
			elif (velocity.x < 0):
				sprite.flip_h = true
		else:
			sprite.play("idle")
	else:
		# Moving in air.
		sprite.play("jump")
