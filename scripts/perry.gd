extends CharacterBody2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

const MOVE_RANGE = 16
const MOVE_COOLDOWN = 0.10

@onready var uphitbox = $Neighbours/Top
@onready var righthitbox = $Neighbours/Right
@onready var downhitbox = $Neighbours/Bottom
@onready var lefthitbox = $Neighbours/Left
@onready var move_timer = $Timer

var last_movement
var hitboxes

func _ready():
	$Sprite2D.play("idle_up")
	hitboxes = ["NONE", "NONE", "NONE", "NONE"]
	
func _physics_process(delta):
	if move_timer.is_stopped():
		move()
	if Input.is_action_just_pressed("Dig"):
		match last_movement:
			"up":
				uphitbox.dig()
			"right":
				righthitbox.dig()
			"down":
				downhitbox.dig()
			"left":
				lefthitbox.dig()
	
func move():
	if hitboxes[0] != TYPES.WALL and Input.is_action_just_pressed("Up"):
		last_movement = "up"
		$Sprite2D.play("idle_down")
		position.y -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif hitboxes[2] != TYPES.WALL and Input.is_action_just_pressed("Down"):
		$Sprite2D.play("idle_up")
		last_movement = "down"
		position.y += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif hitboxes[3] != TYPES.WALL and Input.is_action_just_pressed("Left"):
		$Sprite2D.play("idle_left")
		last_movement = "left"
		position.x -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	elif hitboxes[1] != TYPES.WALL and Input.is_action_just_pressed("Right"):
		$Sprite2D.play("idle_right")
		last_movement = "right"
		position.x += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
	

func return_last_movement():
	return last_movement


func _on_top_body_entered(body):
	if body.has_method("get_type"):
		hitboxes[0] = body.get_type()

func _on_right_body_entered(body):
	if body.has_method("get_type"):
		hitboxes[1] = body.get_type()

func _on_bottom_body_entered(body):
	if body.has_method("get_type"):
		hitboxes[2] = body.get_type()

func _on_left_body_entered(body):
	if body.has_method("get_type"):
		hitboxes[3] = body.get_type()
