extends VBoxContainer

@onready var tabs: TabContainer = $Tabs

func _on_tab_bar_tab_changed(tab: int) -> void:
	tabs.current_tab = tab
