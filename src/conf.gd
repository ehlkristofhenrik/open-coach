extends Node

const CONF_FILE_PATH = "user://config.json"
const CONF_FILE_PASS = "xmx0-d1l9p-CouchCoach"

var selected_exercise_group: String = ""

const DEFAULT_CONFIG = {
	"tts": {
		"rate": 1.0,
		"voice": "",
		"announce_every": 15,
		"announce_last": 10,
	},
	"quotes": [
		"Open Coach"
	],
	"exercise_groups": {
		
	},
	"background": "Bodybuilding_Male"
}


var config = DEFAULT_CONFIG.duplicate(true):
	set(value):
		config = value
		save_config()


func _ready() -> void:
	load_config()

func save_config() -> void:
	var json: String = JSON.stringify( config )
	var file: FileAccess = FileAccess.open_encrypted_with_pass( CONF_FILE_PATH, FileAccess.WRITE, CONF_FILE_PASS )
	file.store_string( json )
	file.close()

func load_config() -> void:
	# DirAccess.remove_absolute(CONF_FILE_PATH)
	if FileAccess.file_exists(CONF_FILE_PATH):
		var file: FileAccess = FileAccess.open_encrypted_with_pass(CONF_FILE_PATH, FileAccess.READ, CONF_FILE_PASS)
		var json = file.get_as_text()
		config = JSON.parse_string( json )
		file.close()

func _notification(what: int) -> void:
	if what == NOTIFICATION_CRASH:
		DirAccess.remove_absolute(CONF_FILE_PATH)
