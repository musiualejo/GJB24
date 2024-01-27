extends Node2D

signal FalloMinijuego()
signal FinMinijuego()


var verbo := "corre y pilla el bus"


# Called when the node enters the scene tree for the first time.
func _ready():
	main.verbo = verbo
	main.cargarMinijuego()




