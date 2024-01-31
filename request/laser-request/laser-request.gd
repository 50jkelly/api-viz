extends Node2D

signal complete

var url = ""
	
func start(inUrl):
	url = inUrl
	$Station.start()
	
func stop():
	$Station.stop()
	$LaserLong.stop()
	$Explosion.stop()
	$ExplosionSound.stop()

func _on_Station_complete():
	$Station.visible = false
	$LaserLong.start(url)

func _on_LaserLong_complete():
	$LaserLong.visible = false
	$Earth.visible = true
	$LaserEarth.start()

func _on_LaserEarth_complete():
	$Explosion.start()
	$ExplosionSound.play()

func _on_Explosion_complete():
	emit_signal("complete")
