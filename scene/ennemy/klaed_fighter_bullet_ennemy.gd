# bullet projectile logic for player
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@onready var speed = GlobalVars.klaed_fighter_bullet_speed

# Called every frame
func _process(delta: float) -> void: # management the mouvement of the bullet
	global_position.x -= speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalSignal.player_touched_by_ennemy_bullet.emit()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # Replace with function body.
