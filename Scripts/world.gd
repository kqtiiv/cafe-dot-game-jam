extends Node3D

@onready var my_path_1 = $World/Path3D
@export var npc_scene: PackedScene

func _ready():
	spawn_npc()

func spawn_npc():
	# Create the NPC
	var new_npc = npc_scene.instantiate()
	my_path_1.add_child(new_npc)
	$World/doorbell.play()
	
	# Set starting position
	new_npc.progress_ratio = 0.0
