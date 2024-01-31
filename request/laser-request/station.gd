extends Node2D

signal complete

var chargeSoundDuration = 3.5

func start():
	var timer = get_tree().create_timer(chargeSoundDuration)
	timer.connect("timeout", self, "_startStationLaser")
	$StationSprite.start()
	$Laser.play()
	
func stop():
	$StationSprite.stop()
	$Laser.stop()
	
func _startStationLaser():
	$StationLaser.start()

func _on_Laser_finished():
	emit_signal("complete")
