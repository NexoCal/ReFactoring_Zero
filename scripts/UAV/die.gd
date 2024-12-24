extends State
class_name Die
@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"
@onready var hitscan: CollisionShape2D = $"../../Marker2D/Area2D/hitScan"
@onready var uav_drone: CharacterBody2D = $"../.."

func enter():
	uav_drone.died = true
	hitscan.set_disabled(true)
	animplay.play('die')
	$despawning.start(1.8)
	

func update(_delta: float):
	pass
	
func exit():
	pass


func _on_despawning_timeout() -> void:
	owner.queue_free()
