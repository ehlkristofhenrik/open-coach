class_name ExerciseDurationLoopsComponent extends ExerciseComponent

@onready var Selector = $_Selector
@onready var DurationContainer = $_DurationContainer
@onready var LoopsContainer = $_LoopsContainer
@onready var Loops = $_LoopsContainer/Loops
@onready var Minutes = $_DurationContainer/Minutes
@onready var Seconds = $_DurationContainer/Seconds

func from_data( data: Dictionary ) -> void:
	Selector.set_pressed_no_signal( data['selector'] )
	_on_selector_toggled( data['selector'] )
	Minutes.value = data['minutes']
	Seconds.value = data['seconds']
	Loops.value   = data['loops']

func to_data() -> Dictionary:
	return {
		'selector': Selector.button_pressed,
		'minutes':  Minutes.value,
		'seconds':  Seconds.value,
		'loops':    Loops.value
	}

## Returns [ minutes, seconds ]
func get_duration() -> Array[float]:
	return [ Minutes.value, Seconds.value ]

func get_total_duration() -> float:
	return Minutes.value * 60 + Seconds.value

func get_loops() -> float:
	return Loops.value

func is_duration() -> bool:
	return not Selector.button_pressed

func _on_selector_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DurationContainer.visible = false
		LoopsContainer.visible = true
	else:
		DurationContainer.visible = true
		LoopsContainer.visible = false
