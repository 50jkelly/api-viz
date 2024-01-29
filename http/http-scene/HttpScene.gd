extends Node2D

signal success(statusCode, hasBody, body)
signal failure

func start(url):
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed", self, "_onComplete")	
	
	var error = http.request(url)
	if (error != OK):
		emit_signal("failure")
	
func stop():
	pass
	
func _onComplete(result, responseCode, _headers, body):
	if (result != 0):
		emit_signal("failure")
		return
		
	if (body.empty()):
		emit_signal("success", str(responseCode), false, "")
		return
	
	var pretty = ""
	var parseResult = JSON.parse(body.get_string_from_utf8())
		
	if (parseResult.error != OK):
		emit_signal("failure")
		return
			
	pretty = JSON.print(parseResult.result, "  ")
	emit_signal("success", str(responseCode), true, pretty)
