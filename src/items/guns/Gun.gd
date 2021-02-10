extends Node2D
class_name Gun

export var image: Texture
export var automatic: bool

onready var sprite: Sprite = $Sprite


func _ready() -> void:
	sprite.texture = image


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func _fire() -> void:
	pass
