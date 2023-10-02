extends Node2D

var emitter_scene = preload("res://scenes/button.tscn")
var emitter_node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	emitter_node = emitter_scene.instance()
	self.add_child(emitter_node)
	emitter_node.connect("held_down", Callable(self, "_on_held_down_signal_received"))
	emitter_node.connect("release", Callable(self, "_on_release_signal_received"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_held_down_signal_received():
	print("AAAAAAAAAA")
	
func _on_release_signal_received():
	print("BBBBBBBB")
