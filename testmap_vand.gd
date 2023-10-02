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
		2: 
			call_expansion_2()
		3: 
			call_expansion_3()
		4:
			call_expansion_4()
		5:
			call_expansion_5()
	print(num_buttons)
	print(completed_value)
func call_expansion_1():
	$Camera2D.zoom = Vector2(9, 5)
	disebled_node($Node_1/button_1)
	disebled_mist($Node_1/mist_1)
	completed_value = 1
	num_buttons = 0
	
func disebled_node(node):
	node.hide()
	node.set_deferred("monitoring", false)
	node.set_deferred("monitotable", false)
	node.set_process(false)
	
func activate_node(node):
	node.show()
	node.set_deferred("monitoring", true)
	node.set_deferred("monitotable", true)
	node.set_process(true)
	
func disebled_mist(node):
	node.visible = false
	#$mist_1.collision_layer = 0

func call_expansion_2():
	$Camera2D.zoom = Vector2(7, 4)
	disebled_node($Node_2/button_2)
	disebled_mist($Node_2/mist_2)
	completed_value = 1
	num_buttons = 0

func call_expansion_3():
	$Camera2D.zoom = Vector2(6, 3)
	disebled_node($Node_3/button_3)
	disebled_mist($Node_3/mist_3)
	completed_value = 1
	num_buttons = 0

func call_expansion_4():
	$Camera2D.zoom = Vector2(5, 3)
	disebled_node($Node_4/button_4)
	disebled_node($Node_4/button_4_2)
	disebled_mist($Node_4/mist_4)
	activate_node($Node_5/button_5_1)
	activate_node($Node_5/button_5_2)
	completed_value = 2
	num_buttons = 0
	
func call_expansion_5():
	$Camera2D.zoom = Vector2(4, 3)
	disebled_node($Node_5/button_5_1)
	disebled_node($Node_5/button_5_2)
	disebled_mist($Node_5/mist_5)
	completed_value = 2
	num_buttons = 0
	
