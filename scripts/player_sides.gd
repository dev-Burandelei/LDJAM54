extends Area2D

const TYPES = {GROUND = "terra",
				HOLE = "buraco",
				RIVER = "água",
				BARRIER = "barreira",
				WALL = "parede"}

func dig():
	for body in get_overlapping_bodies():
		if body.return_type() == TYPES.GROUND:
			body.start_timer()
