extends Node2D

signal player_death

var score = 0
var current_player_y = 0
var initial_player_y = 0
var player = null
var scoreLabel = null
var camera = null
var view_y = 0
var last_platform_num = 1

const platform = preload("res://scenes/platform.tscn")
const platform_str = "Platform"
const platform_spawn_dist = 500
const platform_x_spawn_dist = 200
const platform_y_spawn_dist = 100

func _ready() -> void:
	player = get_node("Player")
	initial_player_y = player.position.y
	current_player_y = initial_player_y
	scoreLabel = get_node("Camera2D/ScoreLabel")
	camera = get_node("Camera2D")
	view_y = get_viewport_rect().size.y / 2

func _process(delta: float) -> void:
	var new_y = player.position.y
	var view_y_end = view_y + camera.position.y
	if new_y > view_y_end:
		#$Camera2D/GameOverLabel.visible = true
		player_death.emit()
	if new_y < current_player_y:
		current_player_y = new_y
		score = -roundi(current_player_y - initial_player_y)
		scoreLabel.text = "Score " + str(score)
	var last_platform = get_node(last_platform_name())
	if last_platform.position.distance_to(player.position) <= platform_spawn_dist:
		var new_platform = platform.instantiate()
		last_platform_num += 1
		new_platform.name = last_platform_name()
		var signal_mult = 1
		if randi() % 2 == 0:
			signal_mult = -1
		new_platform.position.x = last_platform.position.x + signal_mult * (platform_x_spawn_dist/2 + randi() % platform_x_spawn_dist /2)
		signal_mult = -1
		new_platform.position.y = last_platform.position.y + signal_mult * platform_y_spawn_dist
		add_child(new_platform)

func last_platform_name() -> String:
	return platform_str + str(last_platform_num)

func _on_platform_cleaner_timer_timeout() -> void:
	var view_y_end = view_y + camera.position.y
	var platforms = get_tree().get_nodes_in_group("platforms")
	for p in platforms:
		if p.position.y > view_y_end:
			p.queue_free()
