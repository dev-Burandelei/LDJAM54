extends Area2D

const CURRENT = {IN = 1,
				OUT = -1,
				NONE = 0}

@onready var current = CURRENT.NONE

func change_current(value):
	match value:
		1:
			current = CURRENT.IN
		0:
			current = CURRENT.NONE
		-1:
			current = CURRENT.OUT

func return_current():
	return current
