extends Sprite

signal complete

var statusCode = ""

func init(inStatusCode):
	visible = false
	$Control/StatusText.visible = false
	$Control/StatusText.text = inStatusCode

func start():
	visible = true
	$Control/StatusText.visible = true
	emit_signal("complete")
	
func stop():
	init("")
