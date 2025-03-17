# Klaed Fighter
extends Area2D

#set ennemy speed
@export var speed = 350
var hp = GlobalVars.klaed_fighter_ennemy_health
@onready var bullet_hit = preload("res://assets/sound/metal-hit.wav")
var old_color = self.modulate


# Called every frame
func _process(delta: float) -> void: 
	global_position.x -= speed * delta # managing the ennemy ship movement
	$EngineFighter.animation = "powering"
	$EngineFighter.play() 

func die(): # managing the ennemy death
	$EngineFighter.hide()
	$BaseFighter.animation = "destruction"
	$BaseFighter.play()
	GlobalSignal.ennemy_death.emit()
	
func _on_base_fighter_animation_finished() -> void: # clean ennemy from memory after playing death animation
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void: # clean ennemy from memory if he leave the screen
	queue_free() # Replace with function body.

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		body.player_remove_hp_signal()

func ennemy_remove_hp():
	$BulletHit.stream = bullet_hit
	$BulletHit.play()
	$BaseFighter.modulate = Color(255,255,255)
	await get_tree().create_timer(0.1).timeout
	$BaseFighter.modulate = old_color
	hp -=1
	if hp <= 0:
		die()		
