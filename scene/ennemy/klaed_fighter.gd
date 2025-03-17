# Klaed Fighter logic
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@export var speed = GlobalVars.klaed_fighter_speed
@onready var hp = GlobalVars.klaed_fighter_health
@onready var point = GlobalVars.klaed_fighter_point
@onready var bullet_hit = preload("res://assets/sound/metal-hit.wav")
@onready var old_color = self.modulate

# Called every frame
func _process(delta: float) -> void: 
	global_position.x -= speed * delta # managing the ennemy ship movement
	global_position.y -= sin( global_position.x * delta * 1.1)
	$EngineFighter.animation = "powering"
	$EngineFighter.play() 

# managing the ennemy death
func die(): 
	$EngineFighter.hide()
	$BaseFighter.animation = "destruction"
	$BaseFighter.play()
	GlobalSignal.ennemy_death.emit(point)
	
# clean ennemy from memory after playing death animation
func _on_base_fighter_animation_finished() -> void: 
	queue_free()

# clean ennemy from memory if he leave the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Emission of signal if touch the player
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		GlobalSignal.player_touched_by_ennemy.emit()

# Function for remove hp to the ennemy with some shiny effect
func ennemy_remove_hp():
	$BulletHit.stream = bullet_hit
	$BulletHit.play()
	$BaseFighter.modulate = Color(255,255,255)
	await get_tree().create_timer(0.1).timeout
	$BaseFighter.modulate = old_color
	hp -=1
	if hp <= 0:
		die()		
