extends Sprite2D

signal FalloMinijuego()

var startingStamina = 100
var tiringRate = 10
var tempo = 0.8
var timer = tempo

# Called when the node enters the scene tree for the first time.
func _ready():
	$stamina.value = startingStamina


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer > delta):
		timer = timer - delta
	else:
		$stamina.value = $stamina.value - tiringRate
		timer = tempo
		if ($stamina.value >= 70):
			frame = 0
			$stamina.tint_progress = Color(0.29, 1.00, 0.11)
		elif ($stamina.value >= 50):
			frame = 1
			$stamina.tint_progress = Color(1.00, 0.95, 0.11)
		elif ($stamina.value >= 30):
			frame = 2
			$stamina.tint_progress = Color(1.00, 0.62, 0.11)
		elif($stamina.value > 0):
			frame = 3
			$stamina.tint_progress = Color(1.00, 0.22, 0.11)
	
	#if ($stamina.value <= 0):
	#	main._failed_minigame()
	
