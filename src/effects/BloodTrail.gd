extends Sprite


func _ready() -> void:
	randomize()
	var r = randi() % 360
	print(r)
	rotation_degrees = r
