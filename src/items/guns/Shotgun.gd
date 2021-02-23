extends Gun


func _fire() -> void:
	if bullets < 1:
		return
	
	$AudioStreamPlayer2D.play()
	
	for i in 5:
		_spawn_bullet(randi() % 20 - 10)
	
	bullets -= 1
