class_name ExerciseCooldownComponent extends ExerciseComponent

@onready var Minutes = $_CooldownContainer/Minutes
@onready var Seconds = $_CooldownContainer/Seconds

func from_data( data: Dictionary ) -> void:
	Minutes.value = data['minutes']
	Seconds.value = data['seconds']

func to_data() -> Dictionary:
	return {
		'minutes': Minutes.value,
		'seconds': Seconds.value
	}

var total_duration: float:
	get:
		return Minutes.value * 60 + Seconds.value
