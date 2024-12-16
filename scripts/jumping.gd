extends State
class_name Jump

@onready var player: CharacterBody2D = $"../.."
@onready var marker2d: Marker2D = $"../../Marker2D"
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	player.velocity.y = -player.JUMPVELOCITY

func update(_delta:float):
	if Input.is_action_pressed("moveRight"):
		marker2d.scale.x = 1
		player.velocity.x = player.AIRSPEED
		
	elif Input.is_action_pressed("moveLeft"):
		marker2d.scale.x = -1
		player.velocity.x = -player.AIRSPEED
		
	else:
		player.velocity.x = 0
		
		
	if player.is_on_floor() and player.velocity.x == 0:
		stateTrans.emit(self,"idle")
	elif player.is_on_floor() and player.velocity.x != 0:
		stateTrans.emit(self,"running")
		
func exit():
	pass
