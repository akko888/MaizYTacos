class_name JumpState
extends PlayerState

func enter() -> void:
	pass
	
func exit() -> void:
	pass
	
func physics_process(_delta: float) -> void:
	if player.is_on_floor():
		stateMachine.change_state(IdleState.new(player, stateMachine))
		
func handle_input(_event: InputEvent) -> void:
	if _event is not InputEventScreenTouch:
		return
		
	if _event.pressed:
		player.startSwipe = _event.position
		return
		
	var swipe = _event.position - player.startSwipe
	
	if swipe.length() >= player.minimunDrag:
		if abs(swipe.x) > abs(swipe.y):
			player.facing = sign(swipe.x)
			player.velocity.x = player.DASH_VELOCITY * sign(swipe.x)
