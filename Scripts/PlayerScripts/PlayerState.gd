class_name PlayerState
extends RefCounted

var player: Player
var stateMachine: StateMachine

func _init(p: Player, sm: StateMachine) -> void:
	player = p
	stateMachine = sm
	
func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func physics_process(_delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
