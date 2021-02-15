extends Gun


func _fire() -> void:
	for i in 5:
		_spawn_bullet(randi() % 40 - 20)
	
