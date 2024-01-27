extends Node2D

@export var score_to_award := 100

signal Puntaje(float)
signal FalloMinijuego()
signal FinMinijuego()
signal Success()

var verbo := "corre y pilla el bus"

var lastKey = 0
var growthRate = 0.08
var reached := false
var started := false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started or reached:
		return
	if Input.is_action_just_pressed("ui_left") and (lastKey != 1):
		lastKey = 1
		$personaje.flip_h = !$personaje.flip_h
		$llegada.scale = Vector2($llegada.scale.x+growthRate,$llegada.scale.y+growthRate)
	elif Input.is_action_just_pressed("ui_right") and (lastKey != 2):
		$personaje.flip_h = !$personaje.flip_h
		lastKey = 2
		$llegada.scale = Vector2($llegada.scale.x+growthRate,$llegada.scale.y+growthRate)
	if $llegada.scale >= Vector2(3, 3) and not reached:
		Success.emit()
		Puntaje.emit(score_to_award)
		reached = true


func start():
	started = true
