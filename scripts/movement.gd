extends Node2D

const SPEED := 800.0

var paused := false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= Vector2(1, 0) * delta * SPEED
