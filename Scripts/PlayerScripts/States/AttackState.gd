# Claude provisional code
class_name AttackState
extends PlayerState

func enter() -> void:
	print("Attack state")
	player.sprite.play("Attack")
	player.sprite.animation_finished.connect(_on_animation_finished, CONNECT_ONE_SHOT)

func _on_animation_finished() -> void:
	stateMachine.change_state(IdleState.new(player, stateMachine))

func exit() -> void:
	# Safety: disconnect if we leave early (e.g. got hit, died)
	if player.sprite.animation_finished.is_connected(_on_animation_finished):
		player.sprite.animation_finished.disconnect(_on_animation_finished)
