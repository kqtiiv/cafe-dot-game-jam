extends PathFollow3D

@export var speed: float = 2.0
@export var sit_animation_name: String = "Sit"

@onready var anim_tree = $character_rigged/AnimationTree
@onready var anim_player = $character_rigged/AnimationPlayer

var has_sat_down: bool = false

func _process(delta):
	if progress_ratio < 1.0:
		progress += speed * delta
		anim_tree.set("parameters/BlendSpace1D/blend_position", 1.0)
	else:
		if not has_sat_down:
			perform_sit_action()

func perform_sit_action():
	has_sat_down = true
	print("Sitting down.")
	
	if anim_tree:
		anim_tree.active = false
		
	if anim_player:
		anim_player.play(sit_animation_name, 0.5)
