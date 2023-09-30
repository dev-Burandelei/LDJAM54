extends CharacterBody2D

const MOVE_RANGE = 16
var last_movement

func _physics_process(delta):
	move()
	
func move():
	if Input.is_action_just_pressed("Up"):
		last_movement = "up"
		position.y -= MOVE_RANGE
	elif Input.is_action_just_pressed("Down"):
		last_movement = "down"
		position.y += MOVE_RANGE
	elif Input.is_action_just_pressed("Left"):
		last_movement = "left"
		position.x -= MOVE_RANGE
	elif Input.is_action_just_pressed("Right"):
		last_movement = "right"
		position.x += MOVE_RANGE

func return_last_movement():
	return last_movement
