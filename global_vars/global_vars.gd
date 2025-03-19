extends Node

# Global game vars 
var score = 0

# Player vars
var player_health = 5
var player_max_health = 5
var player_speed = 38000
var player_fire_rate = 0.4
var player_is_invincible = false
var player_invincibility_duration = 0.2
var laser_speed = 750

# Pickup vars
var pickup_drop_chance = 0.1
var pickup_speed = 50
var life_given = 1

# Klaed fighter ennemy vars
var klaed_fighter_health = 2
var klaed_fighter_point = 10
var klaed_fighter_speed = 350
var klaed_fighter_bullet_speed = 550
var klaed_fighter_fire_rate = 2
var klaed_fighter_shoot_delay = 0.3
var klaed_fighter_min_number_of_bullets = 3
var klaed_fighter_max_number_of_bullets = 5
