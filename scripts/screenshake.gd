extends Camera2D

@export var randStrength: float = 10.0
@export var shakefade : float = 5.0

var rng = RandomNumberGenerator.new()
var shakeStreght: float = 0.0

func applyShake():
	shakeStreght = randStrength
	
	

func _process(delta: float) -> void:
	pass
	

func randOffset():
	return Vector2(rng.randf_range(-shakeStreght,shakeStreght),rng.randf_range(-shakeStreght,shakeStreght))
	
