extends Camera2D

@export var CAMERA_SCROLL_SPEED = 0.15

func _process(delta: float) -> void:
	position.y -= CAMERA_SCROLL_SPEED
