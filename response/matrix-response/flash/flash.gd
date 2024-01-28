extends Sprite

signal complete

func start():
	var flashStartDuration = 0.1
	var flashEndDuration = 0.5
	
	var timer = get_tree().create_timer(flashStartDuration + flashEndDuration)
	timer.connect("timeout", self, "_onComplete")
	
	$FlashSound.play()
			
	var flashStartTween = create_tween()
	flashStartTween.tween_property(self, "modulate:a", 1, flashStartDuration)
	flashStartTween.tween_property(self, "modulate:a", 0, flashEndDuration)
	
func _onComplete():
	emit_signal("complete")
