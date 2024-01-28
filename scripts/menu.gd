extends Control


@onready var start_day_screen: Control = preload("res://scenes/start_day_screen.tscn").instantiate()
@onready var button: Button = $Label/Button
@onready var button_background: ColorRect = $Label/Button/ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	button.pressed.connect(_go_to_main)
	button.mouse_entered.connect(_start_hover)
	button.mouse_exited.connect(_stop_hover)
	button_background.color = Color(0.0, 0.0, 0.0)


func _go_to_main():
	get_tree().root.add_child(start_day_screen)
	queue_free()


func _start_hover():
	button_background.color = Color(0.3, 0.3, 0.3)


func _stop_hover():
	button_background.color = Color(0.0, 0.0, 0.0)


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		_go_to_main()
