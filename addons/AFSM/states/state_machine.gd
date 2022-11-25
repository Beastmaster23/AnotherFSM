extends Node

class_name StateMachine, "../assets/fsm.png"

# This handles and manages the state machine

# This is the main class for the state machine
# Signals:
signal state_changed(old_state, new_state) # Emitted when the state changes.

export var auto_start=true # If true, the state machine will start with the first state

# The key is the state name, the value is the state object
var states: Dictionary = {} # A dictionary of states.
var current_state: State # The current state.

func _ready() -> void:
	# Find all the states in the scene, add them to the dictionary, set the
	# StateMachine as us and set the initial state.
	# Check if there is a state in the scene.
	if get_child_count() == 0:
		print("No states found in the scene.")
		return
	for child in get_children():
		if child:
			states[child.name] = child
			child.set("state_machine", self)
	if not auto_start:
		return
	# Set the initial state
	current_state = get_children()[0]
	# Emit the state changed signal
	emit_signal("state_changed", "", current_state)
	# Call the enter function on the initial state
	states[current_state.name].enter_state(current_state.name)

func _process(delta: float) -> void:
	# Call the process function on the current state
	if current_state and states.has(current_state.name):
		states[current_state.name].update_state(current_state.name, delta)

func change_state(new_state: String) -> void:
	# Change the state to the new state
	# If the new state is not in the dictionary, do nothing
	if new_state in states:
		# Call the exit function on the current state if it exists
		if current_state and states.has(current_state.name):
			states[current_state.name].exit_state(current_state.name)
		# Set the current state to the new state
		var old_state = current_state.name if current_state else ""
		current_state = states[new_state]
		# Emit the state changed signal
		emit_signal("state_changed", old_state, current_state.name)
		# Call the enter function on the new state
		states[current_state.name].enter_state(current_state.name)
