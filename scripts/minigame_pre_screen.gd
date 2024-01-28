extends Control


@onready var timer_label: RichTextLabel = $timer_label
@onready var timer: Timer = $timer


# Called when the node enters the scene tree for the first time.
func _ready():
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inner_text = "%.f" % timer.time_left
	if timer.time_left < 1:
		inner_text = "Go!"
	timer_label.text = "[shake rate=30.0 level=15 connected=1][center][font_size=160]%s[/font_size][/center][/shake]" % inner_text


func start():
	timer.start(3)
	timer.one_shot = true
	visible = true


func stop():
	visible = false
