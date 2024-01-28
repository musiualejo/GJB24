extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	actualizaVerbo("espera")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func actualizaVerbo(verbo: String):
	text = "[shake rate=30.0 level=15 connected=1][center]" + verbo.to_upper() + " ![/center][/shake]"
