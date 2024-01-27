extends Sprite2D

@export var duration: int = 5

@onready var progress_bar: TextureProgressBar = $tiempo
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start(duration)
	timer.one_shot = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_bar.value = timer.time_left
