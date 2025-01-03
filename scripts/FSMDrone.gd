extends Node
class_name FSMDrone

@onready var uavdrone: CharacterBody2D = $".."
@onready var player = get_parent().get_parent().get_node("player")
@onready var animplay: AnimationPlayer = $"../AnimationPlayer"

signal resetAttack

var states: Dictionary = {}
var currentState
@export var init_state : State
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.stateTrans.connect(change_state)
	
	if init_state:
		init_state.enter()
		currentState = init_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentState:
		currentState.update(delta)

func change_state(srcState, newState):
	if srcState != currentState:
		print("Invalid change_state trying from: " + srcState.name + " but currently in: " + currentState.name)
		return
	
	var targetState = states.get(newState.to_lower())
	if !targetState:
		print("New state empty")
		return
	
	if currentState:
		currentState.exit()
	
	targetState.enter()
	
	currentState = targetState
	print("changed")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("playerAttacks") and !uavdrone.died:
		for i in player.inventory.itemslot:
			if i.type == "Offensive":
				i.applyUpgrade(player)
		uavdrone.health -= player.attackVal
		animplay.play('hitFlash')
		freezeTime(0.1,0.3)
		print(uavdrone.health)
		if uavdrone.health <= 0:
			change_state(currentState,"die")
		else:
			resetAttack.emit()

			
func freezeTime(timeScale, duration):
	Engine.time_scale = timeScale
	await player.get_parent().get_tree().create_timer(duration * timeScale).timeout
	Engine.time_scale = 1.0
