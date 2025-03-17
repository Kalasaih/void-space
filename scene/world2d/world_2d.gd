# Global game logical
extends Node2D

# initialise the score 
@onready var global_vars = get_node("/root/GlobalVars")
@onready var scoring_label = $HUD/scoring_label
@onready var player_hp_label = $HUD/player_hp_label

var score = 0
var player_health = GlobalVars.player_health

func _ready() -> void:
	
# connect ennemy_death signal
	GlobalSignal.ennemy_death.connect(_on_scoring_ennemy_death)
	GlobalSignal.player_touched_by_ennemy.connect(_player_remove_hp)
	
# add point to score every timer timeout
func _on_scoring_timer_timeout() -> void:
	score += 1

# add point to score when ennemy die
func _on_scoring_ennemy_death() -> void:
	score += 1

# remove hp to player	
func _player_remove_hp() -> void:
	player_health -=1	

# game over function
func game_over() -> void:
	get_tree().change_scene_to_file("res://scene/gameover/game_over.tscn")

# processed every frame to update the score
func _process(_delta) -> void:
	scoring_label.text = "Score : " + str(score)
	player_hp_label.text = "HP : " + str(player_health)

	if player_health <= 0: # pop game over if hp <= 0
		game_over()
