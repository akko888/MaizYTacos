class_name Player
extends CharacterBody2D

# Constants
const JUMP_VELOCITY = -800.0
const DASH_VELOCITY = 800.0
const FRICTION = 625.0

enum Side { LEFT, RIGHT }

# Export Variables
@export var screenSide := Side.LEFT

# Movement Variables
var facing: float = 1.0

# Swipe Variables
var minimunDrag = 60.0
var startSwipe = Vector2.ZERO
var endSwipe = Vector2.ZERO

func _ready() -> void:
	if screenSide == Side.RIGHT:
		$Sprite2D.flip_h = true
		facing = -1.0

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if facing > 0:
		$Sprite2D.flip_h = false
	elif facing < 0:
		$Sprite2D.flip_h = true
	
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	var screenSideX = get_viewport().get_visible_rect().size.x / 2
	var touchIsLeft = event.position.x < screenSideX
	
	if screenSide == Side.LEFT and not touchIsLeft:
		return
	if screenSide == Side.RIGHT and touchIsLeft:
		return
	
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
		facing = sign(swipe.x)
		velocity.x = DASH_VELOCITY * sign(swipe.x)
	else:
		if swipe.y < 0 and is_on_floor():
			velocity.y = JUMP_VELOCITY
