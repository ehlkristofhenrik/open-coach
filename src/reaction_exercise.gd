@icon("res://img/icon/svg/icon_bolt.svg") class_name ReactionExercise extends Exercise

@onready var NameComponent: ExerciseNameComponent = $_Body/_ExerciseNameComponent
@onready var DurationComponent: ExerciseDurationComponent = $_Body/_ExerciseDurationComponent
@onready var CooldownComponent: ExerciseCooldownComponent = $_Body/_ExerciseCooldownComponent
@onready var UtteranceComponent: ExerciseUtteranceComponent = $_Body/_ExerciseUtteranceComponent
@onready var FeedbackComponent: ExerciseFeedbackComponent = $_Body/_ExerciseFeedbackComponent

func to_data() -> Dictionary:
	return {
		'type': Util.ExerciseType.REACTION_EXERCISE,
		'name_component': NameComponent.to_data(),
		'duration_component': DurationComponent.to_data(),
		'cooldown_component': CooldownComponent.to_data(),
		'utterance_component': UtteranceComponent.to_data()
	}

func from_data( data: Dictionary ) -> void:
	assert( data['type'] == Util.ExerciseType.REACTION_EXERCISE )
	
	NameComponent.from_data( data['name_component'] )
	DurationComponent.from_data( data['duration_component'] )
	CooldownComponent.from_data( data['cooldown_component'] )
	UtteranceComponent.from_data( data['utterance_component'] )
	
func play() -> void:
	randomize()
	FeedbackComponent.play( DurationComponent.total_duration )
	var total_duration: float = DurationComponent.total_duration
	while total_duration > 0:
		if get_tree().paused:
			await Util.resumed
		var time: int = randi_range( UtteranceComponent.get_min(), UtteranceComponent.get_max() )
		Util.tts_speak(UtteranceComponent.get_random())
		await Util.wait( time )
		total_duration -= time
	if FeedbackComponent.is_playing:
		await FeedbackComponent.finished_playing
	FeedbackComponent.play_indeterminate( CooldownComponent.total_duration )
	if FeedbackComponent.is_playing_indeterminate:
		await FeedbackComponent.finished_playing_indeterminate
	finished.emit()

func get_exercise_name() -> String:
	return NameComponent.get_name_string()
