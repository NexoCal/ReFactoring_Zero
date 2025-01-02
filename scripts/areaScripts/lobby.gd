extends Node2D

var insideTp = false

func _on_teleport_area_body_entered(body: CharacterBody2D) -> void:
	if body is Player:
		$TpText.set_visible(true)
		insideTp = true


func _on_teleport_area_body_exited(body: Node2D) -> void:
	$TpText.set_visible(false)
	insideTp = false

func _process(delta: float) -> void:
	if insideTp:
		if Input.is_action_just_pressed("confirmation"):
			get_tree().change_scene_to_file("res://scene/CRoom01.tscn")
