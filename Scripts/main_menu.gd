extends Panel

@export var playButton: Button
@export var optionsButton: Button
@export var quitButton: Button

func _ready() -> void:
	playButton.grab_focus()
	
	playButton.pressed.connect(func(): get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn"))
	optionsButton.pressed.connect(func(): 
		hide()
		OptionsUI.Instance.Show(show)
	)
	quitButton.pressed.connect(func(): get_tree().quit())

	Engine.time_scale = 1.0
