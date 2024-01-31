extends Sprite

signal complete

var time = 0

func start():
	var tween = create_tween()
	tween.tween_property(self, "position:x", 500, 1)
	
func stop():
	position.x = -40
	position.y = 264
	
func _process(delta):
	time += delta
	_bob()
	
func _bob():
	var s = _sin()
	position.y += s
	
func _sin():
	var amplitude = 0.05
	var frequency = 2
	return sin(time * frequency) * amplitude
