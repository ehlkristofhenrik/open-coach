extends TabBar

@onready var Content: QRCodeRect = $_Body/Content

func _ready() -> void:
	Content.set_data( JSON.stringify( Conf.config ) )

func _on_copy_pressed() -> void:
	DisplayServer.clipboard_set( JSON.stringify( Conf.config ) )
