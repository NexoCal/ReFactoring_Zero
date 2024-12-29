extends State
class_name attackUAV

@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var uavdrone: CharacterBody2D = $"../.."
@onready var attackcooldown: Timer = $attackCooldown
@onready var lockmove: Timer = $lockMove

var canAttack
var canMove

@onready var player = get_parent().get_parent().get_parent().get_node("player")
@onready var marker2d: Marker2D = $"../../Marker2D"


func enter():
	animplay.play("attack")
	attackcooldown.start(1.5)
	lockmove.start(0.3)
	canAttack = false
	get_parent().resetAttack.connect(resetAttackaAnim)
	pass

func update(_delta: float):
	
	if uavdrone.targetX < -10 and canMove:
			marker2d.scale.x = 1
	elif uavdrone.targetX > -10 and canMove:
			marker2d.scale.x = -1
	
	if abs(uavdrone.targetX) > uavdrone.MAXDIST and canMove:
		stateTrans.emit(self,"chase")
	elif canAttack == true:
		animplay.play("attack")
		attackcooldown.start(1.5)
		lockmove.start(0.3)
		canAttack = false
	
	
	
	
func exit():
	pass


func _on_attack_cooldown_timeout() -> void:
	canAttack = true
	canMove = true
	pass # Replace with function body.


func _on_lock_move_timeout() -> void:
	canMove = false
	pass # Replace with function body.

func resetAttackaAnim():
	animplay.seek(0.0)
	pass
