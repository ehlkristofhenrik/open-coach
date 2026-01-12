extends TabBar

@onready var Quote: Label = $Quote

func _ready() -> void:
	$Background.texture_normal = load("res://img/background/"+Conf.config['background'])

func _on_background_pressed() -> void:
	var quotes = Conf.config['quotes']
	if not quotes.is_empty():
		Quote.text = quotes[randi_range(0, quotes.size()-1)]
	else:
		Quote.text = ""
	_ready()
