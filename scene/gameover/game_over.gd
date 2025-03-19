# Game over management
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CenterContainer/Retry.grab_focus()

# Load the game again
func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/gamecontroller/game_controller.tscn")

# Back to main menu
func _on_go_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/mainmenu/main_menu.tscn")
