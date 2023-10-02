extends Node2D

var emitter_node
var num_buttons = 0
var completed_value = 1
var expansion = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	_connect_all_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _connect_all_buttons():
	for button_node in get_tree().get_nodes_in_group("buttons"):
		button_node.connect("held_down", Callable(self, "_on_held_down_signal_received"))
		button_node.connect("release", Callable(self, "_on_release_signal_received"))
		
func _on_held_down_signal_received():
	num_buttons += 1
	if num_buttons == completed_value:
		call_expansion()
	
func _on_release_signal_received():
	num_buttons -= 1

func call_expansion():
	expansion += 1
	match expansion:
		1:
			call_expansion_1()

func call_expansion_1():
	disebled_node($button)
	disebled_mist($mist_1)
	
func disebled_node(node):
	node.hide()
	node.set_deferred("monitoring", false)
	node.set_deferred("monitotable", false)
	node.set_process(false)
	
func disebled_mist(node):
	node.visible = false
	#$mist_1.collision_layer = 0
	
