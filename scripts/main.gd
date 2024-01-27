extends Node2D

#VARIABLES

var ritmo = 1
var verbo = "ESPERA"

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
	if (nMinijuego):
		print(str(verbo))
		nVerbo.actualizaVerbo()
