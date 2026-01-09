extends TabBar

@onready var Quote: Label = $Quote

func _ready() -> void:
	$Button.texture_normal = load(Conf.config['background'])

func _on_button_pressed() -> void:
	_ready()
	var quotes = Conf.config['quotes']
	Quote.text = quotes[randi_range(0, quotes.size()-1)]
