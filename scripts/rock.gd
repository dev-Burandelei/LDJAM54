extends CharacterBody2D

const MOVE_RANGE = 16

func move(direction):
	match direction:
		"up":
			position.y -= MOVE_RANGE
		"down":
			position.y += MOVE_RANGE
		"left":
			position.x -= MOVE_RANGE
		"right":
			position.x += MOVE_RANGE

func _on_area_2d_body_entered(body):
	if body.has_method("return_last_movement"):
		move(body.return_last_movement())
