extends State

# Virtual methods that can be overridden by subclasses. But they must call super().

# Called when the state is entered.
func enter_state(state_name: String) -> void:
	.enter_state(state_name)

	print_debug("Light is off")
	
# Called when the state is updated. Ie. called every frame.
func update_state(state_name: String, delta: float) -> void:
	.update_state(state_name, delta)

# Called when the state is updated during physics. Ie. called every physics frame.
func update_state_physics(state_name: String, delta: float) -> void:
	.update_state_physics(state_name, delta)

# Called when the state is exited.
func exit_state(state_name: String) -> void:
	.exit_state(state_name)