extends Sprite2D

class_name MinigameTimer

@export var duration: int = 5

@onready var progress_bar: TextureProgressBar = $tiempo
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.tint_progress = Color(0.0, 1.0, 0.0)
	progress_bar.max_value = duration
	timer.start(duration)
	timer.one_shot = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_bar.value = timer.time_left
	if progress_bar.value <= progress_bar.max_value * 0.66 and progress_bar.value > progress_bar.max_value * 0.33:
		progress_bar.tint_progress = Color(1.0, 1.0, 0.0)
	elif progress_bar.value <= progress_bar.max_value * 0.33:
		progress_bar.tint_progress = Color(1.0, 0.0, 0.0)


func reset():
	timer.start(duration)
	timer.paused = true


func unpause():
	timer.paused = false
