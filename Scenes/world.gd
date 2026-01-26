extends Node3D

@onready var my_path = $Path3D
@export var npc_scene: PackedScene

func _ready():
	spawn_npc()

func spawn_npc():
	# Create the NPC
	var new_npc = npc_scene.instantiate()
	my_path.add_child(new_npc)
	
	# Set starting position
	new_npc.progress_ratio = 0.0
