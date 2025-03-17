extends Node

const savefile = "user://highscore.save"

var high_score = 0

func _ready():
	load_high_score()

func save_high_score():
	var file = FileAccess.open(savefile, FileAccess.WRITE_READ)
	file.store_32(high_score)
	
func load_high_score():
	var file = FileAccess.open(savefile, FileAccess.READ)
	if FileAccess.file_exists(savefile):
		high_score = file.get_32()
