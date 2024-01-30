extends Sprite

signal complete

var percentIncrement = 0.0

func init():
	visible = false
	$Control/DialogText.percent_visible = 0
	percentIncrement = 1.0 / $Control/DialogText.text.length()

func start():
	visible = true
	$CharacterTimer.start()
	
func stop():
	init()
	$CharacterTimer.stop()

func _onCharacterTimeout():
	$Control/DialogText.percent_visible += percentIncrement
	if ($Control/DialogText.percent_visible >= 1.0):
		$CharacterTimer.stop()
		$CompleteTimer.start()
		
	else:
		$CharacterTimer.start()

func _onCompleteTimeout():
	$CompleteTimer.stop()
	emit_signal("complete")
