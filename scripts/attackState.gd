extends State
class_name attackState


@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
var attackMove = 4
var resetAttack
var comboAttack

func enter():
	animplay.play("attack-1")
	attackMove -= 1
	$attackComboTimer.start()
	$attackTimer.start()
	resetAttack = false
	comboAttack =true

func update(_delta:float):
	if resetAttack == true:
		stateTrans.emit(self,"idle")
	else:
		if Input.is_action_just_pressed("attack") and comboAttack == true:
			if attackMove == 0:
				stateTrans.emit(self,"idle")
			
			if attackMove == 3:
				animplay.play("attack-2")
				$attackComboTimer.start()
				$attackTimer.start()
				attackMove -= 1
			elif attackMove == 2:
				animplay.play("attack-3")
				$attackComboTimer.start()
				$attackTimer.start()
				attackMove -= 1
			elif attackMove == 1:
				animplay.play("attack-4")
				$attackComboTimer.start()
				$attackTimer.start()
				attackMove -= 1
		

func exit():
	resetAttack = null
	comboAttack = null
	attackMove = 4


func _on_attack_timer_timeout() -> void:
	resetAttack = true
	print("AttackOut")
	pass # Replace with function body.


func _on_attack_combo_timer_timeout() -> void:
	comboAttack = false
	print("ComboOut")
	pass # Replace with function body.
