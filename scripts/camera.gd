extends Camera2D

@export var CAMERA_SCROLL_SPEED = 0.3
var player = null

func _ready():
	player = get_parent().get_node("Player")
	get_parent().player_death.connect(_on_player_death)

func _process(delta: float) -> void:
	position.y -= CAMERA_SCROLL_SPEED
	position.x = player.position.x

func _on_player_death():
	$GameOverLabel.visible = true
