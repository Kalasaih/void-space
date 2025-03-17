# bullet projectile for player
extends Area2D

@export var speed = 600 # bullet speed
@onready var bullet_hit = preload("res://assets/sound/metal-hit.wav")
var old_color = self.modulate

# Called every frame
func _process(delta: float) -> void: # management the mouvement of the bullet
	global_position.x += speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void: # clean bullet from the memory
	queue_free() # Replace with function body.

func _on_area_entered(area: Area2D) -> void: # management collision and effect with ennemy
	if area.is_in_group("Ennemy"):
		area.ennemy_remove_hp()
		queue_free()
