extends Sprite

signal complete

func start():
	visible = true
	
	var tween = create_tween()
	tween.connect("finished", self, "_on_tween_finished")
	tween.tween_property(self, "scale", Vector2(1, 1), 0.5)
	
func stop():
	visible = false
	position.x = 770
	position.y = 440
	scale.x = 0.1
	scale.y = 0.1
	
func _on_tween_finished():
	emit_signal("complete")
