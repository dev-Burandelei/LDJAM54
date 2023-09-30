extends CharacterBody2D

@onready var move_timer = $Timer
const MOVE_RANGE = 16
const MOVE_COOLDOWN = 0.10
var last_movement

func _physics_process(delta):
	if move_timer.is_stopped():
		move()
	
func move():
	if Input.is_action_just_pressed("Up"):
		last_movement = "up"
		position.y -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Down"):
		last_movement = "down"
		position.y += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Left"):
		last_movement = "left"
		position.x -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif Input.is_action_just_pressed("Right"):
		last_movement = "right"
		position.x += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	

func return_last_movement():
	return last_movement
