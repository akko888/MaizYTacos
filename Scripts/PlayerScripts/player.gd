class_name Player
extends CharacterBody2D

const JUMP_VELOCITY = -600.0
const DASH_VELOCITY = 800.0
const FRICTION = 625.0

# Movement variables
var target_velocity: float = 0.0

# Swipe Variables
var minimunDrag = 60.0
var startSwipe = Vector2.ZERO
var endSwipe

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			startSwipe = event.position
		else: 
			endSwipe = event.position
			_handle_swipe(startSwipe, endSwipe)
			

func _handle_swipe(start: Vector2, end: Vector2) -> void:
	var swipe = end - start
	
	if swipe.length() < minimunDrag:
		return
	
	if abs(swipe.x) > abs(swipe.y):
		velocity.x = DASH_VELOCITY * sign(swipe.x)
	else:
		if swipe.y < 0 and is_on_floor():
			velocity.y = JUMP_VELOCITY
