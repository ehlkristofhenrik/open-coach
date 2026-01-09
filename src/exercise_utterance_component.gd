class_name ExerciseUtteranceComponent extends ExerciseComponent

@onready var Pattern: LineEdit = $_Pattern/Pattern
@onready var Min: SpinBox = $_Range/Min
@onready var Max: SpinBox = $_Range/Max

func from_data( data: Dictionary ) -> void:
	Pattern.text = data['pattern']
	Min.value = data['min']
	Max.value = data['max']

func to_data() -> Dictionary:
	return {
		'pattern': Pattern.text,
		'min': Min.value,
		'max': Max.value
	}

func __generate_permutation( arr: Array ) -> Array:
	var N: int = randi_range( 1, arr.size()-1 )
	arr.pick_random()
	var ret: Array = []
	for i in range( N ):
		ret.append( arr[ randi_range( 0, arr.size()-1 ) ] )
		arr.remove_at( i )
	return ret

func get_random() -> String:
	var pattern_selection = Array( Pattern.text.split(';') ).pick_random()
	var sub_pattern = Array(pattern_selection.split(',')).pick_random()
	return sub_pattern

func get_min() -> int:
	return int(Min.value)

func get_max() -> int:
	return int(Max.value)

func _on_min_value_changed(value: float) -> void:
	if Max.value < Min.value:
		Max.value = Min.value

func _on_max_value_changed(value: float) -> void:
	if Max.value < Min.value:
		Min.value = Max.value
