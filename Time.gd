extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Game.TimeElapsed += delta
	text = Game._format_seconds(Game.TimeElapsed, true)
