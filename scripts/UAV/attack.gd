extends State
class_name attackUAV

@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var uavdrone: CharacterBody2D = $"../.."
@onready var attackcooldown: Timer = $attackCooldown

var canAttack

@onready var player = get_parent().get_parent().get_parent().get_node("player")
@onready var marker2d: Marker2D = $"../../Marker2D"


func enter():
	animplay.play("attack")
	attackcooldown.start(1.5)
	canAttack = false
	pass

func update(_delta: float):
	
	if uavdrone.targetX < -10:
			marker2d.scale.x = 1
	elif uavdrone.targetX > -10:
			marker2d.scale.x = -1
	
	if abs(uavdrone.targetX) > uavdrone.MAXDIST:
		stateTrans.emit(self,"chase")
	elif canAttack == true:
		animplay.play("attack")
		attackcooldown.start(1.5)
		canAttack = false
	
	
	
	
func exit():
	pass


func _on_attack_cooldown_timeout() -> void:
	canAttack = true
	pass # Replace with function body.
