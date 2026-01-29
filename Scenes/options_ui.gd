extends Panel
class_name OptionsUI

static var _instance: OptionsUI = null
static var Instance: OptionsUI:
	get: return _instance

@export var soundEffectsButton: Button
@export var musicButton: Button
@export var closeButton: Button
@onready var audio = $Content/button_click

var _onCloseButtonAction: Callable

func _init() -> void:
	if (_instance):
		push_error("There is more than one OptionsUI instance")
	_instance = self

func _ready() -> void:
	soundEffectsButton.pressed.connect(func():
		audio.play()
		SoundManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	musicButton.pressed.connect(func(): 
		audio.play()
		MusicManager.Instance.ChangeVolume()
		UpdateVisual()
	)
	closeButton.pressed.connect(func(): 
		audio.play()
		hide()
		_onCloseButtonAction.call()
	)

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func _exit_tree() -> void:
	_instance = null

func UpdateVisual() -> void:
	soundEffectsButton.text = "Sound Effects: " + str(round(SoundManager.Instance.GetVolume() * 10.0))
	musicButton.text = "Music: " + str(round(MusicManager.Instance.GetVolume() * 10.0))

func Show(onCloseButtonAction: Callable) -> void:
	_onCloseButtonAction = onCloseButtonAction

	show()

	soundEffectsButton.grab_focus()
