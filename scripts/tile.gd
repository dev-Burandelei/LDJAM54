extends StaticBody2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

const CURRENT = {IN = 1,
				OUT = -1,
				NONE = 0}

@onready var hurtbox = $CollisionShape2D
@onready var uphitbox = $Neighbours/Top
@onready var righthitbox = $Neighbours/Right
@onready var downhitbox = $Neighbours/Bottom
@onready var lefthitbox = $Neighbours/Left

@export var type = TYPES.GROUND

var hitboxes

func _ready():
	hitboxes = [uphitbox, righthitbox, downhitbox, lefthitbox]
	change_type(type)
	if type == TYPES.RIVER:
		river_base()

func change_type(type):
	match type:
		TYPES.GROUND:
			type = TYPES.GROUND
			for side in hitboxes:
				side.set_deferred("disabled", true)
				side.change_current(CURRENT.NONE)
		TYPES.HOLE:
			type = TYPES.HOLE
			for side in hitboxes:
				side.set_deferred("disabled", false)
		TYPES.RIVER:
			type = TYPES.RIVER
			for side in hitboxes:
				side.set_deferred("disabled", false)
		TYPES.BARRIER:
			type = TYPES.BARRIER
			for side in hitboxes:
				side.set_deferred("disabled", true)
				side.change_current(CURRENT.NONE)
		TYPES.WALL:
			type = TYPES.WALL
			for side in hitboxes:
				side.set_deferred("disabled", true)

func river_base():
	for side in hitboxes:
				side.change_current(CURRENT.OUT)

func _on_top_body_entered(body):
	if body.has_method("get_down"):
		if body.get_down() == CURRENT.OUT and uphitbox.return_current() == CURRENT.NONE:
			uphitbox.change_current(CURRENT.IN)	

func _on_right_body_entered(body):
	if body.has_method("get_left"):
		if body.get_left() == CURRENT.OUT and righthitbox.return_current() == CURRENT.NONE:
			righthitbox.change_current(CURRENT.IN)

func _on_bottom_body_entered(body):
	if body.has_method("get_top"):
		if body.get_top() == CURRENT.OUT and downhitbox.return_current() == CURRENT.NONE:
			downhitbox.change_current(CURRENT.IN)

func _on_left_body_entered(body):
	if body.has_method("get_right"):
		if body.get_right() == CURRENT.OUT and lefthitbox.return_current() == CURRENT.NONE:
			lefthitbox.change_current(CURRENT.IN)
	
func get_left():
	return lefthitbox.return_current()
	
func get_top():
	return uphitbox.return_current()
	
func get_right():
	return righthitbox.return_current()
	
func get_down():
	return downhitbox.return_current()
	
func get_type():
	return type
