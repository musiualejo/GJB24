extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const SPEED := 800.0

var paused := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.x >= -128):
		position -= Vector2(1, 0) * delta * SPEED
	else:
		position.x += 1408
