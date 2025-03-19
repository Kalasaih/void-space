# Bullet projectile logic for player
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@onready var speed = GlobalVars.laser_speed

# Called every frame
func _process(delta: float) -> void: # management the mouvement of the bullet
	global_position.x += speed * delta
	$Laser.animation = "moving"
	$Laser.play()

# Clean memory when screen exited
func _on_visible_on_screen_notifier_2d_screen_exited() -> void: 
	queue_free() # Replace with function body.

# Function to manage damage done to ennemy
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ennemy"):
		area.ennemy_remove_hp()
		queue_free()
