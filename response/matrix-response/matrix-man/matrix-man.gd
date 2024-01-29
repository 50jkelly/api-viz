extends Sprite

# We will use this signal to indicate when the animation is complete.
signal complete

# Used to control the length of the animation and audio playback
var walkDuration = 1.5

func start():
	# Here we define a timer set to the animation's duration. When the timer
	# emits it's "timeout" signal, we call the "_onComplete" function in this
	# script.
	var timer = get_tree().create_timer(walkDuration)
	timer.connect("timeout", self, "_onComplete")
	
	# Start the playback of the footsteps audio stream.
	$Footsteps.play()
	
	# We define the end states of our walk animation. In this case, we want to change:
	# 1. The position of the sprite.
	# 2. The scale of the sprite.
	var walkEndPosition = Vector2(position.x, position.y + 50)
	var walkEndScale = scale * 1.5
	
	# We create a tween to smoothly animate between the sprite's current state,
	# and the desired end states we described above.
	# We set the tween to run in parallel so that both properties are animated
	# at the same time. If we didn't set this, the position would be fully
	# animated, and then the scale would be fully animated.
	var walkTween = create_tween().set_parallel(true)
	walkTween.tween_property(self, "position", walkEndPosition, walkDuration)
	walkTween.tween_property(self, "scale", walkEndScale, walkDuration)

# This function runs when the timer defined in `start` emits the "timeout"
# signal.
func _onComplete():
	# Stop playback of the footsteps audio
	$Footsteps.stop()
	
	# Emit the "complete" signal, so other scenes can respond to this animation
	# being completed.
	emit_signal("complete")
