extends Node2D

@export var part_type : String = "body"
@export var demon_type : String = "devil"
@export var get_msg : String = "GOT A\nTORSO!"

@onready var init_pos : Vector2
@onready var offset : float = -0.01
@onready var animator : AnimatedSprite2D = $Sprite2D
@onready var floating : bool = true
@onready var dupe_part : bool = false

var notif_text = preload("res://ui/notif.tscn")

@onready var sfx : Node = $CollectSound

# Called when the node enters the scene tree for the first time.
func _ready():
	# debug
	#createPart()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(floating == true):
		position.y += offset
		if(position.y <= (init_pos.y - 1)):
			offset = 0.01
		if(position.y >= (init_pos.y + 1)):
			offset = -0.01

	pass

# Type: 0 = Devil, 1 = Bird, 2 = Horror, 3 = Crab
# Part: 0 = body, 1 = head, 2 = left arm, 3 = right arm, 4 = left leg, 5 = right leg
func createPart(type = 0, part = 0):
	match part:
		0:
			part_type = "body"
			
			var rando = randi_range(0, 99)
			if(rando == 69):
				get_msg = "WOOF WOOF WOOF\nIN YO BODYYY"
			else:
				get_msg = "GOT A\nTORSO!"
			animator.play("bodies")
		1:
			part_type = "head"
			get_msg = "KEEP YOUR\nHEAD TOGETHER!"
			animator.play("heads")
		2:
			part_type = "arm_l"
			#Left and Right are swapped from the demon's perspective
			#I'm keeping terminology respective to our though
			get_msg = "THAT'S\nRIGHT!"
			animator.play("arms_l")
		3:
			part_type = "arm_r"
			get_msg = "FOR THE\nLEFTIES!"
			animator.play("arms_r")
		4:
			part_type = "leg_l"
			get_msg = "DON'T\nRUN!"
			animator.play("legs_l")
		5:
			part_type = "leg_r"
			get_msg = "BEST LEFT\nFOR ME!"
			animator.play("legs_r")
	match type:
		0:
			demon_type = "devil"
			animator.frame = 0
		1:
			demon_type = "bird"
			animator.frame = 1
		2:
			demon_type = "horror"
			animator.frame = 2
		3:
			demon_type = "crab"
			animator.frame = 3
	animator.pause()
	init_pos = position

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var notif = notif_text.instantiate()
	var world = get_tree().root.get_child(1).get_child(1).get_child(0)
	var player = get_tree().root.get_child(1).get_node("Player")
	world.add_child(notif)
	
	update_tracker(part_type)
	add_to_parts(part_type, demon_type)
	
	if Global.parts_collected.size() == 6:
		get_msg = "GET BACK TO\nTHE DOOR!"
	
	if dupe_part == true:
		get_msg = "ALREADY GOT\nTHIS PART!!"
	else:
		player.get_node("PickupTimer").start()
		play_collect_sfx()
	
	notif.position = init_pos
	notif.appear(get_msg)
	
	if dupe_part == true:
		dupe_part == false
	else:
		self.queue_free()

func update_tracker(part = "body"):
	var tracker = get_tree().root.get_child(1).get_child(2).get_child(0).get_child(2)
	var piece : Sprite2D
	
	match part:
		"head":
			piece = tracker.get_child(0)
			piece.texture = load("res://sprites/hud_head_got.png")
		"body":
			piece = tracker.get_child(1)
			piece.texture = load("res://sprites/hud_torso_got.png")
		"arm_l":
			piece = tracker.get_child(2)
			piece.texture = load("res://sprites/hud_arml_got.png")
		"arm_r":
			piece = tracker.get_child(3)
			piece.texture = load("res://sprites/hud_armr_got.png")
		"leg_l":
			piece = tracker.get_child(4)
			piece.texture = load("res://sprites/hud_legl_got.png")
		"leg_r":
			piece = tracker.get_child(5)
			piece.texture = load("res://sprites/hud_legr_got.png")
			
func add_to_parts(part, demon):
	var size = Global.parts_collected.size()
	if size != 0:
		for r in range(0, size):
			var current_part = Global.parts_collected[r]
			if part == current_part[0]:
				dupe_part = true
				return
		pass
	
	var new_part = [part, demon]
	Global.parts_collected.append(new_part)
	#print(Global.parts_collected)

func play_collect_sfx():
	var collect_num = Global.parts_collected.size()
	match collect_num:
		1: sfx.stream = load("res://sound/collect/body_get_0.wav")
		2: sfx.stream = load("res://sound/collect/body_get_1.wav")
		3: sfx.stream = load("res://sound/collect/body_get_2.wav")
		4: sfx.stream = load("res://sound/collect/body_get_3.wav")
		5: sfx.stream = load("res://sound/collect/body_get_4.wav")
		6: sfx.stream = load("res://sound/collect/body_get_all_parts.wav")
	sfx.play()
