extends ColorRect

@onready var Unlock: Slider = $Unlock

func _on_unlock_value_changed(value: float) -> void:
	if value > 90:
		visible = false
		mouse_filter = Control.MOUSE_FILTER_PASS
		Unlock.value = 0
		
