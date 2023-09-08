extends Camera2D

var shakeBaseAmount := 1.0
var shakeDampening := 0.075

var shakeAmount := 0.0

func _process(delta):
	if shakeAmount > 0:
		offset.x = rand_range(-shakeAmount, shakeBaseAmount)*shakeAmount
		offset.y = rand_range(-shakeAmount, shakeBaseAmount)*shakeAmount
		shakeAmount = lerp (shakeAmount,0.0,shakeDampening)
	else:
		offset = Vector2.ZERO

func shake(magnitude: float):
	shakeAmount+=magnitude
