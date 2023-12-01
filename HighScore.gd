extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var highscore = Utils.getHighScore()
	if highscore:
		text = "HighScore: " +  "%02d:%02d" % [fmod(highscore, 60), fmod(highscore, 1) * 100]
