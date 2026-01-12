extends TabBar

@onready var Speed: HSlider = $VBoxContainer/TTSVoice/_Speed/Speed
@onready var Voice: OptionButton = $VBoxContainer/TTSVoice/_Voice/Voice
@onready var Every: SpinBox = $VBoxContainer/TTSVoice/_Every/Every
@onready var Last: SpinBox = $VBoxContainer/TTSVoice/_Every/Last
@onready var Quotes: TextEdit = $VBoxContainer/Quotes

func _ready() -> void:
	await Util.wait(0.1)
	Speed.value = Conf.config["tts"]["rate"]
	Every.value = Conf.config["tts"]["announce_every"]
	Last.value = Conf.config["tts"]["announce_last"]
	Quotes.text = "".join(Conf.config["quotes"])
	for voice in DisplayServer.tts_get_voices():
		Voice.add_item(voice['id'])
	


func _on_voice_item_selected(index: int) -> void:
	Conf.config['tts']['voice'] = Voice.get_item_text(index)
	Conf.save_config()


func _on_every_value_changed(value: float) -> void:
	Conf.config['tts']['announce_every'] = value
	Conf.save_config()


func _on_last_value_changed(value: float) -> void:
	Conf.config['tts']['announce_last'] = value
	Conf.save_config()


func _on_quotes_text_changed() -> void:
	Conf.config['quotes'] = Quotes.text.strip_edges().split("\n")
	Conf.save_config()


func _on_volume_value_changed(value: float) -> void:
	var index = AudioServer.get_bus_index("Beep")
	AudioServer.set_bus_volume_linear(index, value)


func _on_volume_ring_value_changed(value: float) -> void:
	var index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_linear(index, value)


func _on_background_pressed() -> void:
	DisplayServer.file_dialog_show(
		"Background", 
		"/", 
		"", 
		false, 
		DisplayServer.FILE_DIALOG_MODE_OPEN_FILE, 
		PackedStringArray([ "*.png","*.jpg"]),
		func(status, path, _filter): 
			if status:
				Conf.config['background'] = path
				Conf.save_config(), 
		0
	)
