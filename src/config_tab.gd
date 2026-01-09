extends TabBar

@onready var Content: CodeEdit = $_Body/Content

func _ready() -> void:
	Content.text = JSON.stringify( Conf.config, "\t" )

func _on_copy_pressed() -> void:
	DisplayServer.clipboard_set( JSON.stringify( Conf.config ) )


func _on_save_pressed() -> void:
	Conf.config = JSON.parse_string(Content.text)
