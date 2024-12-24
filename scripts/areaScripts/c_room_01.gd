extends Node2D

var enemy = preload("res://scene/uav_drone.tscn")

var enemypos1
var enemypos2


func _ready() -> void:
	enemypos1 = $enemyspawn1.position
	enemypos2 = $enemyspawn2.position
	$enemySpawnTimer.start(0.5)
	init()

func init() -> void:

	$spawn1.position = enemypos1
	$spawn2.position = enemypos2



func _on_enemy_spawn_timer_timeout() -> void:
	var spawn1t = enemy.instantiate()
	var spawn2t = enemy.instantiate()

	spawn1t.position = enemypos1
	spawn2t.position = enemypos2

	add_child(spawn1t)
	add_child(spawn2t)

	pass # Replace with function body.
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeTestScene"):
		get_tree().change_scene_to_file("res://scene/SO1T2.tscn")
