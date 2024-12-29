extends CharacterBody2D

@onready var player = get_parent().get_node("player")

const SPEED = 400.0
const  GRAVITY = 980.0
var MAXDIST = 400.0
var health = 100
var attackVal = 10
var died = false

var playerX
var targetX
var follow 

func _ready() -> void:


	MAXDIST = 400.0
	health = 100
	attackVal = 10
	died = false

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	playerX = player.position.x
	targetX = playerX - position.x
	
	move_and_slide()


	
