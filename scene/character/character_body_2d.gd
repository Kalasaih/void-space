# Player ship logic
extends CharacterBody2D

# Variable definition issued from GlobalVars Singleton & Asset preload
@export var speed = GlobalVars.player_speed
@onready var bullet_instance_scene = preload("res://scene/character/laser.tscn")
@onready var shooting_point_canon_1 = $ShootingPointCanon
@onready var can_shoot = true
@onready var fire_rate = GlobalVars.player_fire_rate
@onready var player_invincibility_duration = GlobalVars.player_invincibility_duration

# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalSignal.player_invincibility.connect(player_invincibility)

# Called every frame
func _physics_process(delta: float) -> void:
	
	# managing movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	velocity = input_dir * speed * delta
	
	if velocity.x != 0 or velocity.y != 0:
		$Motor.animation = "powering"
		$Motor.play()
	else:
		$Motor.animation = "idle"
		$Motor.play()

	# Call the shoot function		
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false
		await get_tree().create_timer(fire_rate).timeout
		can_shoot = true
	
	# Interpret movement	
	move_and_slide()
	
	# clamp the player in the limit of the playable area
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, screen_size)

# Shoot function for ship	
func shoot():		
	var bullet_instance1 = bullet_instance_scene.instantiate()
	bullet_instance1.global_position = shooting_point_canon_1.global_position
	owner.add_child(bullet_instance1)

# Player invincibility function	
func player_invincibility():
	GlobalVars.player_is_invincible = true
	await get_tree().create_timer(player_invincibility_duration).timeout
	GlobalVars.player_is_invincible = false
	
