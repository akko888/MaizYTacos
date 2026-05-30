class_name StateMachine
extends RefCounted

var currentState: PlayerState

func change_state(newState: PlayerState) -> void:
	if currentState:
		currentState.exit()
	currentState = newState
	currentState.enter()

func update(delta: float) -> void:
	if currentState:
		currentState.physics_process(delta)

func input(event: InputEvent) -> void:
	if currentState:
		currentState.handle_input(event)
