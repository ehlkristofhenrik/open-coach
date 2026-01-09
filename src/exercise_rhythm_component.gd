class_name ExerciseRhythmComponent extends ExerciseComponent

@onready var Rhythm: Array[OptionButton] = [
	$_RhythmContainer/Rhythm1,
	$_RhythmContainer/Rhythm2,
	$_RhythmContainer/Rhythm3,
	$_RhythmContainer/Rhythm4,
]

func from_data( data: Dictionary ) -> void:
	Rhythm[0].select( data['rhythm'][0] )
	Rhythm[1].select( data['rhythm'][1] )
	Rhythm[2].select( data['rhythm'][2] )
	Rhythm[3].select( data['rhythm'][3] )

func to_data() -> Dictionary:
	return {
		"rhythm": [
			Rhythm[0].get_selected_id(),
			Rhythm[1].get_selected_id(),
			Rhythm[2].get_selected_id(),
			Rhythm[3].get_selected_id(),
		]
	}

func get_rhyhtm( id: int ) -> int:
	return Rhythm[id].get_selected_id()
