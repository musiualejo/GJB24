extends Node2D

@export var puntaje: int = 10

signal Puntaje(float)
signal FalloMinijuego()
signal FinMinijuego()

const NUMBER_OF_ITEMS := 4

var verbo := "corre y pilla el bus"
var chosen_frame = null
var zone_index = null
var zones_picked: Array[int] = []
@onready var zones: Array[Sprite2D] = [
	$personaje/torso,
	$personaje/piernas,
	$personaje/pies,
]
@onready var flecha: Sprite2D = $flecha
@onready var items: Array[Sprite2D] = [
	$armario/estante/item_left,
	$armario/estante/item_right,
	$armario/estante/item_up,
	$armario/estante/item_down,
]


# Called when the node enters the scene tree for the first time.
func _ready():
	main.verbo = verbo
	main.cargarMinijuego()
	randomize()
	pick_zone()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		pick_item(0)
	elif Input.is_action_just_pressed("ui_right"):
		pick_item(1)
	elif Input.is_action_just_pressed("ui_up"):
		pick_item(2)
	elif Input.is_action_just_pressed("ui_down"):
		pick_item(3)


func pick_item(item_index: int):
	if items[item_index].frame == zone_index:
		print("Success!")
		zones_picked.append(zone_index)
		pick_zone()
	else:
		print("Failed!")
		FalloMinijuego.emit()


func pick_zone():
	if len(zones_picked) == len(zones):
		FinMinijuego.emit()
		return
	zone_index = get_random_zone_index()
	while zone_index in zones_picked:
		zone_index = get_random_zone_index()
	var half_extent = zones[zone_index].get_rect().size.y / 2
	flecha.global_position = zones[zone_index].global_position + Vector2(0, half_extent) - Vector2(50, 0)
	items[0].frame = get_random_item_index(zone_index)
	items[1].frame = get_random_item_index(zone_index)
	items[2].frame = get_random_item_index(zone_index)
	items[3].frame = get_random_item_index(zone_index)
	var random_item_index = get_random_item_index(-1) # Will not exclude
	items[random_item_index].frame = zone_index


func get_random_item_index(index_to_exclude: int):
	var random_index = randi() % NUMBER_OF_ITEMS
	while random_index == index_to_exclude:
		random_index = randi() % NUMBER_OF_ITEMS
	return random_index


func get_random_zone_index():
	return randi() % len(zones)
