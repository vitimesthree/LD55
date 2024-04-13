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
		newpart.position = $Player.position + Vector2(10,10)
		newpart.createPart(Global.prompt, r)
