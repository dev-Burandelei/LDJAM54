extends CharacterBody2D

@onready var move_timer = $Timer
const MOVE_RANGE = 16
const MOVE_COOLDOWN = 0.10
var last_movement

func _ready():
	$Sprite2D.play("idle_up")
	
func _physics_process(delta):
	if move_timer.is_stopped():
		move()
	
func move():
	if Input.is_action_just_pressed("Up"):
		last_movement = "up"
		$Sprite2D.play("idle_down")
		position.y -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Down"):
		$Sprite2D.play("idle_up")
		last_movement = "down"
		position.y += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Left"):
		$Sprite2D.play("idle_left")
		last_movement = "left"
		position.x -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Right"):
		$Sprite2D.play("idle_right")
		last_movement = "right"
		position.x += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	

func return_last_movement():
	return last_movement
