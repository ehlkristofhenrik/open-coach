class_name ExerciseUtteranceComponent extends ExerciseComponent

@onready var Pattern: LineEdit = $Pattern

func from_data( data: Dictionary ) -> void:
	Pattern.text = data['pattern']

func to_data() -> Dictionary:
	return {
		'pattern': Pattern.text
	}

func __generate_permutation( arr: Array ) -> Array:
	var N: int = randi_range( 1, arr.size() )
	var ret: Array = []
	for i in range( N ):
		ret.append( arr[ randi_range( 0, arr.size() ) ] )
		arr.remove_at( i )
	return ret

func get_random() -> String:
	var pattern_split = Pattern.text.split(';')
	var pattern = pattern_split[randi_range(0, pattern_split.size())]
	var sub_pattern = pattern.split(',')
	var utterance_text = ""
	for sub in sub_pattern:
		utterance_text += __generate_permutation( sub.split( " " ) )
	return utterance_text
