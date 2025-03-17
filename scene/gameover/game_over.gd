# Game over management
extends Control

func _ready() -> void:
	$CenterContainer/Retry.grab_focus()

func _on_retry_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/gamecontroller/game_controller.tscn")

func _on_go_to_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/mainmenu/main_menu.tscn")
