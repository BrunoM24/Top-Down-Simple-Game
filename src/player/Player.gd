extends KinematicBody2D


onready var sprite: Sprite = $Sprite
onready var backpackSprite: Sprite = $Backpack
onready var pickableArea: Area2D = $PickableArea
onready var animation_player: AnimationPlayer = $AnimationPlayer

export var max_speed := 200.0

var _velocity := Vector2.ZERO

var gun: Gun

var backpack_equiped: bool = false

var pickableObjects: Array
var pickableObject: Node2D


func _ready() -> void:
	backpackSprite.visible = backpack_equiped


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_trigger") && gun:
		gun.unhandled_input(event)
	
	if event.is_action_pressed("interact"):
		_interact()
	
	if event.is_action_pressed("reload") && gun:
		animation_player.play("reload_gun")
		yield(animation_player, "animation_finished")
		gun.reload()
	


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
	if !area.get_parent().has_method('set_pickable'):
		return
	
	if !pickableObject:
		pickableObject = area.get_parent()
		pickableObject.pickable = true


func _on_PickableArea_area_exited(area: Area2D) -> void:
	if !area.get_parent().has_method('set_pickable'):
		return
	
	area.get_parent().pickable = false
	pickableObject = null
