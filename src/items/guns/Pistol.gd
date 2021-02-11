extends Gun


var bulletScene: PackedScene = preload("res://src/items/guns/Bullet.tscn")


func unhandled_input(event: InputEvent) -> void:
	_fire()


func _fire() -> void:
	var bullet : Area2D = bulletScene.instance()
	add_child(bullet)
	bullet.global_position = $BarrelPosition.global_position
	bullet.direction = $BarrelPosition.global_position.direction_to(get_global_mouse_position())
	bullet.look_at(bullet.direction + bullet.global_position)
