extends Node

# Global game vars 
var score = 0

# Player vars
var player_health = 100
var player_max_health = 3
var player_speed = 40000
var player_fire_rate = 0.4
var player_is_invincible = false
var player_invincibility_duration = 0.2
var player_bullet_count = 2
var player_laser_spacing = 20
var laser_speed = 1200

# Pickup vars
var pickup_drop_chance = 0.15
var pickup_speed = 50
var life_given = 1

# Klaed fighter ennemy vars
var klaed_fighter_health = 1
var klaed_fighter_point = 10
var klaed_fighter_speed = 350
var klaed_fighter_bullet_speed = 600
var klaed_fighter_fire_rate = 2
var klaed_fighter_bullet_count = 1
var klaed_fighter_spread_angle = 15.0
