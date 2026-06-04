class_name Player
extends CharacterBody2D

# Constants
const FRICTION = 625.0
enum Side { LEFT, RIGHT }
# Player Variables
var JUMP_VELOCITY: float
var DASH_VELOCITY: float
@onready var sprite = $AnimatedSprite2D
@onready var hurtbox = $Hurtbox
@onready var hitbox = $Hitbox
var health: float
var isDead: bool = false
# Export Variables
@export var screenSide := Side.LEFT
@export var stats: CharacterStats
# Movement Variables
var hitstopTimer: float = 0.0
var stateMachine: StateMachine
var facing: float = 1.0
# Swipe Variables
var minimunDrag = 60.0
var startSwipe = Vector2.ZERO

#Signals
signal health_changed(newHealth: float, maxHealth: float)
@warning_ignore("unused_signal")
signal died()

func _ready() -> void:
	health = stats.maxHealth
	sprite.sprite_frames = stats.spriteFrames
	DASH_VELOCITY = stats.DASH_VELOCITY
	JUMP_VELOCITY = stats.JUMP_VELOCITY
	
	if screenSide == Side.RIGHT:
		sprite.flip_h = true
		facing = -1.0
		hitbox.set_direction(facing)
	stateMachine = StateMachine.new()
	stateMachine.change_state(IdleState.new(self, stateMachine))

func _physics_process(delta: float) -> void:
	if isDead:
		return
	
	if hitstopTimer > 0.0:
		hitstopTimer -= delta
		sprite.pause()
		return
	
	sprite.play()
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	velocity.x = move_toward(velocity.x , 0, FRICTION * delta)
	
	sprite.flip_h = facing < 0
	
	stateMachine.update(delta)
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	var centerX = get_viewport().get_visible_rect().size.x / 2
	var touchLeft = event.position.x < centerX
	
	if screenSide == Side.LEFT and not touchLeft: return
	if screenSide == Side.RIGHT and touchLeft: return
	
	stateMachine.input(event)

func take_damage(dmg: float, kb: float, dir: float) -> void:
	if isDead:
		return
	
	health = max(0.0, health - dmg)
	health_changed.emit(health, stats.maxHealth)
	print(name, ", Damage took: ", dmg, ", Health: ", health)
	if health == 0.0:
		stateMachine.change_state(DeadState.new(self, stateMachine))
		return
	stateMachine.change_state(HitState.new(self, stateMachine, kb, dir))

func apply_hitstop(duration: float) -> void:
	hitstopTimer = duration
