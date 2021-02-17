extends KinematicBody2D


export var max_health := 100

var health := max_health


func damage(value: int) -> void:
	health -= value
	if health < 1:
		die()


func die() -> void:
	queue_free()
