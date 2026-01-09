class_name ExerciseNameComponent extends ExerciseComponent

@onready var Name: LineEdit = $Name

func _ready() -> void:
	Name.placeholder_text = Util.get_placeholder_name()

func _on_name_text_changed(new_text: String) -> void:
	var parent := get_parent().get_parent()
	parent.title = new_text

func from_data( data: Dictionary ) -> void:
	Name.text = data['name']
	_on_name_text_changed(Name.text)

func to_data() -> Dictionary:
	return {
		"name": Name.text
	}

func _on_delete_pressed() -> void:
	get_parent().get_parent().queue_free()

func get_name_string() -> String:
	return Name.text
