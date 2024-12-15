extends State
class_name Idle

@onready var animplay: AnimationPlayer = $"../../AnimationPlayer"

func enter():
	animplay.play("idle")

func update(_delta:float):
	if Input.is_action_just_pressed("attack"):
		print("clicked!")
		stateTrans.emit(self, "attackState")
	

func exit():
	pass
