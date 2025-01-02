extends Control

var progress = []
var listScene
var sceneName
var loadStatus
var mult = 20
@export var sceneManager = Resource




func _ready() -> void:
	
	print(sceneManager.sceneList.size())
	var scenegetter = sceneManager.selectNextScene()
	sceneName = scenegetter.get_path()
	print(sceneName)
	ResourceLoader.load_threaded_request(sceneName)
	
	$Progress.value = 0
	
	print(sceneManager.sceneList)
	
func selectNextScene():
	var availableRoom = sceneManager.sceneList.size()
	var selector = randi_range(0,availableRoom-1)
	var selectedRoom = sceneManager.sceneList[selector]
	sceneManager.usedScene.append(selectedRoom)
	sceneManager.sceneList.remove_at(selector)
	return selectedRoom	


	
func _process(delta: float) -> void:
	
	
	loadStatus = ResourceLoader.load_threaded_get_status(sceneName, progress)
	$Progress.value = 100 - ($artiload.time_left * mult)

func _on_artiload_timeout() -> void:
	$waitEnd.start(2)
	
func _on_wait_end_timeout() -> void:
	get_tree().change_scene_to_file(sceneName)
