extends StaticBody2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

@onready var hurtbox = $CollisionShape2D
@export var type = TYPES.GROUND

func change_type(type):
	match type:
		TYPES.HOLE:
			type = TYPES.HOLE
		TYPES.RIVER:
			type = TYPES.RIVER
		TYPES.BARRIER:
			type = TYPES.BARRIER
