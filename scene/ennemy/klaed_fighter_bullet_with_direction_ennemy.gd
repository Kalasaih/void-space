# Bullet projectile logic for ennemy with direction parameter
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@onready var speed = GlobalVars.klaed_fighter_bullet_speed
@onready var direction

# Called every frame
func _process(delta): # management the mouvement of the bullet
	global_position += direction * speed * delta

# Function to emit signal when entered the player body
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalSignal.player_touched_by_ennemy_bullet.emit()
		GlobalSignal.player_invincibility.emit()
		
# Clean the memory if quit the screen area
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
