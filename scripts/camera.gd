extends Camera2D

@export var CAMERA_SCROLL_SPEED = 0.15
var player = null

func _ready():
	player = get_parent().get_node("Player")

func _process(delta: float) -> void:
	position.y -= CAMERA_SCROLL_SPEED
	position.x = player.position.x
