extends Label

signal complete

func start(text):
	var lineDelay = 0.05
	
	self.text = text
	max_lines_visible = 0
	
	for n in get_line_count():
		max_lines_visible = n
		var timer = get_tree().create_timer(lineDelay)
		yield(timer, "timeout")
		
	emit_signal("complete")
