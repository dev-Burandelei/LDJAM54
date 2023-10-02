extends Area2D


signal held_down
signal release
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.name == "Cleito":
		emit_signal("held_down")
		print("held down")
		
		
func _on_body_exited(body):
	if body.name == "Cleito":
		emit_signal("release")
		print("release")
