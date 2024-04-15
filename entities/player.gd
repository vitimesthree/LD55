extends CharacterBody2D

@onready var sprite: Node2D = $Sprite
@onready var collision: Node2D = $Collision
@onready var pickup_timer: Node = $PickupTimer
@onready var hurt_sound: Node = $HurtSound

@export var speed: float = 150
@export var acceleration: float = 8
@export var decceleration: float = 20
@export var jump_velocity: float = 35
@export var terminal_velocity: float = 30
@onready var dir : int = 1

@export var broom_unlocked: bool = false
@export var broom_enabled: bool = false
@export var broom_speed: float = speed * 1.4
@export var broom_acceleration: float = acceleration / 2
@export var broom_decceleration: float = decceleration / 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	# Pickup animation!
	if not pickup_timer.is_stopped():
		sprite.play("hold")
	else:
		# Regular gameplay.
		if not broom_enabled:
			motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
			# Add the gravity.
			if not is_on_floor() and velocity.y < (terminal_velocity * 10):
				velocity.y += gravity * delta

			# Handle jump.
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = -jump_velocity * 10

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			var direction = Input.get_axis("move_left", "move_right")
			# Moving.
			if direction:
				velocity.x = lerp(velocity.x, direction * speed, acceleration * delta)
			# Not moving.
			else:
				velocity.x = lerp(velocity.x, direction * speed, decceleration * delta)
			
			move_and_slide()
			
			# Handle animations.
			sprite.speed_scale = 1
			if is_on_floor():
				# Moving on floor.
				if direction:
					sprite.play("move")
					if (velocity.x > 0):
						sprite.flip_h = false
						dir = 1
					elif (velocity.x < 0):
						sprite.flip_h = true
						dir = -1
				else:
					sprite.play("idle")
			else:
				# Moving in air.
				sprite.play("jump")
				
		# Sexy as fuck broom gameplay.
		else:
			motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
			
			# Get directions.
			var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			# Moving.
			if direction:
				velocity = lerp(velocity, direction * broom_speed, broom_acceleration * delta)
			# Not moving.
			else:
				velocity = lerp(velocity, direction * broom_speed, broom_decceleration * delta)
			
			move_and_slide()
			
			# Handle animations.
			sprite.play("broom")
			sprite.speed_scale = 1 + (velocity.length() / 50)
			if (velocity.x > 0):
				sprite.flip_h = false
			elif (velocity.x < 0):
				sprite.flip_h = true

func _input(event):
	if event.is_action_pressed("broom"):
		# Check if broom is even unlocked.
		if broom_unlocked:
			# Toggle broom.
			broom_enabled = !broom_enabled


func _on_pickup_timer_timeout():
	pickup_timer.stop()


func _on_ghost_body_entered(body):
	Global.ghost = false
	hurt_sound.play()
