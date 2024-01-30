extends Node2D

signal success(statusCode, hasBody, body)
signal failure

func start(url):
	$StarsAndSines.play()
	
	$UFO.visible = true
	$ThumbsDown.visible = false
	$ThumbsUp.visible = false
	$Control/SuccessMessage.visible = false
	$Control/FailureMessage.visible = false
	
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed", self, "_onComplete")	
	
	var error = http.request(url)
	if (error != OK):
		_failure()
		


func stop():
	$StarsAndSines.stop()
	$BleepSuccess.stop()
	$BuzzerFailure.stop()
	
func _failure():
	emit_signal("failure")
	$UFO.visible = false
	$ThumbsUp.visible = false
	$Control/SuccessMessage.visible = false
	
	$BuzzerFailure.play()
	$ThumbsDown.scale *= 0.1
	$ThumbsDown.visible = true
	$Control/FailureMessage.visible = true
	
	var tween = create_tween()
	tween.tween_property($ThumbsDown, "scale", Vector2(0.4, 0.4), 1)
		
func _success(responseCode, hasBody, body):
	emit_signal("success", responseCode, hasBody, body)
	$UFO.visible = false
	$ThumbsDown.visible = false
	$Control/FailureMessage.visible = false
	
	$BleepSuccess.play()
	$ThumbsUp.scale *= 0.1
	$ThumbsUp.visible = true
	$Control/SuccessMessage.visible = true
	
	var tween = create_tween()
	tween.tween_property($ThumbsUp, "scale", Vector2(0.4, 0.4), 1)
	
func _onComplete(result, responseCode, _headers, body):
	if (result != 0):
		_failure()
		return
		
	if (body.empty()):
		_success(str(responseCode), false, "")
		return
	
	var pretty = ""
	var parseResult = JSON.parse(body.get_string_from_utf8())
		
	if (parseResult.error != OK):
		_failure()
		return
			
	pretty = JSON.print(parseResult.result, "  ")
	_success(str(responseCode), true, pretty)
