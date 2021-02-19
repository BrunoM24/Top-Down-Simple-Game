extends Sprite


func _ready() -> void:
	randomize()
	rotation_degrees = randi() % 360
