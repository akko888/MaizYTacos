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
var stateMachine: StateMachine
var facing: float = 1.0

# Swipe Variables
var minimunDrag = 60.0
var startSwipe = Vector2.ZERO

func _ready() -> void:
	if screenSide == Side.RIGHT:
		$Sprite2D.flip_h = true
		facing = -1.0
	stateMachine = StateMachine.new()
	stateMachine.change_state(IdleState.new(self, stateMachine))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = move_toward(velocity.x , 0, FRICTION * delta)
	
	$Sprite2D.flip_h = facing < 0
	
	stateMachine.update(delta)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	var centerX = get_viewport().get_visible_rect().size.x / 2
	var touchLeft = event.position.x < centerX
	
	if screenSide == Side.LEFT and not touchLeft: return
	if screenSide == Side.RIGHT and touchLeft: return
	
	stateMachine.input(event)
