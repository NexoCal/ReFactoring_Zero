extends Resource
class_name SceneLoaderLoad

@export var sceneList : Array[PackedScene]
var loadedScene =[]
var usedScene = []

func selectNextScene():
	var availableRoom = sceneList.size()
	var selector = randi_range(0,availableRoom-1)
	var selectedRoom = sceneList[selector]
	usedScene.append(selectedRoom)
	sceneList.remove_at(selector)
	return selectedRoom
