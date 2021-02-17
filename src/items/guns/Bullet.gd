extends Area2D


export var bullet_speed := 400

var direction : Vector2
var travel_distance := 100
var damage := 20


func _ready() -> void:
	set_as_toplevel(true)


func _physics_process(delta: float) -> void:
	position += direction.normalized() * bullet_speed * delta


func _on_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	if body.has_method("damage"):
		body.damage(damage)
	
	queue_free()
