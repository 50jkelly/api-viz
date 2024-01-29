extends Node2D

signal complete

func start(requestUrl):
	$Control/Label.text = requestUrl
	emit_signal("complete")

func stop():
	pass
