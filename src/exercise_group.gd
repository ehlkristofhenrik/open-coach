class_name ExerciseGroup extends Control

@onready var title: String = ""

@onready var ExerciseScene: Array[PackedScene] = [
	preload("res://scn/exc/rhythmic_exercise.tscn"),
	preload("res://scn/exc/intensity_exercise.tscn"),
	preload("res://scn/exc/reaction_exercise.tscn")
]

@onready var Add: MenuButton = $_Body/_Actions/Add
@onready var Shuffle: TextureButton = $_Body/_Actions/Shuffle
@onready var Loop: TextureButton = $_Body/_Actions/Loop
@onready var Children: VBoxContainer = $_Body/_ScrollContainer/_Children
@onready var NameComponent: ExerciseNameComponent = $_Body/_ExerciseNameComponent
@onready var Scroll: ScrollContainer = $_Body/_ScrollContainer
@onready var Play: TextureButton = $_Body/_Actions/Play

func _ready() -> void:
	if Conf.config['exercise_groups'].has(Conf.selected_exercise_group):
		from_data( Conf.config['exercise_groups'][Conf.selected_exercise_group] )
	Add.get_popup().id_pressed.connect( _on_add_pressed )

func _on_add_pressed( id: int ) -> void:
	var instance: Exercise = ExerciseScene[id].instantiate()
	Children.add_child( instance )

func to_data() -> Dictionary:
	var children_data: Array[Dictionary] = []
	for child: Exercise in Children.get_children():
		children_data.append( child.to_data() )
	return {
		'name_component': NameComponent.to_data(),
		'shuffle': Shuffle.button_pressed,
		'loop': Loop.button_pressed,
		'children': children_data,
	}

func from_data( data: Dictionary ) -> void:
	NameComponent.from_data( data['name_component'] )
	Shuffle.set_pressed_no_signal( data['shuffle'] )
	Loop.set_pressed_no_signal( data['loop'] )
	for child_data in data['children']:
		var instance: Exercise = ExerciseScene[ child_data['type'] ].instantiate()
		Children.add_child( instance )
		instance.from_data( child_data )

func play() -> void:
	Util.tts_speak(NameComponent.get_name_string())
	await Util.tts_finished
	var first_run: bool = true
	while Loop.button_pressed or first_run:
		first_run = false
		Util.disable_input( true )
		var exercises = Children.get_children()
		if Shuffle.button_pressed:
			exercises.shuffle()
		for child: Exercise in exercises:
			child.expand()
			Util.tts_speak(child.get_exercise_name())
			await Util.tts_finished
			child.play()
			await child.finished
	Play.set_pressed_no_signal( false )
	Util.disable_input( false )

func _on_play_toggled(toggled_on: bool) -> void:
	if toggled_on:
		if get_tree().paused:
			get_tree().paused = false
		else:
			play()
	else:
		if get_tree().paused:
			pass
		else:
			get_tree().paused = true

func _on_stop_pressed() -> void:
	Util.disable_input( false )
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scn/main.tscn")

func _on_save_pressed() -> void:
	Conf.config['exercise_groups'][Conf.selected_exercise_group] = to_data()
	Conf.save_config()
