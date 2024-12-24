extends Node2D

var playerScene = preload("res://scene/player.tscn")
var enemy = preload("res://scene/uav_drone.tscn")

var enemypos1
var enemypos2

func _ready() -> void:
	enemypos1 = $enemySpawn1.position
	enemypos2 = $enemySpawn2.position 
	$enemySpawnTimer.start(0.5)
	init()

func init() -> void:
	var player = playerScene.instantiate()
	player.position = $playerSpawn.position
	$SpawnAnim1.position = enemypos1
	$SpawnAnim2.position = enemypos2
	add_child(player)
	
func _on_enemy_spawn_timer_timeout() -> void:
	var spawn1 = enemy.instantiate()
	var spawn2 = enemy.instantiate()
	spawn1.position = enemypos1
	spawn2.position = enemypos2
	add_child(spawn1)
	add_child(spawn2)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeTestScene"):
		get_tree().change_scene_to_file("res://scene/SO1T3.tscn")
	
