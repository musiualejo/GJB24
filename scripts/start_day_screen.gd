extends Control


@onready var main_screen: Node2D = preload("res://scenes/main.tscn").instantiate()
@onready var screens: Array[TextureRect] = [
	$day_counter,
]

@onready var timer_to_advance: Timer = $timer_to_advance
@onready var day_counter_label: RichTextLabel = $day_counter/label

var current_screen_index := 0


func _ready():
	"""Called from main to start the cutscene"""
	
	day_counter_label.text = "[center][font_size=120][color=black]Day %d[/color][/font_size][/center]" % Globals.current_day
	timer_to_advance.start(2)
	timer_to_advance.one_shot = false
	screens[current_screen_index].show()


func _on_timer_to_advance_timeout():
	_go_to_next_screen()


func _go_to_next_screen():
	screens[current_screen_index].hide()
	current_screen_index += 1
	print(current_screen_index)
	print(len(screens))
	if current_screen_index < len(screens):
		screens[current_screen_index].show()
	else:
		get_tree().root.add_child(main_screen)
		queue_free()
