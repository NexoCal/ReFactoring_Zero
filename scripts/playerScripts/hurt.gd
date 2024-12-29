extends State
class_name Hurt

@onready var attack_state: attackState = $"../attackState"
@onready var player: CharacterBody2D = $"../.."
@onready var marker2d: Marker2D = $"../../Marker2D"
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@export var randStrength: float = 1.0
@export var shakefade : float = 0.5
@export var playerStats: Resource

@onready var attack1col: CollisionShape2D = $"../../Marker2D/attackbox/attack1Col"
@onready var attack2col: CollisionShape2D = $"../../Marker2D/attackbox/attack2Col"
@onready var attack3col: CollisionShape2D = $"../../Marker2D/attackbox/attack3Col"
@onready var attack4col: CollisionShape2D = $"../../Marker2D/attackbox/attack4Col"

var rng = RandomNumberGenerator.new()
var shakeStreght: float = 0.0

var cam
var canMoveAfter
var effect

func enter():
	
	attack1col.set_disabled(true)
	attack2col.set_disabled(true)
	attack3col.set_disabled(true)
	attack4col.set_disabled(true)
	
	
	
	player.velocity.x = 0
	animplay.play("hurt")
	$hurtCooldown.start(2)
	$lockHurt.start(0.5)
	player.isHurt = true
	canMoveAfter = false
	player.canDash = true
	
	cam = player.get_parent().get_node("Camera2D")
	effect = player.get_parent().get_node("hitEffect")
	
	effect.set_visible(true)

	
	
func update(_delta:float):
	
	applyShake()
	
	if shakeStreght > 0:
		shakeStreght = lerpf(shakeStreght,0,shakefade)
	
	cam.offset = randOffset()

	if player.direction == Vector2.RIGHT:
			player.velocity.x = -200
			player.velocity.y = -10
	elif player.direction == Vector2.LEFT:
			player.velocity.x = 200
			player.velocity.y = -10
	if canMoveAfter:
		stateTrans.emit(self, "idle")
	


func exit():
	cam.offset = Vector2(0,0)
	player.velocity.x = 0
	effect.set_visible(false)
	pass
	


func applyShake():
	shakeStreght = randStrength
	
func randOffset():
	return Vector2(rng.randf_range(-shakeStreght,shakeStreght),rng.randf_range(-shakeStreght,shakeStreght))

func _on_hurt_cooldown_timeout() -> void:
	player.isHurt = false
	print("all set")
	pass # Replace with function body.


func _on_lock_hurt_timeout() -> void:
	canMoveAfter = true
	pass # Replace with function body.
	
