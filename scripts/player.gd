extends CharacterBody2D

@onready var animtree: AnimationTree = $AnimationTree
@onready var animplayer: AnimationPlayer = $AnimationPlayer

enum state{
	idle,
	run,
	attack
}


var attack = 4

var stateMachine
var p_state = state.idle

var SPEED = 500.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_floor():
		SPEED = 500
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		SPEED = 300
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moveLeft", "moveRight")
	
	if direction>0:
		$Marker2D.scale.x = 1
		velocity.x = direction * SPEED
	elif direction<0:
		$Marker2D.scale.x = -1
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
