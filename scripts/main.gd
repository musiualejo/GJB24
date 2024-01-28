extends Node2D

#VARIABLES

var score := 0
var vidas := 3

var ritmo := 1

var current_minigame_index := 0
var current_day := 1
var minigames: Array[PackedScene] = [
	load("res://scenes/minijuegos/vestirse.tscn"),
	load("res://scenes/minijuegos/bus.tscn"),
	load("res://scenes/minijuegos/carriles.tscn"),
	load("res://scenes/minijuegos/cafe.tscn"),
]
var start_day_scene = preload("res://scenes/start_day_screen.tscn").instantiate()

# NODOS

@onready var lives_bar: TextureProgressBar = $ui/vidas
@onready var nMinijuego = $minijuego
@onready var nVerbo = $ui/verbo
@onready var nScore: Label = $ui/score
@onready var nTimer: MinigameTimer = $ui/cronometro/reloj
@onready var minigame_pre_timer = $ui/minigame_pre_screen
@onready var success_message = $ui/success_message
@onready var failure_message = $ui/failure_message
@onready var start_day_screen = $ui/start_day_screen


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	OS.set_low_processor_usage_mode ( true )
	if nMinijuego:
		_setup_minigame()
		nScore.text = "%04d" % Globals.score
		lives_bar.value = Globals.errors


func _increase_score(amount: int):
	Globals.score += amount
	nScore.text = "%04d" % Globals.score


func _failed_minigame():
	failure_message.show()
	nTimer.shorten()
	nMinijuego.stop()
	var hazards = get_tree().get_nodes_in_group("hazards")
	# Needed so you can't keep losing more lives
	for hazard in hazards:
		hazard.get_node("Area2D").queue_free()
	Globals.errors += 1
	lives_bar.value = Globals.errors
	if lives_bar.value == lives_bar.max_value:
		$ui/failure_message.hide()
		$ui/gameover.show()
		get_tree().paused = true # Game over


func _next_minigame():
	if nMinijuego:
		nMinijuego.queue_free()
	current_minigame_index = (current_minigame_index + 1) % len(minigames)
	if current_minigame_index == 0: # We've looped
		Globals.current_day += 1
		Globals.timer_action -= 1
		Globals.timer_survive += 1
		get_tree().root.add_child(start_day_scene)
		queue_free()
		return
	var next_minigame = minigames[current_minigame_index]
	var instance = next_minigame.instantiate()
	nMinijuego = instance
	_setup_minigame() # Uses `nMinijuego`
	add_child(nMinijuego)
	move_child(nMinijuego, 0)
	minigame_pre_timer.start()


func _setup_minigame():
	nMinijuego.FalloMinijuego.connect(_failed_minigame)
	nMinijuego.Puntaje.connect(_increase_score)
	nMinijuego.Success.connect(_show_success_message)
	var ui_node = get_tree().get_nodes_in_group("ui")[0]
	nVerbo = ui_node.get_node("verbo")
	nVerbo.actualizaVerbo(nMinijuego.verbo)
	success_message = ui_node.get_node("success_message")
	success_message.hide()
	failure_message = ui_node.get_node("failure_message")
	failure_message.hide()
	nTimer = ui_node.get_node("cronometro/reloj")
	var timer_duration
	if nMinijuego.is_survival:
		timer_duration = Globals.timer_survive
	else:
		timer_duration = Globals.timer_action
	nTimer.reset(timer_duration)


func _on_timer_timeout():
	_next_minigame()


func _start_minigame():
	nTimer.unpause()
	minigame_pre_timer.stop()
	for child in get_children():
		print(child)
	nMinijuego.start()


func _on_pre_minigame_timer_timeout():
	_start_minigame()


func _show_success_message():
	success_message.show()
	nTimer.shorten()
