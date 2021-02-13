extends KinematicBody2D


onready var sprite: Sprite = $Sprite
onready var pickableArea: Area2D = $PickableArea

export var max_speed := 200.0

var _velocity := Vector2.ZERO

var gun: Gun

var pickableObjects: Array
var pickableObject: Node2D


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("right_trigger") && !gun:
		pass
	
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
	$RightHand.look_at(get_global_mouse_position())


func _interact() -> void:
	if pickableObject:
		if !gun:
			#pickup gun
			_equip()
			
		else:
			#swap gun
			gun.get_parent().remove_child(gun)
			pickableObject.get_parent().add_child(gun)
			gun.position = pickableObject.position
			gun.equiped = false
			_equip()


func _equip(item: Node2D = pickableObject) -> void:
	gun = item
	gun.get_parent().remove_child(gun)
	$RightHand.add_child(gun)
	gun.position = Vector2.ZERO
	gun.equiped = true


func _on_PickableArea_area_entered(area: Area2D) -> void:
	if !pickableObject:
		pickableObject = area.get_parent()
		pickableObject.pickable = true


func _on_PickableArea_area_exited(area: Area2D) -> void:
	area.get_parent().pickable = false
	pickableObject = null
