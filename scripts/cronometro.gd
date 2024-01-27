extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): 
	print(str(delta))
	if (value>0):
		value=value-delta*100
	elif(value<=delta*100):
		value=100
