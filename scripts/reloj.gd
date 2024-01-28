extends Sprite2D

class_name MinigameTimer

const SHORT_TIME := 2

@export var duration: int = 5

@onready var progress_bar: TextureProgressBar = $tiempo
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	progress_bar.max_value = duration
	timer.one_shot = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_bar.value = timer.time_left
	if progress_bar.value <= progress_bar.max_value * 0.66 and progress_bar.value > progress_bar.max_value * 0.33:
		progress_bar.tint_progress = Color(1.0, 1.0, 0.0)
	elif progress_bar.value <= progress_bar.max_value * 0.33:
		progress_bar.tint_progress = Color(1.0, 0.0, 0.0)


func reset():
	progress_bar.tint_progress = Color(0.0, 1.0, 0.0)
	timer.start(duration)
	timer.paused = true


func unpause():
	timer.paused = false


func shorten():
	var short_duration
	if timer.time_left < SHORT_TIME:
		short_duration = timer.time_left
	else:
		short_duration = SHORT_TIME
	timer.start(short_duration)
