extends Node3D
class_name SoundManager

const SAVE_FILE_SOUND_EFFECTS_VOLUME := "user://SoundEffectsVolume.save"

static var _instance: SoundManager = null
static var Instance: SoundManager:
	get: return _instance

var _volume := 1.0

func _init():
	if (_instance):
		push_error("More than one SoundManager instance")
	_instance = self
	
	if (FileAccess.file_exists(SAVE_FILE_SOUND_EFFECTS_VOLUME)):
		var saveFile = FileAccess.open(SAVE_FILE_SOUND_EFFECTS_VOLUME, FileAccess.READ)
		_volume = saveFile.get_double()

func _exit_tree() -> void:
	_instance = null

func ChangeVolume() -> void:
	_volume += 0.1
	if (_volume > 1.0):
		_volume = 0.0
		
	var saveFile = FileAccess.open(SAVE_FILE_SOUND_EFFECTS_VOLUME, FileAccess.WRITE)
	saveFile.store_double(_volume)
	

func GetVolume() -> float:
	return _volume
