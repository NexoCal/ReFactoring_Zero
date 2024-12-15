extends State
class_name attackState


@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
var attackMove = 4
var resetAttack
var comboAttack

func enter():
	animplay.play("attack-1")
	attackMove -= 1
	$attackComboTimer.start(0.2)
	$attackTimer.start(0.5)
	resetAttack = false
	

func update(_delta:float):
	if resetAttack == true:
		stateTrans.emit(self,"idle")
	else:
		if Input.is_action_just_pressed("attack") and comboAttack == true:
			
			if attackMove == 4:
				animplay.play("attack-1")
				$attackComboTimer.start(0.2)
				$attackTimer.start(0.5)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 3:
				animplay.play("attack-2")
				$attackComboTimer.start(0.5)
				$attackTimer.start(1.1)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 2:
				animplay.play("attack-3")
				$attackComboTimer.start(0.2)
				$attackTimer.start(0.7)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 1:
				animplay.play("attack-4")
				$attackComboTimer.start(0.3)
				$attackTimer.start(0.6)
				attackMove = 4
				comboAttack = false
		

func exit():
	resetAttack = null
	comboAttack = null
	attackMove = 4


func _on_attack_timer_timeout() -> void:
	resetAttack = true
	print("AttackOut")
	pass # Replace with function body.


func _on_attack_combo_timer_timeout() -> void:
	comboAttack = true
	pass # Replace with function body.
