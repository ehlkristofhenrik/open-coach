class_name ExerciseSpeedComponent extends ExerciseComponent

@onready var Speed: HSlider = $Speed
@onready var Value: Label = $_Value

func get_speed() -> float:
	return Speed.value

func to_data() -> Dictionary:
	return {
		'speed': Speed.value
	}

func from_data( data: Dictionary ) -> void:
	Speed.value = data['speed']


func _on_speed_value_changed(value: float) -> void:
	Value.text = "%.2f" % value
