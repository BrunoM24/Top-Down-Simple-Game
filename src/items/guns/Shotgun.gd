extends Gun


func unhandled_input(event: InputEvent) -> void:
	_fire()


func _fire() -> void:
	print("firing the shotgun")
