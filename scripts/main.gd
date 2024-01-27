extends Node2D

#VARIABLES

var score := 0
var vidas := 3

var ritmo := 1
var verbo := "espera"

var current_minigame_index := 0
@export var minigames: Array[PackedScene] = []

# NODOS

@onready var lives_bar: TextureProgressBar = $ui/vidas
@onready var nMinijuego: Vestirse = $minijuego
@onready var nVerbo = $ui/verbo

# SEÑALES


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	OS.set_low_processor_usage_mode ( true )
	if nMinijuego:
		nMinijuego.FalloMinijuego.connect(_failed_minigame)


func _failed_minigame():
	lives_bar.value += lives_bar.step
	if lives_bar.value == lives_bar.max_value:
		get_tree().paused = true
	_next_minigame()


func _next_minigame():
	nMinijuego.queue_free()
	var new_minigame_index = (current_minigame_index + 1) % len(minigames)
	var next_minigame = minigames[new_minigame_index]
	var instance = next_minigame.instantiate()
	instance.FalloMinijuego.connect(_failed_minigame)
	add_child(instance)
	move_child(instance, 0)
	nMinijuego = instance


func cargarMinijuego():
	if nMinijuego:
		nVerbo.actualizaVerbo()


func _on_timer_timeout():
	_next_minigame()
