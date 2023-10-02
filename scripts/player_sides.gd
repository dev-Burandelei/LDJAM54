extends Area2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

func dig():
	for body in get_overlapping_bodies():
		if body.has_method("change_type"):
			body.change_type(TYPES.HOLE)
