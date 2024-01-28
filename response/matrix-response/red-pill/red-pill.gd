extends Sprite

signal complete

func start():
	var redPillDuration = 1.5
	var redPillPauseDuration = 0.8
	var redPillEndPosition = Vector2(position.x, position.y - 300)
	var redPillEndScale = scale * 2
	
	var timer = get_tree().create_timer(redPillDuration + redPillPauseDuration)
	timer.connect("timeout", self, "_onComplete")
		
	var redPillTween = create_tween()
	redPillTween.tween_property(self, "position", redPillEndPosition, redPillDuration)
	redPillTween.parallel().tween_property(self, "scale", redPillEndScale, redPillDuration)
	yield(timer, "timeout")	 # Wait until the timer emits the "timeout" signal

func _onComplete():
	emit_signal("complete")
