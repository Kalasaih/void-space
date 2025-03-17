extends ParallaxBackground

func _process(delta: float) -> void:
	scroll_offset.x -= 1200 * delta
