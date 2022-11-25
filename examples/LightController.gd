extends Control


var state_machine:StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine = $"../StateMachine"

func _on_Turn_on_Button_pressed() -> void:
	state_machine.change_state("LightOn")


func _on_Turn_off_Button2_pressed() -> void:
	state_machine.change_state("LightOff")
