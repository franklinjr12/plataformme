extends Node2D

var score = 0
var current_player_y = 0
var initial_player_y = 0
var player = null
var scoreLabel = null
var camera = null
var view_y = 0

func _ready() -> void:
	player = get_node("Player")
	initial_player_y = player.position.y
	current_player_y = initial_player_y
	scoreLabel = get_node("Camera2D/ScoreLabel")
	camera = get_node("Camera2D")
	view_y = get_viewport_rect().size.y / 2

func _process(delta: float) -> void:
	var new_y = player.position.y
	if new_y < current_player_y:
		current_player_y = new_y
		score = -roundi(current_player_y - initial_player_y)
		scoreLabel.text = "Score " + str(score)
	var view_y_end = view_y + camera.position.y
	if new_y > view_y_end:
		print("game over")
