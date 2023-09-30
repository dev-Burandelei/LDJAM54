extends CharacterBody2D

@onready var move_timer = $Timer
@onready var hitbox_collision = $Area2D/CollisionShape2D
@onready var hurtbox_collision = $CollisionShape2D
const MOVE_RANGE = 16
const MOVE_COOLDOWN = 0.10
var last_movement

func _ready():
	hitbox_collision.set_deferred("disabled", false)
	hurtbox_collision.set_deferred("disabled", true)

func move(direction):
	match direction:
		"up":
			last_movement = "up"
			position.y -= MOVE_RANGE
		"down":
			last_movement = "down"
			position.y += MOVE_RANGE
		"left":
			last_movement = "left"
			position.x -= MOVE_RANGE
		"right":
			last_movement = "right"
			position.x += MOVE_RANGE

func _on_area_2d_body_entered(body):
	if body.has_method("return_last_movement"):
		if move_timer.is_stopped():
			print("moving")
			move(body.return_last_movement())
			move_timer.start(MOVE_COOLDOWN)
			hitbox_collision.set_deferred("disabled", true)
			hurtbox_collision.set_deferred("disabled", false)
		
func return_last_movement():
	return last_movement

func _on_timer_timeout():
	hurtbox_collision.set_deferred("disabled", true)
	hitbox_collision.set_deferred("disabled", false)
