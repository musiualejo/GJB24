extends Node2D

@export var items_to_spawn: Array[PackedScene]

@onready var player = $personaje
@onready var first_street_location = $fondo/first_street
@onready var second_street_location = $fondo/second_street
@onready var first_spawn_point = $spawn_positions/first_street
@onready var second_spawn_point = $spawn_positions/second_street
@onready var spawn_timer = $spawn_timer
var movement_script = load("res://scripts/movement.gd")

const NUMBER_OF_ITEMS := 4

signal Puntaje(int)
signal FalloMinijuego()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_timer.start(0.5)
	spawn_timer.one_shot = false
	player.global_position = first_street_location.global_position - Vector2(0, 64)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
	random_item.scale = Vector2(3, 3)
	random_item.global_position = random_spawn_point.global_position
	print(random_item.get_node("Area2D"))
	random_item.get_node("Area2D").connect("area_entered", _on_collision)


func _on_collision(area: Area2D):
	FalloMinijuego.emit()


func _on_spawn_timer_timeout():
	_spawn_item()
