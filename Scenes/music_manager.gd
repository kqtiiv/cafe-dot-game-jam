extends Node3D
class_name MusicManager

const SAVE_FILE_MUSIC_VOLUME := "user://MusicVolume.save"

static var _instance: MusicManager = null
static var Instance: MusicManager:
	get: return _instance

@export var audioStreamPlayer: AudioStreamPlayer

var _volume := 0.3

func _init():
	if (_instance):
		push_error("More than one MusicManager instance")
	_instance = self
	
	if (FileAccess.file_exists(SAVE_FILE_MUSIC_VOLUME)):
		var saveFile = FileAccess.open(SAVE_FILE_MUSIC_VOLUME, FileAccess.READ)
		_volume = saveFile.get_double()

func _ready() -> void:
	audioStreamPlayer.volume_db = linear_to_db(_volume)

func _exit_tree() -> void:
	_instance = null

func ChangeVolume() -> void:
	_volume += 0.1
	if (_volume > 1.0):
		_volume = 0.0
	
	audioStreamPlayer.volume_db = linear_to_db(_volume)
	var saveFile = FileAccess.open(SAVE_FILE_MUSIC_VOLUME, FileAccess.WRITE)
	saveFile.store_double(_volume)

func GetVolume() -> float:
	return _volume
