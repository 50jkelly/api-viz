extends Node2D

signal complete

func start(statusCode):
	$DialogBox.init()
	$Chalkboard.init(statusCode)
	$DialogBox.start()
	$TraitorMusic.play()
	
func stop():
	$Chalkboard.stop()
	
func _onChalkboardComplete():
	emit_signal("complete")

func _onDialogBoxComplete():
	$DialogBox.stop()
	$Chalkboard.start()
	$TraitorMusic.stop()
	$Gasp.play()
