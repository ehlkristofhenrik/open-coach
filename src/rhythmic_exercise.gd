@icon("res://img/icon/svg/icon_music_note.svg") class_name RhythmicExercise extends Exercise

@onready var NameComponent: ExerciseNameComponent = $_Body/_ExerciseNameComponent
@onready var DurationLoopsComponent: ExerciseDurationLoopsComponent = $_Body/_ExerciseDurationLoopsComponent
@onready var CooldownComponent: ExerciseCooldownComponent = $_Body/_ExerciseCooldownComponent
@onready var RhythmComponent: ExerciseRhythmComponent = $_Body/_ExerciseRhythmComponent
@onready var FeeedbackComponent: ExerciseFeedbackComponent = $_Body/_ExerciseFeedbackComponent

func to_data() -> Dictionary:
	return {
		'type': Util.ExerciseType.RHYTHMIC_EXERCISE,
		'name_component': NameComponent.to_data(),
		'duration_loops_component': DurationLoopsComponent.to_data(),
		'cooldown_component': CooldownComponent.to_data(),
		'rhythm_component': RhythmComponent.to_data(),
	}

func from_data( data: Dictionary ) -> void:
	assert( data['type'] == Util.ExerciseType.RHYTHMIC_EXERCISE )
	
	NameComponent.from_data( data['name_component'] )
	DurationLoopsComponent.from_data( data['duration_loops_component'] )
	CooldownComponent.from_data( data['cooldown_component'] )
	RhythmComponent.from_data( data['rhythm_component'] )

func play() -> void:
	var seconds: float = DurationLoopsComponent.get_loops() * 4
	if DurationLoopsComponent.is_duration():
		seconds = DurationLoopsComponent.get_total_duration()
	FeeedbackComponent.play( seconds )
	for i in range( seconds ):
		var rhythm = RhythmComponent.get_rhyhtm( i % 4 )
		match rhythm:
			0:
				await Util.wait( 1 )
			1:
				Input.vibrate_handheld(100)
				await Util.wait( 1 )
			2:
				Input.vibrate_handheld(100)
				await Util.wait( .5 )
				Input.vibrate_handheld(100)
				await Util.wait( .5 )
			3:
				Input.vibrate_handheld(100)
				await Util.wait( .333 )
				Input.vibrate_handheld(100)
				await Util.wait( .333 )
				Input.vibrate_handheld(100 )
				await Util.wait( .333 )
			4:
				Input.vibrate_handheld(100)
				await Util.wait( .4 )
				Input.vibrate_handheld(100)
				await Util.wait( .4  )
				Input.vibrate_handheld(100 )
				await Util.wait( .4  )
				Input.vibrate_handheld(100 )
				await Util.wait( .4 )
	await FeeedbackComponent.finished
	FeeedbackComponent.play_indeterminate(CooldownComponent.total_duration)
	await FeeedbackComponent.finished
	finished.emit()
