extends Node2D

signal complete

var textStartDelay = 0.4
var responseText = ""

func start(inResponseText):
	self.responseText = inResponseText
	
	# Connect all of our individual animation scenes' "complete" signal
	# to corresponding handlers.
	$MatrixMan.connect("complete", self, "_onMatrixManComplete")
	$RedPill.connect("complete", self, "_onRedPillComplete")
	$Flash.connect("complete", self, "_onFlashComplete")
	$Wipe.connect("complete", self, "_onWipeComplete")
	
	# Start playing sounds and music
	$City.play()
	$Crowd.play()
	
	# Kick off the first animation in this scene.
	$MatrixMan.start()
	
func stop():
	$City.stop()
	$Crowd.stop()
	
func _onMatrixManComplete():
	$RedPill.start()
	
func _onRedPillComplete():
	$Flash.start()
	
func _onFlashComplete():
	$Wipe.start()
	var timer = get_tree().create_timer(textStartDelay)
	yield(timer, "timeout")
	$Control/CodeText.start(responseText);	
	
func _onWipeComplete():
	emit_signal("complete")
