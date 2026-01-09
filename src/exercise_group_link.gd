class_name ExerciseGroupLink extends HBoxContainer

@onready var Link: Button = $Link
@export var id: String = ""

func _on_delete_pressed() -> void:
	Conf.config['exercise_groups'].erase(id)
	Conf.save_config()
	queue_free()

func _on_link_pressed() -> void:
	Conf.selected_exercise_group = id
	get_tree().change_scene_to_file("res://scn/exercise_group.tscn")
