extends Node2D

#VARIABLES

var score := 0
var vidas := 3

var ritmo := 1

var current_minigame_index := 0
@export var minigames: Array[PackedScene] = []

# NODOS

@onready var lives_bar: TextureProgressBar = $ui/vidas
@onready var nMinijuego = $minijuego
@onready var nVerbo = $ui/verbo
@onready var nScore: Label = $ui/score
@onready var nTimer: MinigameTimer = $ui/cronometro/reloj
@onready var minigame_pre_timer = $ui/minigame_pre_screen
@onready var success_message = $ui/success_message
@onready var failure_message = $ui/failure_message


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	OS.set_low_processor_usage_mode ( true )
	if nMinijuego:
		nMinijuego.FalloMinijuego.connect(_failed_minigame)
		nMinijuego.Puntaje.connect(_increase_score)
		nMinijuego.Success.connect(_show_success_message)
		nVerbo.actualizaVerbo(nMinijuego.verbo)
		success_message.hide()
		failure_message.hide()
		nTimer.reset()


func _increase_score(amount: int):
	score += amount
	nScore.text = "%04d" % score


func _failed_minigame():
	failure_message.show()
	nTimer.shorten()
	nMinijuego.stop()
	var hazards = get_tree().get_nodes_in_group("hazards")
	for hazard in hazards:
		hazard.get_node("Area2D").queue_free()
	lives_bar.value += lives_bar.step
	if lives_bar.value == lives_bar.max_value:
		get_tree().paused = true # Game over


func _next_minigame():
	if nMinijuego:
		nMinijuego.queue_free()
	current_minigame_index = (current_minigame_index + 1) % len(minigames)
	var next_minigame = minigames[current_minigame_index]
	var instance = next_minigame.instantiate()
	success_message.hide()
	failure_message.hide()
	instance.FalloMinijuego.connect(_failed_minigame)
	instance.Puntaje.connect(_increase_score)
	instance.Success.connect(_show_success_message)
	add_child(instance)
	move_child(instance, 0)
	nMinijuego = instance
	nTimer.reset()
	minigame_pre_timer.start()
	nVerbo.actualizaVerbo(nMinijuego.verbo)


func _on_timer_timeout():
	_next_minigame()


func _start_minigame():
	nTimer.unpause()
	minigame_pre_timer.stop()
	nMinijuego.start()


func _on_pre_minigame_timer_timeout():
	_start_minigame()


func _show_success_message():
	success_message.show()
	nTimer.shorten()
