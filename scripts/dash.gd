extends State
class_name Dash

@onready var player: CharacterBody2D = $"../.."
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack1col: CollisionShape2D = $"../../Marker2D/Sprite2D/Area2D/attack1Col"
@onready var attack2col: CollisionShape2D = $"../../Marker2D/Sprite2D/Area2D/attack2Col"
@onready var attack3col: CollisionShape2D = $"../../Marker2D/Sprite2D/Area2D/attack3Col"
@onready var attack4col: CollisionShape2D = $"../../Marker2D/Sprite2D/Area2D/attack4Col"

var dashOver = false

func enter():
	
	attack1col.set_disabled(true)
	attack2col.set_disabled(true)
	attack3col.set_disabled(true)
	attack4col.set_disabled(true)
	
	$dashTime.start(0.2)
	$dashCooldown.start(0.5)
	animplay.play('dash')
	player.canDash = false

func update(_delta: float):
	if Input.is_action_pressed("moveRight"):
		player.velocity.x = player.DASHSPEED
		
		
	elif Input.is_action_pressed("moveLeft"):
		player.velocity.x = -player.DASHSPEED
		
	else:
		if player.direction == Vector2.RIGHT:
			player.velocity.x = player.DASHSPEED
		elif player.direction == Vector2.LEFT:
			player.velocity.x = -player.DASHSPEED
	
	
	
	if (Input.is_action_pressed("moveRight") or Input.is_action_pressed("moveLeft")) and dashOver:
		stateTrans.emit(self,"running")
		
	elif dashOver:
		stateTrans.emit(self,"idle")
		

func exit():
	player.canDash = true
	dashOver = false
	pass


func _on_dash_time_timeout() -> void:
	dashOver = true
	pass # Replace with function body.


func _on_dash_cooldown_timeout() -> void:
	player.canDash = true
	pass # Replace with function body.
