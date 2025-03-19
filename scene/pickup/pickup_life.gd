# Logic for life pickup
extends Area2D

@onready var life_given = GlobalVars.life_given
@onready var speed = GlobalVars.pickup_speed
@onready var old_color = self.modulate

# Management the mouvement of the pickup 
func _process(delta: float) -> void: 
	global_position.x -= speed * delta

# Management the health up for the player
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$LifeSprite.modulate = Color(255,255,255)
		await get_tree().create_timer(0.1).timeout
		$LifeSprite.modulate = old_color
		GlobalSignal.pickup_life.emit(life_given)
		queue_free()
