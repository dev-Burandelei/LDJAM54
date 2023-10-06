extends CharacterBody2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

const MOVE_RANGE = 16
const MOVE_COOLDOWN = 0.10

signal executed_action(node, do_method, do_args, undo_method, undo_args)

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
	
func _physics_process(_delta):
	if move_timer.is_stopped():
		_input_control()
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
	
func _input_control():
	if Input.is_action_just_pressed("Up"):
		move("Up", 0)
	elif Input.is_action_just_pressed("Down"):
		move("Down", 0)
	elif Input.is_action_just_pressed("Left"):
		move("Left", 0)
	elif Input.is_action_just_pressed("Right"):
		move("Right", 0)
		
func move(input, save):
	if hitboxes[0] != TYPES.WALL and input == "Up":
		last_movement = "Up"
		$Sprite2D.play("idle_down")
		position.y -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
		if save == 0:
			emit_signal("executed_action",self, "move", [last_movement, 1], "move", ["Down", 1])
	elif hitboxes[2] != TYPES.WALL and input == "Down":
		$Sprite2D.play("idle_up")
		last_movement = "Down"
		position.y += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
		if save == 0:
			emit_signal("executed_action",self, "move", [last_movement, 1], "move", ["Up", 1])
	elif hitboxes[3] != TYPES.WALL and input == "Left":
		$Sprite2D.play("idle_left")
		last_movement = "Left"
		position.x -= MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
		if save == 0:
			emit_signal("executed_action",self, "move", [last_movement, 1], "move", ["Right", 1])
	elif hitboxes[1] != TYPES.WALL and input == "Right":
		$Sprite2D.play("idle_right")
		last_movement = "Right"
		position.x += MOVE_RANGE
		move_timer.start(MOVE_COOLDOWN)
		if save == 0:
			emit_signal("executed_action",self, "move", [last_movement, 1], "move", ["Left", 1])
	elif input == "stop":
		pass
	

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
