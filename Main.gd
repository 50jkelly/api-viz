extends Node2D


const START = "START"
const HTTP_COMPLETE = "HTTP_COMPLETE"
const REQUEST_STARTED = "REQUEST_STARTED"
const REQUEST_COMPLETE = "REQUEST_COMPLETE"
const STATUS_STARTED = "STATUS_STARTED"
const STATUS_COMPLETE = "STATUS_COMPLETE"
const RESPONSE_STARTED = "RESPONSE_STARTED"
const RESPONSE_COMPLETE = "RESPONSE_COMPLETE"
const COMPLETE = "COMPLETE"

# PLACE REQUEST ANIMATIONS HERE
onready var requestAnimations = [
	$TestRequest,
	$TestRequest,
]

# PLACE STATUS ANIMATIONS HERE
onready var statusAnimations = [
	$TestStatus,
	$TestStatus,
]

# PLACE RESPONSE ANIMATIONS HERE
onready var responseAnimations = [
	$MatrixResponse,
	$MatrixResponse,
]

# PLACE HTTP REQUEST DETAILS HERE
var requestUrls = [
	"http://localhost:3000",
	"http://localhost:3000/oops"
]

var state

var requestIndex = 0
var statusIndex = 0
var responseIndex = 0
var requestUrlIndex = 0

var httpResponse

# Prepare the visualisations by:
# - Hiding all animations
# - Connecting all animations' "complete" signal to the appropriate handler.
func _ready():
	_newState(START)
	
	for a in requestAnimations:
		a.visible = false
		a.connect("complete", self, "_onRequestComplete")
		
	for a in statusAnimations:
		a.visible = false
		a.connect("complete", self, "_onStatusComplete")
		
	for a in responseAnimations:
		a.visible = false
		a.connect("complete", self, "_onResponseComplete")

# Handle the program's state transitions by moving the state on every time
# the spacebar key is pressed.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if (state == START):
			_makeHttpRequest(requestUrls[requestUrlIndex])
			
		elif (state == HTTP_COMPLETE):
			_newState(REQUEST_STARTED)
			requestAnimations[requestIndex].visible = true
			requestAnimations[requestIndex].start(requestUrls[requestUrlIndex])
			
		elif (state == REQUEST_COMPLETE):
			if (httpResponse["statusCode"] == "0"):
				_newState(RESPONSE_COMPLETE)
			else:
				_newState(STATUS_STARTED)
				requestAnimations[requestIndex].visible = false
				requestAnimations[requestIndex].stop()
			
				statusAnimations[statusIndex].visible = true
				statusAnimations[statusIndex].start(httpResponse["statusCode"])
			
		elif (state == STATUS_COMPLETE):
			if (httpResponse["body"].length() == 0):
				_newState(RESPONSE_COMPLETE)
			else:
				_newState(RESPONSE_STARTED)
				statusAnimations[statusIndex].visible = false
				statusAnimations[statusIndex].stop()
				
				responseAnimations[responseIndex].visible = true
				responseAnimations[responseIndex].start(httpResponse["body"])
			
		elif (state == RESPONSE_COMPLETE):
			responseAnimations[responseIndex].visible = false
			responseAnimations[responseIndex].stop()
			
			if (requestUrlIndex == requestUrls.size() - 1):
				_quit()
			else:
				requestUrlIndex += 1
				requestIndex += 1
				statusIndex += 1
				responseIndex += 1
				_newState(START)

# Handlers for the animations' "complete" signals
func _onRequestComplete():
	_newState(REQUEST_COMPLETE)
	
func _onStatusComplete():
	_newState(STATUS_COMPLETE)
	
func _onResponseComplete():
	_newState(RESPONSE_COMPLETE)

# Make a HTTP request
func _makeHttpRequest(url):
	var http = HTTPRequest.new()
	add_child(http)
	http.connect("request_completed", self, "_onHttpComplete")	
	
	var error = http.request(url)
	if (error != OK):
		_quit() # TODO: Show an error scene

# Handle HTTP response
func _onHttpComplete(result, responseCode, _headers, body):
	if (result != 0):
		httpResponse = {
			"statusCode": "0",
			"body": "",
		}
		_newState(HTTP_COMPLETE)
	elif (body.empty()):
		httpResponse = {
			"statusCode": str(responseCode),
			"body": "",
		}
		_newState(HTTP_COMPLETE)		
	else:
		var pretty = ""
		var parseResult = JSON.parse(body.get_string_from_utf8())
		
		if (parseResult.error == OK):
			pretty = JSON.print(parseResult.result, "  ")
			
		httpResponse = {
			"statusCode": str(responseCode),
			"body": pretty
		}
		_newState(HTTP_COMPLETE)
		
# Transition state
func _newState(newState):
	state = newState
	$Control/State.text = newState
	
# Quit the application
func _quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	
