extends Sprite

signal complete

func start(inUrl):
	$Control/Url.text = inUrl
	var tween = create_tween()
	tween.tween_property(self, "position:x", 550, 2.5)
	tween.connect("finished", self, "_on_tween_finished")
	
func stop():
	position.x = -550
	
func _on_tween_finished():
	var timer = get_tree().create_timer(2)
	timer.connect("timeout", self, "_on_timer_timeout")

func _on_timer_timeout():
	emit_signal("complete")
