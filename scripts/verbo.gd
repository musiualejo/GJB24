extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	actualizaVerbo()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func actualizaVerbo():
	text = "[shake rate=30.0 level=15 connected=1][center]¡ " + main.verbo + " ![/center][/shake]"
