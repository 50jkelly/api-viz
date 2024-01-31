extends Sprite

signal complete

var time = 0
var flashTimes = []

func start():
	_flashStart()
	
func stop():
	visible = false
	flashTimes = []
	
func _process(delta):
	time += delta
	_flash()
	
func _appendFlash(offDuration, onDuration):
	var start = time
	
	if (flashTimes.size() > 0):
		start = flashTimes.back().end
		
	flashTimes.append({
		start = start + offDuration,
		end = start + offDuration + onDuration
	})

func _flashStart():
	_appendFlash(0, .05)
	_appendFlash(.05, .05)
	_appendFlash(.1, .05)
	_appendFlash(.05, .05)
	_appendFlash(.1, .05)
	_appendFlash(.05, .05)
	_appendFlash(.1, .05)
	_appendFlash(.15, .05)
	
func _flash():
	if (flashTimes.size() == 0):
		return
	
	for ft in flashTimes:
		if (time > ft.start):
			visible = true
		if (time > ft.end):
			visible = false
			
	if time > flashTimes.back().end:
		visible = true
		emit_signal("complete")
