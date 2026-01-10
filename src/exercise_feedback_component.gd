class_name ExerciseFeedbackComponent extends VBoxContainer

@onready var Display = $Display
@onready var Progress: ProgressBar = $Progress

signal finished_playing
signal finished_playing_indeterminate

var is_playing: bool = false
var is_playing_indeterminate: bool = false

func _ready() -> void:
	finished_playing.connect(func(): is_playing = false)
	finished_playing_indeterminate.connect(func(): is_playing_indeterminate = false)

func play( duration: float ) -> void:
	var tween: Tween = create_tween()
	Progress.value = 100
	is_playing = true
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.tween_property(Progress, "value", 0, duration)
	tween.parallel().tween_method(func(time): 
		if Display.text != Util.time_to_str(time):
			if int(time) % int(Conf.config['tts']['announce_every']) == 0:
				Util.tts_speak(Util.time_to_tts(time))
			elif int(time) <= int(Conf.config['tts']['announce_last']):
				Util.tts_speak(Util.time_to_tts(time))
			Display.text = Util.time_to_str(time)
		, duration, 0, duration)
	tween.chain().tween_callback(func():
		finished_playing.emit()
	)


func play_indeterminate( duration: float ) -> void:
	var tween: Tween = create_tween()
	is_playing_indeterminate = true
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.chain().tween_callback( func(): Progress.indeterminate = true )
	tween.tween_method( func(time): Display.text = Util.time_to_str(time), duration, 0, duration )
	tween.chain().tween_callback(func():
		Progress.indeterminate = false
		finished_playing_indeterminate.emit()
		DisplayServer.beep()
	)
