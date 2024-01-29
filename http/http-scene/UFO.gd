extends Sprite

var time = 0

func _process(delta):
	time += delta
	position.y += _sin()
	
func _sin():
	var amplitude = .5
	var frequency = 2
	return sin(time * frequency) * amplitude
