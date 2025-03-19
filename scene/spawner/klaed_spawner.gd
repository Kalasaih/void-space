# Klaed Spawner
extends Node2D

# Variable definition
@onready var spawn_point = $SpawnPoint
@onready var klaed_fighter_scene = preload("res://scene/ennemy/klaed_fighter.tscn")

# Managing spawn by waves with timer
func _on_spawn_timer_timeout() -> void:
	var random_spawn_point = spawn_point.get_children().pick_random()
	var klaed_fighter = klaed_fighter_scene.instantiate()
	klaed_fighter.global_position = random_spawn_point.global_position
	owner.add_child(klaed_fighter)
