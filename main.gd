extends Node2D

var parts_spawned : Array = []
var parts_collected : Array = []
var demon_part = preload("res://entities/demonpart.tscn")
var broom = preload("res://entities/broom.tscn")

var spawns : Array = []
var spawn_taken : Array = []

@onready var parts_holder : Node2D = $Parts

# Called when the node enters the scene tree for the first time.
func _ready():
	# spawner setup
	spawns = $Spawns.get_children()
	for r in range(0,spawns.size()):
		spawn_taken.append(false)
	
	spawn_parts()
	spawn_broom()
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_parts():
	# Spawning parts that match the prompt
	for r in range(0,6):
		var newpart = demon_part.instantiate()
		parts_holder.add_child(newpart)
		parts_spawned.append(newpart)
		
		# set to markers later
		var spawn_picker = randi_range(0,spawns.size()-1)
		while spawn_taken[spawn_picker] == true:
			spawn_picker = randi_range(0,spawns.size()-1)
		
		newpart.position = spawns[spawn_picker].position
		spawn_taken[spawn_picker] = true
		newpart.createPart(Global.prompt, r)
	
	# generates random amount of extra parts
	var parts_amount = randi_range(8, 14)
	for a in range(0,parts_amount):
		var extrapart = demon_part.instantiate()
		parts_holder.add_child(extrapart)
		parts_spawned.append(extrapart)
		
		# set to markers later
		var spawn_picker = randi_range(0,spawns.size()-1)
		while spawn_taken[spawn_picker] == true:
			spawn_picker = randi_range(0,spawns.size()-1)
		
		extrapart.position = spawns[spawn_picker].position
		spawn_taken[spawn_picker] = true
		
		var rand_demon = Global.prompt
		while rand_demon == Global.prompt:
			rand_demon = randi_range(0,3)
		var rand_part = randi_range(0,5)
		extrapart.createPart(rand_demon, a)

func spawn_broom():
	var broom_spawns = $BroomSpawns.get_children()
	var rand_spawn = randi_range(0,4)
	
	var broom_pickup = broom.instantiate()
	parts_holder.add_child(broom_pickup)
	broom_pickup.position = broom_spawns[rand_spawn].position
	broom_pickup.set_pos()
