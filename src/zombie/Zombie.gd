extends KinematicBody2D


export var blood_particles_scene: PackedScene

export var max_health := 100

var health := max_health


func damage(value: int) -> void:
	_spawn_blood_particles()
	health -= value
	if health < 1:
		die()


func die() -> void:
	var blood_trail = preload("res://src/effects/BloodTrail.tscn").instance()
	blood_trail.global_position = global_position
	get_parent().add_child(blood_trail)
	queue_free()


func _spawn_blood_particles() -> void:
	if !blood_particles_scene:
		return
	
	var blood_particle: Particles2D = blood_particles_scene.instance()
	add_child(blood_particle)
	blood_particle.emitting = true
