@icon("res://img/icon/svg/icon_area_chart.svg") class_name IntensityExercise extends Exercise

@onready var NameComponent: ExerciseNameComponent = $_Body/_ExerciseNameComponent
@onready var DurationComponent: ExerciseDurationComponent = $_Body/_ExerciseDurationComponent
@onready var IntensityComponent: ExerciseIntensityComponent = $_Body/_ExerciseIntensityComponent
@onready var CooldownComponent: ExerciseCooldownComponent = $_Body/_ExerciseCooldownComponent
@onready var FeedbackComponent: ExerciseFeedbackComponent = $_Body/_ExerciseFeedbackComponent
@onready var Beep: AudioStreamPlayer = $Beep

func to_data() -> Dictionary:	
	return {
		'type': Util.ExerciseType.INTENSITY_EXERCISE,
		'name_component': NameComponent.to_data(),
		'duration_component': DurationComponent.to_data(),
		'intensity_component': IntensityComponent.to_data(),
		'cooldown_component': CooldownComponent.to_data()
	}

func from_data( data: Dictionary ) -> void:
	assert( data['type'] == Util.ExerciseType.INTENSITY_EXERCISE )
	
	NameComponent.from_data( data['name_component'] )
	DurationComponent.from_data( data['duration_component'] )
	IntensityComponent.from_data( data['intensity_component'] )
	CooldownComponent.from_data( data['cooldown_component'] )

func play() -> void:
	Beep.play()
	FeedbackComponent.play( DurationComponent.total_duration )
	for i in range(0, 9):
		if get_tree().paused:
			await Util.resumed
		Beep.pitch_scale = IntensityComponent.get_intensity(i)
		Input.vibrate_handheld( 1000 * int(DurationComponent.total_duration / 9), IntensityComponent.get_intensity(i) )
		await Util.wait( DurationComponent.total_duration / 9 )
	if FeedbackComponent.is_playing:
		await FeedbackComponent.finished_playing
	Beep.stop()
	FeedbackComponent.play_indeterminate( CooldownComponent.total_duration )
	if FeedbackComponent.is_playing_indeterminate:
		await FeedbackComponent.finished_playing_indeterminate
	finished.emit()

func get_exercise_name() -> String:
	return NameComponent.get_name_string()
