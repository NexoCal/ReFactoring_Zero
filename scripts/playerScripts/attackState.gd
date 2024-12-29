extends State
class_name attackState
@onready var player: CharacterBody2D = $"../.."
@onready var attack1col: CollisionShape2D = $"../../Marker2D/attackbox/attack1Col"
@onready var attack2col: CollisionShape2D = $"../../Marker2D/attackbox/attack2Col"
#@onready var attack3col: CollisionShape2D = $"../../Marker2D/Area2D/attack3Col"
@onready var attack4col: CollisionShape2D = $"../../Marker2D/attackbox/attack4Col"
@onready var attack3col: CollisionShape2D = $"../../Marker2D/attackbox/attack1Col"


@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
var attackMove = 4
var resetAttack
var comboAttack
var canMove

func enter():
	animplay.play("attack-1")
	attackMove -= 1
	$attackComboTimer.start(0.3)
	$attackTimer.start(0.5)
	$moveAttack.start(0.4)
	resetAttack = false
	canMove = false
	

func update(_delta:float):
	
	if player.velocity.x !=0:
		player.velocity.x = lerp(player.velocity.x,0.0,0.2)
		
	if resetAttack == true:
		stateTrans.emit(self,"idle")
	else:
		if Input.is_action_just_pressed("attack") and comboAttack == true and player.is_on_floor():
			
			if attackMove == 4:
				player.attackVal = 20
				animplay.play("attack-1")
				$attackComboTimer.start(0.3)
				$attackTimer.start(0.5)
				$moveAttack.start(0.4)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 3:
				player.attackVal = 20
				animplay.play("attack-2")
				$moveAttack.start(0.3)
				$attackComboTimer.start(0.6)
				$attackTimer.start(0.9)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 2:
				player.attackVal = 20
				animplay.play("attack-3")
				$attackComboTimer.start(0.3)
				$attackTimer.start(0.7)
				$moveAttack.start(0.1)
				attackMove -= 1
				comboAttack = false
				
			elif attackMove == 1:
				player.attackVal = 40
				animplay.play("attack-4")
				$attackComboTimer.start(0.3)
				$attackTimer.start(0.5)
				$moveAttack.start(0.3)
				attackMove = 4
				comboAttack = false
				
	if Input.is_action_just_pressed("dash") and player.canDash:
		attack1col.set_disabled(true)
		attack2col.set_disabled(true)
		attack3col.set_disabled(true)
		attack4col.set_disabled(true)
		animplay.stop()
		stateTrans.emit(self,"dash")
		

func exit():
	resetAttack = null
	comboAttack = false
	player.attackVal = 20
	attackMove = 4
	


func _on_attack_timer_timeout() -> void:
	resetAttack = true
	print("AttackOut")
	pass # Replace with function body.


func _on_attack_combo_timer_timeout() -> void:
	comboAttack = true
	pass # Replace with function body.


func _on_move_attack_timeout() -> void:
	canMove = true
	print("move")
	pass # Replace with function body.
	
func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyAttacks") and player.isHurt == false and player.isPdodge == false:
		var attacker = area.get_owner()
		player.health -= attacker.attackVal
		print(str(player.health) + "Left for Player")
		stateTrans.emit(self,'hurt')
