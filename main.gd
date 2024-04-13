extends Node2D

var parts_spawned : Array = []
var parts_collected : Array = []
var demon_part = preload("res://entities/demonpart.tscn")

@onready var parts_holder : Node2D = $Parts

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_parts()


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
		newpart.position = $Player.position + Vector2(64,-10)
		newpart.createPart(Global.prompt, r)
	
	# generates random amount of extra parts
	var parts_amount = randi_range(6, 14)
	for a in range(0,parts_amount):
		var extrapart = demon_part.instantiate()
		parts_holder.add_child(extrapart)
		parts_spawned.append(extrapart)
		
		# set to markers later
		extrapart.position = $Player.position + Vector2(64,-10)
		
		var rand_demon = Global.prompt
		while rand_demon == Global.prompt:
			rand_demon = randi_range(0,3)
		var rand_part = randi_range(0,5)
		extrapart.createPart(rand_demon, a)
