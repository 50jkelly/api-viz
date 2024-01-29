extends Node2D

signal complete

func start(statusCode):
	$Control/Label.text = statusCode
	emit_signal("complete")
	
func stop():
	pass
