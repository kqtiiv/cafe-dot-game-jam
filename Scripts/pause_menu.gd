extends Node

@onready var audio = $Panel/VBoxContainer/button_click

func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")

func testEsc():
	if Input.is_action_just_pressed("escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("escape") and get_tree().paused == true:
		resume()


func _on_resume_pressed():
	audio.play()
	resume()


func _on_restart_pressed():
	audio.play()
	resume()
	get_tree().reload_current_scene()


func _on_settings_pressed():
	pass #connect OptionsUI here? or copy it I dunno >_<
	


func _on_quit_pressed():
	audio.play()
	await get_tree().create_timer(0.25).timeout
	get_tree().quit()

func _process(_delta):
	testEsc()
