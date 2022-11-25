extends Node

class_name State, "../assets/action.png"
# The base class for a finite state machine (FSM) node. 

# Signals emitted by this class:
signal state_entered(state_name)
signal state_updated(state_name, delta)
signal state_updated_physics(state_name, delta)
signal state_exited(state_name)

var state_machine = null setget set_state_machine, get_state_machine
export var next_state: String setget set_next_state, get_next_state

func _ready():
	editor_description = "A finite state machine (FSM) node. It is a container for states and transitions. It can be used to create complex AI behavior."

# A shortcut to change the state of the state machine.
func change_state(state_name: String) -> void:
	"""Change the current state to the state with the given name."""
	if state_machine:
		state_machine.change_state(state_name)

func change_state_to_next() -> void:
	"""Change the current state to the next state."""
	if state_machine:
		state_machine.change_state(next_state)

# Virtual methods that can be overridden by subclasses. But they must call super().
func enter_state(state_name: String) -> void:
	emit_signal("state_entered", state_name)
	#print_debug("Entered state: " + state_name)

func update_state(state_name: String, delta: float) -> void:
	emit_signal("state_updated", state_name, delta)
	#print_debug("Updated state: " + state_name)

func update_state_physics(state_name: String, delta: float) -> void:
	emit_signal("state_updated_physics", state_name, delta)
	#print_debug("Updated state physics: " + state_name)

func exit_state(state_name: String) -> void:
	emit_signal("state_exited", state_name)
	#print_debug("Exited state: " + state_name)

# Getters and setters.
func set_state_machine(new_state_machine) -> void:
	state_machine = new_state_machine

func get_state_machine() :
	return state_machine

func set_next_state(new_next_state: String) -> void:
	next_state = new_next_state

func get_next_state() -> String:
	return next_state