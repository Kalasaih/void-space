# Klaed Fighter logic
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
var speed = GlobalVars.klaed_fighter_speed
var hp = GlobalVars.klaed_fighter_health
var point = GlobalVars.klaed_fighter_point
@onready var bullet_instance_scene = preload("res://scene/ennemy/klaed_fighter_bullet_ennemy.tscn")
@onready var pickup_scene = preload("res://scene/pickup/pickup_life.tscn")
@onready var shooting_point_canon = $ShootingPointCanon
var old_color = self.modulate
var fire_rate = GlobalVars.klaed_fighter_fire_rate
var spread_angle = GlobalVars.klaed_fighter_spread_angle
var bullet_speed = GlobalVars.klaed_fighter_bullet_speed
@onready var player = get_tree().get_first_node_in_group("Player")

# Call when the scene enter the tree
func _ready():
	randomize()
	$FireRate.wait_time = fire_rate
	$FireRate.start()

# Called every frame
func _process(delta: float) -> void:
	global_position.x -= speed * delta # managing the ennemy ship movement
	$EngineFighter.animation = "powering"
	$EngineFighter.play() 
	
# Managing the ennemy death
func die():
	$CollisionShape2D.disabled = true
	$EngineFighter.hide()
	$BaseFighter.animation = "destruction"
	$BaseFighter.play()
	GlobalSignal.ennemy_death.emit(point)
	pickup_loot()

# Function to manage pickup loot		
func pickup_loot():
	if randf() <= GlobalVars.pickup_drop_chance:  # randf() return a float between 0.1 & 1
		var pickup_instance = pickup_scene.instantiate()
		pickup_instance.global_position = global_position
		get_parent().add_child(pickup_instance)
		
# Clean ennemy from memory after playing death animation
func _on_base_fighter_animation_finished() -> void: 
	queue_free()

# Clean ennemy from memory if he leave the screen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

# Emission of signal if touch the player
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		GlobalSignal.player_touched_by_ennemy.emit()
		GlobalSignal.player_invincibility.emit()

# Function for remove hp to the ennemy with some shiny effect
func ennemy_remove_hp():
	$BaseFighter.modulate = Color(255,255,255)
	await get_tree().create_timer(0.1).timeout
	$BaseFighter.modulate = old_color
	hp -=1
	if hp <= 0:
		die()		

# Function to shoot for the ennemy	
func shoot():
	var bullet = bullet_instance_scene.instantiate()
	bullet.direction = global_position.direction_to(player.global_position) 
	bullet.global_position = global_position
	get_parent().add_child(bullet)

# Shoot after fire rate reach timeout
func _on_fire_rate_timeout() -> void:
	shoot()

# Function to shoot when entering the screen
func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	shoot()
