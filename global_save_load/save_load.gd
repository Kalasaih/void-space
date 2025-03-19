# Logic for save / load high score
extends Node

const savefile = "user://highscore.save"

var high_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_high_score()

# Function to save high score
func save_high_score():
	var file = FileAccess.open(savefile, FileAccess.WRITE_READ)
	file.store_32(high_score)

# Function to load high score	
func load_high_score():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if FileAccess.file_exists(savefile):
		high_score = file.get_32()
