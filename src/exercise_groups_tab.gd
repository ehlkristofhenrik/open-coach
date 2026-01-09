class_name ExerciseGroupsTab extends TabBar

@onready var ExerciseGroupLinkScene: PackedScene = preload("res://scn/exercise_group_link.tscn")
@onready var Children: VBoxContainer = $_Body/_ScrollContainer/_Children
@onready var Add: Button = $_Body/Add

func _on_add_pressed() -> void:
	var instance: ExerciseGroupLink = ExerciseGroupLinkScene.instantiate()
	instance.id = Util.get_unique_id()
	var placeholder: String = Util.get_placeholder_name()
	Conf.config['exercise_groups'][instance.id] = {
		'name_component': { 'name': placeholder },
		'shuffle': false,
		'loop': false,
		'children': [],
	}
	Children.add_child(instance)
	instance.Link.text = placeholder

func _ready() -> void:
	for exercise_group in Conf.config['exercise_groups'].keys():
		var instance: ExerciseGroupLink = ExerciseGroupLinkScene.instantiate()
		Children.add_child(instance)
		instance.id = exercise_group
		instance.Link.text = Conf.config['exercise_groups'][exercise_group]['name_component']['name']
