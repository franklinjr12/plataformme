extends CharacterBody2D

@export var DEFAULT_VELOCITY = 10000.0
@export var FALL_MULTIPLIER = 7
@export var JUMP_VELOCITY = 12000

var is_jumping = true

func _ready() -> void:
	$AnimatedSprite2D.animation = "default"

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += DEFAULT_VELOCITY * delta
	if Input.is_action_pressed("move_left"):
		velocity.x -= DEFAULT_VELOCITY * delta
	if is_jumping:
		velocity.y -= JUMP_VELOCITY * delta
	velocity.y +=  (FALL_MULTIPLIER * get_gravity().y) * delta
	if velocity.y < 0:
		$AnimatedSprite2D.animation = "jump"
	else:
		$AnimatedSprite2D.animation = "fall"
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	self.velocity = velocity
	move_and_slide()

func _on_is_jumping_on_timer_timeout() -> void:
	if is_jumping == false && is_on_floor():
		is_jumping = true
	else:
		is_jumping = false
