extends Gun


func _fire() -> void:
	if bullets < 1:
		return
	
	for i in 5:
		_spawn_bullet(randi() % 40 - 20)
	
	bullets -= 1
