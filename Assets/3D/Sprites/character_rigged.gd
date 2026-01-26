extends CharacterBody3D
@onready var armature = $Armature
@onready var anim_tree = $AnimationTree

func _ready():
	anim_tree.set("parameters/BlendSpace1D/blend_position", 1.0)
