extends Node
class_name FSM

@onready var uavdrone: CharacterBody2D = $".."
@onready var player = get_parent().get_parent().get_node("player")
@onready var animplay: AnimationPlayer = $"../AnimationPlayer"

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
	



			
