extends State
class_name idleUAV

@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var uavdrone: CharacterBody2D = $"../.."


@onready var player = get_parent().get_parent().get_parent().get_node("player")
@onready var marker2d: Marker2D = $"../../Marker2D"


func enter():
	animplay.play("idle")

func update(_delta: float):
	
	
	if uavdrone.follow == true and uavdrone.targetX >0.0:
		uavdrone.velocity.x = uavdrone.SPEED
		marker2d.scale.x = -1
		uavdrone.MAXDIST = 400
	elif uavdrone.follow == true and uavdrone.targetX <0.0:
		uavdrone.velocity.x = -uavdrone.SPEED
		marker2d.scale.x = 1
		uavdrone.MAXDIST = 400
		
	
	if abs(uavdrone.targetX) < uavdrone.MAXDIST:
		uavdrone.follow = false
		uavdrone.velocity.x = 0
		stateTrans.emit(self,"attack")
		
	elif abs(uavdrone.targetX) > uavdrone.MAXDIST:
		uavdrone.follow = true
		
		
func exit():
	pass
