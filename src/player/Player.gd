extends KinematicBody2D


onready var sprite: Sprite = $Sprite
onready var pickableArea: Area2D = $PickableArea

export var max_speed := 200.0

var _velocity := Vector2.ZERO

var gun: Gun
var gunScene: PackedScene = preload("res://src/items/guns/Pistol.tscn")

var pickableObjects: Array
var pickableObject


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_trigger") && !gun:
		gun = gunScene.instance()
		$RightHand.add_child(gun)
	
	if event.get_action_strength("left_trigger") && gun:
		gun.unhandled_input(event)
	
	if event.is_action_pressed("interact"):
		_interact()
	


func _physics_process(delta: float) -> void:
	_movement_logi()
	
#	pickableObjects = pickableArea.get_overlapping_areas()
#
#	if pickableObjects.size() > 0:
#		print(pickableObjects)


func _movement_logi() -> void:
	var move := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	_velocity = move.normalized() * max_speed
	
	_velocity = move_and_slide(_velocity)
	
	look_at(get_global_mouse_position())


func _interact() -> void:
	if pickableObject:
		print("pickup item")


func _on_PickableArea_area_entered(area: Area2D) -> void:
	if !pickableObject:
		pickableObject = area.get_parent()
		pickableObject.pickable = true


func _on_PickableArea_area_exited(area: Area2D) -> void:
	area.get_parent().pickable = false
	pickableObject = null
