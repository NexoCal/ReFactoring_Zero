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
		if Input.is_action_pressed("moveDown") and player.is_on_floor():
			player.position.y += 1
		else:
			stateTrans.emit(self,"jump")
		
	if Input.is_action_just_pressed("attack") and player.is_on_floor():
		stateTrans.emit(self, "attackState")
	
	if !Input.is_action_pressed("moveLeft") and !Input.is_action_pressed("moveRight"):
		stateTrans.emit(self,"idle")
		
	
	

func exit():
	pass


func _on_hit_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemyAttacks") and player.isHurt == false and player.isPdodge == false and get_parent().currentState.name == "running":
		var attacker = area.get_owner()
		player.health -= attacker.attackVal
		
		print(str(player.health) + "Left for Player")
		freezeTime(0.1,0.5)
		stateTrans.emit(self,'hurt')
		
func freezeTime(timeScale, duration):
	Engine.time_scale = timeScale
	await player.get_parent().get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1.0
