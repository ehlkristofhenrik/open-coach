@abstract class_name Exercise extends FoldableContainer

@abstract func to_data() -> Dictionary
@abstract func from_data( data: Dictionary ) -> void
@abstract func play() -> void

@warning_ignore("unused_signal") signal finished()

func move_up() -> void:
	get_parent().move_child(self, self.get_index() - 1)

func move_down() -> void:
	get_parent().move_child(self, self.get_index() + 1)
