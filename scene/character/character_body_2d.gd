# player ship
extends CharacterBody2D

# Variable for parameters and assets
@export var speed = 30000
@onready var bullet_instance = preload("res://scene/character/bullet.tscn")
@onready var bullet_instance2 = preload("res://scene/character/bullet.tscn")
@onready var shooting_point_canon_1 = $ShootingPointCanon1
@onready var shooting_point_canon_2 = $ShootingPointCanon2
@onready var canon_sound = preload("res://assets/sound/autocannon-20mm.wav")

# Called every frame
func _physics_process(delta: float) -> void:
	# managing movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	velocity = input_dir * speed * delta
	
	if velocity.x != 0 or velocity.y != 0:
		$MotorEffect.animation = "powering"
		$MotorEffect.play()
	else:
		$MotorEffect.animation = "idle"
		$MotorEffect.play()
		
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	# interpret movement	
	move_and_slide()
	
	# clamp the player in the limit of the playable area
	var screen_size = get_viewport_rect().size
	global_position = global_position.clamp(Vector2.ZERO, screen_size)

# shoot fonction for ship	
func shoot():		
	$AutoCanon.animation = "fire"
	$AutoCanon.play()
	
	$CanonSound.stream = canon_sound
	$CanonSound.play()
	var bullet_instance = bullet_instance.instantiate()
	bullet_instance.global_position = shooting_point_canon_1.global_position
	owner.add_child(bullet_instance)

	var bullet_instance2 = bullet_instance2.instantiate()
	bullet_instance2.global_position = shooting_point_canon_2.global_position
	owner.add_child(bullet_instance2)
	
func player_remove_hp_signal():
	GlobalSignal.player_touched_by_ennemy.emit()
