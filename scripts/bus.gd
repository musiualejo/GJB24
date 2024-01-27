extends Node2D

@export var score_to_award := 100

signal Puntaje(float)
signal FalloMinijuego()
signal FinMinijuego()

var verbo := "corre y pilla el bus"

var lastKey = 0
var growthRate = 0.08
var reached := false

# Called when the node enters the scene tree for the first time.
func _ready():
	main.verbo = verbo
	main.cargarMinijuego()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left") and (lastKey != 1):
		lastKey = 1
		$personaje.flip_h = !$personaje.flip_h
		$llegada.scale = Vector2($llegada.scale.x+growthRate,$llegada.scale.y+growthRate)
	elif Input.is_action_just_pressed("ui_right") and (lastKey != 2):
		$personaje.flip_h = !$personaje.flip_h
		lastKey = 2
		$llegada.scale = Vector2($llegada.scale.x+growthRate,$llegada.scale.y+growthRate)
	if $llegada.scale >= Vector2(3, 3) and not reached:
		Puntaje.emit(score_to_award)
		reached = true
