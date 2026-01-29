extends Node3D

const SAVE_FILE_MUSIC_VOLUME := "user://MusicVolume.save"

@onready var audioStreamPlayer: AudioStreamPlayer = $AudioStreamPlayer

var _volume := 0.5

func _ready() -> void:
	if FileAccess.file_exists(SAVE_FILE_MUSIC_VOLUME):
		var saveFile = FileAccess.open(SAVE_FILE_MUSIC_VOLUME, FileAccess.READ)
		_volume = saveFile.get_double()
	
	audioStreamPlayer.volume_db = linear_to_db(_volume)

func ChangeVolume() -> void:
	_volume += 0.1
	if _volume > 1.0:
		_volume = 0.0
	
	audioStreamPlayer.volume_db = linear_to_db(_volume)
	var saveFile = FileAccess.open(SAVE_FILE_MUSIC_VOLUME, FileAccess.WRITE)
	saveFile.store_double(_volume)

func GetVolume() -> float:
	return _volume
