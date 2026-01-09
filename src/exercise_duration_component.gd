class_name ExerciseDurationComponent extends ExerciseComponent

@onready var Minutes = $_DurationContainer/Minutes
@onready var Seconds = $_DurationContainer/Seconds

func from_data( data: Dictionary ) -> void:
	Minutes.value = data['minutes']
	Seconds.value = data['seconds']

func to_data() -> Dictionary:
	return {
		'minutes': Minutes.value,
		'seconds': Seconds.value
	}

var total_duration: float:
	set( value ):
		Minutes.value = floor( value / 60 )
		Seconds.value = int( value ) % 60
	get:
		return Minutes.value * 60 + Seconds.value
