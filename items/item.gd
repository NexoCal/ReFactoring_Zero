extends Area2D
class_name Item



@export var sprite: Sprite2D
@export var itemStrategy: baseItemStrategy:
	set(val):
		itemStrategy = val
		needs_update = true

@export var needs_update = false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = itemStrategy.texture


func _process(delta: float) -> void:
	
	
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = itemStrategy.texture
			needs_update = false

func on_body_entered(body: PhysicsBody2D):
	print("touch")
	if body is Player:
		######################################
		# Strategy Relevant Code:
		# This adds the upgrade to our player,
		# which the player uses when firing.
		######################################
		body.inventory.itemslot.append(itemStrategy)
		owner.queue_free()
