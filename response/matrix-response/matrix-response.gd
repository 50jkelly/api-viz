extends Node2D

signal complete

# API response text
var responseText = """{
  "users": [
	{
	  "id": 1,
	  "name": "John Doe",
	  "email": "johndoe@example.com",
	  "roles": ["user", "admin"],
	  "isActive": true
	},
	{
	  "id": 2,
	  "name": "Jane Smith",
	  "email": "janesmith@example.com",
	  "roles": ["user"],
	  "isActive": false
	},
	{
	  "id": 3,
	  "name": "Emily Johnson",
	  "email": "emilyjohnson@example.com",
	  "roles": ["user", "editor"],
	  "isActive": true
	}
  ]
}"""

var textStartDelay = 0.4

func start():
	# Connect all of our individual animation scenes' "complete" signal
	# to corresponding handlers.
	$MatrixMan.connect("complete", self, "_onMatrixManComplete")
	$RedPill.connect("complete", self, "_onRedPillComplete")
	$Flash.connect("complete", self, "_onFlashComplete")
	$Wipe.connect("complete", self, "_onWipeComplete")
	
	# Start playing sounds and music
	$City.play()
	$Crowd.play()
	
	# Kick off the first animation in this scene.
	$MatrixMan.start()
	
func _onMatrixManComplete():
	$RedPill.start()
	
func _onRedPillComplete():
	$Flash.start()
	
func _onFlashComplete():
	$Wipe.start()
	var timer = get_tree().create_timer(textStartDelay)
	yield(timer, "timeout")
	$Control/CodeText.start(responseText);	
	
func _onWipeComplete():
	emit_signal("complete")
