extends State
class_name Idle

@onready var attack_state: attackState = $"../attackState"
@onready var player: CharacterBody2D = $"../.."
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var marker2d: Marker2D = $"../../Marker2D"

func enter():
	animplay.play("idle")

func update(_delta:float):
	if player.velocity.x !=0:
		player.velocity.x = lerp(player.velocity.x,0.0,0.3)
	
	if Input.is_action_just_pressed("attack") and player.is_on_floor():
		stateTrans.emit(self, "attackState")
	
	if !attack_state.canMove == false and (Input.is_action_pressed("moveLeft") or Input.is_action_pressed("moveRight")):
		stateTrans.emit(self,"running")
		
	if !attack_state.canMove == false and Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		stateTrans.emit(self,"jump")
		
	if Input.is_action_just_pressed("dash") and player.canDash:
		stateTrans.emit(self,"dash")
		print("DASH")
func exit():
	pass
