extends Panel
class_name OptionsUI

static var _instance: OptionsUI = null
static var Instance: OptionsUI:
	get: return _instance

@export var soundEffectsButton: Button
@export var musicButton: Button
@export var closeButton: Button

var _onCloseButtonAction: Callable

func _init() -> void:
	if _instance:
		push_error("There is more than one OptionsUI instance")
	_instance = self

func _ready() -> void:
	UpdateVisual()
	
	soundEffectsButton.pressed.connect(func(): 
		SoundManager.ChangeVolume() 
		UpdateVisual()
	)
	
	musicButton.pressed.connect(func(): 
		MusicManager.ChangeVolume()
		UpdateVisual()
	)
	
	closeButton.pressed.connect(func(): 
		hide()
		# FIX 3: Safety check to prevent crash if action is null
		if _onCloseButtonAction.is_valid():
			_onCloseButtonAction.call()
	)

func _KitchenGameManager_OnGameUnpaused() -> void:
	hide()

func _exit_tree() -> void:
	if _instance == self:
		_instance = null

func UpdateVisual() -> void:
	if SoundManager:
		soundEffectsButton.text = "Sound Effects: " + str(round(SoundManager.GetVolume() * 10.0))
	
	if MusicManager:
		musicButton.text = "Music: " + str(round(MusicManager.GetVolume() * 10.0))

func Show(onCloseButtonAction: Callable) -> void:
	_onCloseButtonAction = onCloseButtonAction
	UpdateVisual()
	show()
	soundEffectsButton.grab_focus()
