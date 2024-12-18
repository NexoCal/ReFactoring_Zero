extends CharacterBody2D

@onready var player = get_parent().get_node("player")

const SPEED = 400.0
const  GRAVITY = 980.0
var MAXDIST = 400.0
var health = 100

var playerX
var targetX
var follow 

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	playerX = player.position.x
	targetX = playerX - position.x
	

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerAttacks"):
		health -= player.attackVal
		$AnimationPlayer.play('hitFlash')
	
