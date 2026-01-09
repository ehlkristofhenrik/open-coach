class_name ExerciseIntensityComponent extends ExerciseComponent

@onready var Intensities: Array[Slider] = [
	$Intensity1,
	$Intensity2,
	$Intensity3,
	$Intensity4,
	$Intensity5,
	$Intensity6,
	$Intensity7,
	$Intensity8,
	$Intensity9,
]

func from_data( data: Dictionary ) -> void:
	for i in range( data['intensities'].size() ):
		Intensities[i].value = data['intensities'][i]
	
func to_data() -> Dictionary:
	var intensities: Array[float] = []
	for intensity in Intensities:
		intensities.append( intensity.value )
	
	return {
		'intensities': intensities
	}

func get_intensity( id: int ) -> float:
	return Intensities[id].value
