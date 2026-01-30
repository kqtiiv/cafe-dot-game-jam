extends Node3D

const SAVE_FILE_SOUND_EFFECTS_VOLUME := "user://SoundEffectsVolume.save"

const BUS_NAME := "SFX" 

var _volume := 1.0
var _bus_index := 0

func _ready() -> void:
	_bus_index = AudioServer.get_bus_index(BUS_NAME)
	
	if _bus_index == -1:
		_bus_index = AudioServer.get_bus_index("Master")

	if FileAccess.file_exists(SAVE_FILE_SOUND_EFFECTS_VOLUME):
		var saveFile = FileAccess.open(SAVE_FILE_SOUND_EFFECTS_VOLUME, FileAccess.READ)
		_volume = saveFile.get_double()
	
	_update_bus_volume()

func ChangeVolume() -> void:
	_volume += 0.1
	if _volume > 1.0:
		_volume = 0.0
		
	_update_bus_volume()
	
	var saveFile = FileAccess.open(SAVE_FILE_SOUND_EFFECTS_VOLUME, FileAccess.WRITE)
	saveFile.store_double(_volume)

func GetVolume() -> float:
	return _volume

func _update_bus_volume() -> void:
	AudioServer.set_bus_volume_db(_bus_index, linear_to_db(_volume))
	
	AudioServer.set_bus_mute(_bus_index, _volume == 0.0)
