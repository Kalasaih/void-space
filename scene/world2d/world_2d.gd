# Global game logical
extends Node2D

# initialise the score 
@onready var scoring_label = $HUD/scoring_label
@onready var player_hp_label = $HUD/player_hp_label
@onready var high_score_label = $HUD/high_score_label
@onready var score = GlobalVars.score
@onready var player_health = GlobalVars.player_health
@onready var player_max_health = GlobalVars.player_max_health
@onready var high_score_record = SaveLoad.high_score
@onready var old_color = $CharacterBody2D/BaseShip.modulate

func _ready() -> void:
	GlobalVars.player_is_invincible = false
	high_score_label.text = "High Score : " + str(high_score_record)
	
# Signal BUS connection 
	GlobalSignal.ennemy_death.connect(_on_scoring_ennemy_death)
	GlobalSignal.player_touched_by_ennemy.connect(_player_remove_hp)
	GlobalSignal.player_touched_by_ennemy_bullet.connect(_player_remove_hp)
	GlobalSignal.pickup_life.connect(_player_give_hp)
	
# processed every frame to update the score
func _process(_delta) -> void:
	scoring_label.text = "Score : " + str(score)
	player_hp_label.text = "HP : " + str(player_health)

	if player_health <= 0: # pop game over if hp <= 0
		save_high_score()
		game_over()
	
# add point to score every timer timeout
func _on_scoring_timer_timeout() -> void:
	score += 1

# add point to score when ennemy die
func _on_scoring_ennemy_death(point) -> void:
	score += point

# remove hp to player	
func _player_remove_hp() -> void:
	if GlobalVars.player_is_invincible == false:
		$CharacterBody2D/BaseShip.modulate = Color(255,255,255)
		await get_tree().create_timer(0.2).timeout
		$CharacterBody2D/BaseShip.modulate = old_color
		player_health -=1
	else:
		return	
		
func _player_give_hp(live_given):
	player_health += live_given
	if player_health > player_max_health:
		player_health = player_max_health

# game over function
func game_over() -> void:
	get_tree().change_scene_to_file("res://scene/gameover/game_over.tscn")
	
func save_high_score():
	if score > SaveLoad.high_score:
		SaveLoad.high_score = score
		SaveLoad.save_high_score()
