extends Node2D

#VARIABLES

var score = 0
var vidas = 3

var ritmo = 1
var verbo := "espera"

# NODOS

var nMinijuego
var nVerbo

# SEÑALES


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_low_processor_usage_mode ( true )
	nMinijuego = $minijuego
	nVerbo = $ui/verbo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cargarMinijuego():
	if nMinijuego:
		nVerbo.actualizaVerbo()
