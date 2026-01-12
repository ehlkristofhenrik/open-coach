extends TabBar

@onready var Speed: HSlider = $_Container/TTSVoice/_Speed/Speed
@onready var Voice: OptionButton = $_Container/TTSVoice/_Voice/Voice
@onready var Every: SpinBox = $_Container/TTSVoice/_Every/Every
@onready var Last: SpinBox = $_Container/TTSVoice/_Every/Last
@onready var Quotes: TextEdit = $_Container/Quotes
@onready var Volume: HSlider = $_Container/_Volume/Volume
@onready var VolumeBeep: HSlider = $_Container/_VolumeBeep/VolumeBeep
@onready var Background: OptionButton = $_Container/Background

func _ready() -> void:
	await Util.wait(0.1)
	Speed.value = Conf.config["tts"]["rate"]
	Every.value = Conf.config["tts"]["announce_every"]
	Last.value = Conf.config["tts"]["announce_last"]
	Quotes.text = "".join(Conf.config["quotes"])
	Volume.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Master"))
	VolumeBeep.value = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index("Beep"))
	for voice in DisplayServer.tts_get_voices():
		Voice.add_item(voice['id'])
	for file in DirAccess.get_files_at("res://img/background"):
		if file.ends_with(".png"):
			Background.add_item(file)
	


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


func _on_background_item_selected(index: int) -> void:
	Conf.config['background'] = Background.get_item_text(index)
