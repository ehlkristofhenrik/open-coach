class_name ExerciseFeedbackComponent extends VBoxContainer

@onready var Display = $Display
@onready var Progress: ProgressBar = $Progress

signal finished()

func play( duration: float ) -> void:
	Progress.value = 100
	var tween: Tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.tween_property(Progress, "value", 0, duration)
	tween.parallel().tween_method(func(time): Display.text = Util.time_to_str(time), duration, 0, duration)
	await tween.finished
	finished.emit()

func play_indeterminate( duration: float ) -> void:
	var tween: Tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
	tween.chain().tween_callback( func(): Progress.indeterminate = true )
	tween.tween_method( func(time): Display.text = Util.time_to_str(time), duration, 0, duration )
	await tween.finished
	Progress.indeterminate = false
	finished.emit()
