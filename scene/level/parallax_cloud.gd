extends ParallaxBackground

func _process(delta: float) -> void:
	scroll_offset.x -= 100 * delta
