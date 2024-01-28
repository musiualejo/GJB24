extends Node2D

signal Puntaje(int)
signal FalloMinijuego()
signal Success()

var verbo := "dodge"

@export var items_to_spawn: Array[PackedScene]
@export var score_per_second := 10

@onready var player = $personaje
@onready var first_street_location = $fondo/first_street
@onready var second_street_location = $fondo/second_street
@onready var first_spawn_point = $spawn_positions/first_street
@onready var second_spawn_point = $spawn_positions/second_street
@onready var spawn_timer = $spawn_timer
@onready var score_timer = $score_timer
var movement_script = load("res://scripts/movement.gd")
var started := false

const NUMBER_OF_ITEMS := 4

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	player.global_position = first_street_location.global_position - Vector2(0, 64)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not started:
		return
	if Input.is_action_just_pressed("ui_up"):
		go_to_first_street()
	elif Input.is_action_just_pressed("ui_down"):
		go_to_second_street()


func go_to_first_street():
	player.global_position = first_street_location.global_position - Vector2(0, 64)


func go_to_second_street():
	player.global_position = second_street_location.global_position - Vector2(0, 64)


func _spawn_item():
	var random_item = items_to_spawn[randi() % NUMBER_OF_ITEMS].instantiate()
	var random_spawn_point = first_spawn_point if randi() % 2 == 0 else second_spawn_point
	random_item.set_script(movement_script)
	add_child(random_item)
	random_item.add_to_group("hazards")
	random_item.scale = Vector2(3, 3)
	random_item.global_position = random_spawn_point.global_position
	random_item.get_node("Area2D").connect("area_entered", _on_collision)


func _on_collision(area: Area2D):
	FalloMinijuego.emit()


func _on_spawn_timer_timeout():
	if not started:
		return
	_spawn_item()


func _on_score_timer_timeout():
	Puntaje.emit(score_per_second)


func start():
	started = true
	spawn_timer.start(0.5)
	spawn_timer.one_shot = false
	score_timer.start(1)
	score_timer.one_shot = false


func stop():
	started = false
