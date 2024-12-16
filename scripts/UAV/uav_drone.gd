extends CharacterBody2D

@onready var player = get_parent().get_node("player")

const SPEED = 400.0
const  GRAVITY = 980.0
var MAXDIST = 200.0

var playerX
var targetX
var follow 


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	playerX = player.position.x
	targetX = playerX - position.x
	

	move_and_slide()
