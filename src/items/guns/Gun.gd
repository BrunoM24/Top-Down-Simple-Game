extends Node2D
class_name Gun

export var image: Texture
export var automatic: bool

onready var sprite: Sprite = $Sprite

var pickable := false setget set_pickable

func _ready() -> void:
	sprite.texture = image
	$Label.visible = false


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func _fire() -> void:
	pass


func set_pickable(value: bool) -> void:
	pickable = value
	$Label.visible = pickable
