extends CanvasLayer

@onready var animation: AnimationPlayer = $AnimationPlayer 

func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards('dissolve')
