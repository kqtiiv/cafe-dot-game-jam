extends Control

@export var Back: Button
@onready var audio: AudioStreamPlayer = $button_click

func _ready():
	Back.pressed.connect(func():
		audio.play()
		await get_tree().create_timer(0.25).timeout
		SceneTransition.change_scene_to_file("res://Scenes/ResultsScreen.tscn"))
