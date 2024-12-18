extends State
class_name Running

@onready var attack_state: attackState = $"../attackState"
@onready var player: CharacterBody2D = $"../.."
@onready var marker2d: Marker2D = $"../../Marker2D"
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	animplay.play("running")

func update(_delta:float):
	if Input.is_action_pressed("moveRight"):
		marker2d.scale.x = 1
		player.velocity.x += player.FLOORACC
		player.direction = Vector2.RIGHT
		
	elif Input.is_action_pressed("moveLeft"):
		marker2d.scale.x = -1
		player.velocity.x += -player.FLOORACC
		player.direction = Vector2.LEFT
		
	if Input.is_action_just_pressed("dash") and player.canDash:
		stateTrans.emit(self,"dash")
		
		
		
		
	player.velocity.x = clamp(player.velocity.x, -player.FLOORSPEED, player.FLOORSPEED)
		
	if !attack_state.canMove == false and Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		stateTrans.emit(self,"jump")
		
	if Input.is_action_just_pressed("attack") and player.is_on_floor():
		stateTrans.emit(self, "attackState")
	
	if !Input.is_anything_pressed():
		stateTrans.emit(self,"idle")
		
	
	

func exit():
	pass
