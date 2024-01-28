extends Node2D

var sceneStarted = false

func _ready():
	$MatrixResponse.visible = false

func _process(_delta):
	# Wait for ui_accept action (bound to spacebar) before starting
	if Input.is_action_pressed("ui_accept"):
		if (!sceneStarted):
			$MatrixResponse.visible = true
			$MatrixResponse.start()
			sceneStarted = true
	
