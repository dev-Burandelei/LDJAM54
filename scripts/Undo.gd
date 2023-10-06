extends Node2D

@onready var undo_stack : Array = []
@onready var redo_stack : Array = []
@onready var player_action

class Action:
	var node : Node
	var undo_method : String
	var undo_args : Array
	var redo_method : String
	var redo_args : Array

func _ready():
	player_action = get_tree().get_nodes_in_group("player")
	print(player_action)
	for jogador in player_action:
		jogador.connect("executed_action", Callable(self, "execute_action"))

func _process(_delta):
	if Input.is_action_just_pressed("Undo"):
		undo()
	if Input.is_action_just_pressed("Redo"):
		redo()
func execute_action(node, do_method, do_args, undo_method, undo_args):
	
	#node.callv(do_method, do_args)
	
	var action = Action.new()
	action.node = node
	action.undo_method = undo_method
	action.undo_args = undo_args
	action.redo_method = do_method
	action.redo_args = do_args
	undo_stack.append(action)
	redo_stack.clear()
	
func undo():
	print_stacks()
	print(undo_stack.size())
	if undo_stack.size() == 0:
		return
	var action = undo_stack.pop_back()
	action.node.callv(action.undo_method, action.undo_args)
	redo_stack.append(action)

func redo():
	print_stacks()
	if redo_stack.size() == 0:
		return
	var action = redo_stack.pop_back()
	print(action.redo_args)
	#action.node.move("Up", 1) 
	action.node.callv(action.redo_method, action.redo_args)
	print(action.node)
	undo_stack.append(action)
	
func print_stacks():
	print("----- UNDO STACK -----")
	for action in undo_stack:
		print("Node:", action.node, "Method:", action.undo_method, "Args:", action.undo_args)
	
	print("----- REDO STACK -----")
	for action in redo_stack:
		print("Node:", action.node, "Method:", action.redo_method, "Args:", action.redo_args)


