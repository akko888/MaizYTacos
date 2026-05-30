class_name AttackState
extends PlayerState

func enter() -> void:
	print("Attack state")
	stateMachine.change_state(IdleState.new(player, stateMachine))
