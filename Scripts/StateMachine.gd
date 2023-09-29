extends Node2D

var current_state:State
var states:Dictionary={}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()]=child #if child is a state, include it in the dictionary
			child.Transitioned.connect(on_child_transition)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

#transition to other state
func on_child_transition(state,new_state_name):
	#check if the state calling it isn't the current state
	if state !=current_state:
		return
	
	#grab state from the dictionary
	var new_state=states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	#check if we have a current state
	#if we do, then we call the exit function
	if current_state:
		current_state.exit()
	
	new_state.enter()
	
	current_state=new_state
