# Klaed Fighter logic
extends Area2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@onready var speed = GlobalVars.klaed_fighter_speed
@onready var hp = GlobalVars.klaed_fighter_health
@onready var point = GlobalVars.klaed_fighter_point
@onready var bullet_instance_scene = preload("res://scene/ennemy/klaed_fighter_bullet_ennemy.tscn")
@onready var pickup_scene = preload("res://scene/pickup/pickup_life.tscn")
@onready var shooting_point_canon = $ShootingPointCanon
@onready var old_color = self.modulate
@onready var fire_rate = GlobalVars.klaed_fighter_fire_rate
@onready var shoot_delay = GlobalVars.klaed_fighter_shoot_delay
@onready var min_number_of_bullets = GlobalVars.klaed_fighter_min_number_of_bullets
@onready var max_number_of_bullets = GlobalVars.klaed_fighter_max_number_of_bullets
@export var bullet_count: int = 30
@export var ring_count: int = 5
@export var ring_delay: float = 0.2
@export var bullet_speed: float = 200

func _ready():
	randomize()
	$FireRate.wait_time = fire_rate
	$FireRate.start()

# Called every frame
func _process(delta: float) -> void: 
	global_position.x -= speed * delta # managing the ennemy ship movement
	$EngineFighter.animation = "powering"
	$EngineFighter.play() 

# managing the ennemy death
func die():
	$CollisionShape2D.disabled = true
	$EngineFighter.hide()
	$BaseFighter.animation = "destruction"
	$BaseFighter.play()
	GlobalSignal.ennemy_death.emit(point)
	var pickup_instance = pickup_scene.instantiate()
	pickup_instance.global_position = global_position
	get_tree().current_scene.add_child(pickup_instance)
	
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
		GlobalSignal.player_invincibility.emit()

# Function for remove hp to the ennemy with some shiny effect
func ennemy_remove_hp():
	$BaseFighter.modulate = Color(255,255,255)
	await get_tree().create_timer(0.1).timeout
	$BaseFighter.modulate = old_color
	hp -=1
	if hp <= 0:
		die()		
		
func shoot():		
	var bullet_instance1 = bullet_instance_scene.instantiate()
	bullet_instance1.global_position = shooting_point_canon.global_position
	get_parent().add_child(bullet_instance1)
	
	
func _on_fire_rate_timeout() -> void:
	shoot_expanding_rings()

func fire_x_shots():
	for i in randi() % min_number_of_bullets + max_number_of_bullets:  # Tire trois projectiles
		shoot()
		await get_tree().create_timer(shoot_delay).timeout

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	shoot_expanding_rings()

func shoot_expanding_rings():
	_shoot_expanding_rings(0)

func _shoot_expanding_rings(ring_index):
	if ring_index >= ring_count:
		return

	for i in range(bullet_count):
		var bullet = bullet_instance_scene.instantiate()
		if bullet and bullet is Area2D:
			get_parent().call_deferred("add_child", bullet)
			var angle = TAU * i / bullet_count
			var direction = Vector2.RIGHT.rotated(angle)
			bullet.global_position = global_position
			bullet.direction = direction  # On définit la direction
			bullet.speed = bullet_speed + ring_index * 50  # On ajuste la vitesse

	get_tree().create_timer(ring_delay).timeout.connect(func(): _shoot_expanding_rings(ring_index + 1))
