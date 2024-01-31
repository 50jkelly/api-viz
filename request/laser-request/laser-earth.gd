extends Sprite

signal complete

func start():
	var tween = create_tween()
	tween.connect("finished", self, "_on_tween_finished")
	tween.tween_property(self, "position", Vector2(300, 130), 1)
	
func stop():
	position.x = -380
	position.y = -340

func _on_tween_finished():
	emit_signal("complete")
