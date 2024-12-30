extends CharacterBody2D
class_name Player


@onready var animtree: AnimationTree = $AnimationTree
@onready var animplayer: AnimationPlayer = $AnimationPlayer
@onready var attack_combo_timer: Timer = $statemachine/attackState/attackComboTimer
@onready var attack_timer: Timer = $statemachine/attackState/attackTimer
@onready var attack_state: attackState = $statemachine/attackState
@onready var running: Running = $statemachine/running

@export var stats: Resource
var  FLOORSPEED = 500.0
var  AIRSPEED = 400.0
var JUMPVELOCITY = 600.0
const  GRAVITY = 1100.0
var FLOORACC = 50.0
var DASHSPEED = 1200.0

var direction = Vector2.RIGHT

var canDash = true
var isHurt = false
var isPdodge = false

var attackVal = 20
var attackBoost = 0

var health 
var inventory

func _ready() -> void:
	health = stats.health
	inventory = stats.inventory

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta 
		
	# Handle jump.
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()
