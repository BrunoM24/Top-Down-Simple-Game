extends Node2D
class_name Gun


export var image: Texture
export var automatic: bool

onready var sprite: Sprite = $Sprite

var pickable := false setget set_pickable
var equiped := false setget set_equiped

var bulletScene: PackedScene = preload("res://src/items/guns/Bullet.tscn")


func _ready() -> void:
	sprite.texture = image
	$Label.visible = false


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func _fire() -> void:
	_spawn_bullet()


func _spawn_bullet(angle := 0) -> void:
	var bullet : Area2D = bulletScene.instance()
	add_child(bullet)
	bullet.global_position = $BarrelPosition.global_position
	bullet.direction = $BarrelPosition.global_position.direction_to(get_global_mouse_position()).rotated(deg2rad(angle))
	bullet.look_at(bullet.direction + bullet.global_position)


func set_pickable(value: bool) -> void:
	pickable = value
	$Label.visible = pickable


func set_equiped(value: bool) -> void:
	set_pickable(!value)
	$ItemArea.monitorable = !value
