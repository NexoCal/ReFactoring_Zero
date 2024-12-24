extends Node2D

var playerScene = preload("res://scene/player.tscn")
var enemy = preload("res://scene/uav_drone.tscn")

var enemypos1
var enemypos2
var enemypos3

func _ready() -> void:
	enemypos1 = $enemyspawn1.position
	enemypos2 = $enemyspawn2.position
	enemypos3 = $enemyspawn3.position
	$enemySpawnTimer.start(0.5)
	init()

func init() -> void:
	var player = playerScene.instantiate()
	player.position = $playerSpawn.position
	$enemy1spawn.position = enemypos1
	$enemy2spawn.position = enemypos2
	$enemy3spawn.position = enemypos3
	add_child(player)


func _on_enemy_spawn_timer_timeout() -> void:
	var spawn1 = enemy.instantiate()
	var spawn2 = enemy.instantiate()
	var spawn3 = enemy.instantiate()
	spawn1.position = enemypos1
	spawn2.position = enemypos2
	spawn3.position = enemypos3
	add_child(spawn1)
	add_child(spawn2)
	add_child(spawn3)
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeTestScene"):
		get_tree().change_scene_to_file("res://scene/CRoom01.tscn")
