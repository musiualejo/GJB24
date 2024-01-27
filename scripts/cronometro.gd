extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta): 
	if (value>0):
		value=value-main.ritmo
	elif(value<=main.ritmo):
		value=max_value
