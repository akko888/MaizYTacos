class_name LandState
extends PlayerState

func enter() -> void:
	player.sprite.play("Landing")
	player.sprite.animation_finished.connect(_on_land_finished, CONNECT_ONE_SHOT)

func exit() -> void:
	pass

func _on_land_finished() -> void:
	stateMachine.change_state(IdleState.new(player, stateMachine))
