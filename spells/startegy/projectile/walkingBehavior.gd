extends SpellBehavior
class_name WalkingBehavior

@export var spell_scene : PackedScene
@export var life_time : int
@export var walking_speed : int

func cast(game_object: Node2D):
	var spell = spell_scene.instantiate()
