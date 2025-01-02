extends Control

var progress = []
var sceneName

var loadStatus
var mult = 20

func _ready() -> void:
	sceneName = "res://scene/lobby.tscn"
	ResourceLoader.load_threaded_request(sceneName)	
	$Progress.value = 0

func _process(delta: float) -> void:
	loadStatus = ResourceLoader.load_threaded_get_status(sceneName, progress)
	$Progress.value = 100 - ($artiload.time_left * mult)

func _on_artiload_timeout() -> void:
	$waitEnd.start(2)
	
func _on_wait_end_timeout() -> void:
	get_tree().change_scene_to_file(sceneName)
