extends Sprite

signal complete

func start():
	var wipeDuration = 2
	
	var timer = get_tree().create_timer(wipeDuration)
	timer.connect("timeout", self, "_onComplete")
	
	var wipeTween = create_tween()
	wipeTween.tween_property(self, "position:y", 600, wipeDuration)
	
func _onComplete():
	emit_signal("complete")
