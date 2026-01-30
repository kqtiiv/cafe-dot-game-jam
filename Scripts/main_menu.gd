extends Control

@export var playButton: Button
@export var optionsButton: Button
@export var quitButton: Button
@onready var audio = $MainMenuUI/Content/button_click

func _ready() -> void:
	playButton.grab_focus()
	
	playButton.pressed.connect(func(): 
		audio.play()
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn"))
	
	
	optionsButton.pressed.connect(func(): 
		audio.play()
		hide()
		OptionsUI.Show(show)
	)
	quitButton.pressed.connect(func():
		audio.play()
		await get_tree().create_timer(0.25).timeout 
		get_tree().quit())
	

	Engine.time_scale = 1.0
