# Main menu
extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$VBoxContainer/Start.grab_focus() # Manage keyboard move on menu item
	
# Launch the first level
func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/gamecontroller/game_controller.tscn")

# Quit game
func _on_quit_pressed() -> void:
	get_tree().quit()
