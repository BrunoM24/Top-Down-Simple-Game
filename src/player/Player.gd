extends KinematicBody2D


onready var sprite: Sprite = $Sprite

export var max_speed := 200.0

var _velocity := Vector2.ZERO

var gun: Gun
var gunScene: PackedScene = preload("res://src/items/guns/Pistol.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_trigger") && !gun:
		gun = gunScene.instance()
		$RightHand.add_child(gun)
	
	if event.get_action_strength("left_trigger") && gun:
		gun.unhandled_input(event)
	


func _physics_process(delta: float) -> void:
	var move := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	_velocity = move.normalized() * max_speed
	
	_velocity = move_and_slide(_velocity)
	
	look_at(get_global_mouse_position())
