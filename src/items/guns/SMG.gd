extends Gun


var can_shoot := true


func _physics_process(delta: float) -> void:
	if equiped && Input.is_action_pressed("left_trigger"):
		_fire()
	


func _fire() -> void:
	if can_shoot && bullets > 0:
		_spawn_bullet()
		bullets -= 1
		can_shoot = false
		yield(get_tree().create_timer(0.1), "timeout")
		can_shoot = true
