extends Node2D
class_name Gun


export var image: Texture
export var automatic: bool

export var magazine_size : int = 8
export var bullets : int = magazine_size

onready var sprite: Sprite = $Sprite
onready var label: Label = $Label
onready var barrel: Position2D = $BarrelPosition

var pickable := false setget set_pickable
var equiped := false setget set_equiped

var bulletScene: PackedScene = preload("res://src/items/guns/Bullet.tscn")


func _ready() -> void:
	if image:
		sprite.texture = image
	
	label.visible = false
	set_physics_process(false)
	
	bullets = magazine_size


func unhandled_input(event: InputEvent) -> void:
	_fire()


func physics_process(delta: float) -> void:
	pass


func _fire() -> void:
	if bullets > 0:
		$AudioStreamPlayer2D.play()
		_spawn_bullet()
		bullets -= 1


func _spawn_bullet(angle := 0) -> void:
	$BarrelPosition/Particles2D.restart()
	var bullet : Area2D = bulletScene.instance()
	add_child(bullet)
	bullet.global_position = barrel.global_position
	bullet.direction = barrel.global_position.direction_to(get_global_mouse_position()).rotated(deg2rad(angle))
	bullet.look_at(bullet.direction + bullet.global_position)


func reload() -> void:
	bullets = magazine_size


func set_pickable(value: bool) -> void:
	pickable = value
	label.visible = pickable


func set_equiped(value: bool) -> void:
	equiped = value
	set_pickable(!value)
	set_physics_process(value)
	$ItemArea.monitorable = !value


func _on_AudioStreamPlayer2D_finished() -> void:
	print("stop sound")
	$AudioStreamPlayer2D.stop()
