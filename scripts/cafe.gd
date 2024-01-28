extends Node2D

var verbo := "keep them productive"
var started := false

var tempo = 1
var timer = 0

signal Puntaje(int)
signal FalloMinijuego()
signal Success()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer == 0):
		if Input.is_action_just_pressed("ui_down"):
			$personaje.frame = 1
			$"coworkers/1/stamina".value = 100
			timer = tempo
		if Input.is_action_just_pressed("ui_right"):
			$personaje.frame = 2
			$"coworkers/2/stamina".value = 100
			timer = tempo
		if Input.is_action_just_pressed("ui_left"):
			$personaje.frame = 3
			$"coworkers/3/stamina".value = 100
			timer = tempo
		if Input.is_action_just_pressed("ui_up"):
			$personaje.frame = 4
			$"coworkers/4/stamina".value = 100
			timer = tempo
	else:
		if (timer > delta):
			timer = timer - delta
		else:
			timer = 0

func start():
	started = true

func stop():
	started = false
