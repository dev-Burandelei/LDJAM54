extends Area2D

var can_release = true 
signal held_down
signal release
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#func _on_body_entered(body):
#	if body.name == "Cleito":
#		emit_signal("held_down")
#		print("held down")
#		can_release = false
#		$Timer.start()
#
#func _on_body_exited(body):
#	if body.name == "Cleito" and can_release:
#
#		emit_signal("release")
#		print("release")

func _on_area_exited(_area):
	emit_signal("release")
	print("release")

func _on_area_entered(_area):
	emit_signal("held_down")
	print("held down")
