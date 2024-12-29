extends Node2D

func _physics_process(delta: float) -> void:
	var unit = get_viewport().get_texture().get_size() / Vector2(get_viewport_rect().size)
	$CanvasLayer/Control/GlowProcess.get_material().set_shader_parameter("unit", unit)
