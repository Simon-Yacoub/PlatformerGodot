extends Area2D

var speed = 450

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= transform.x * speed * delta

func _on_body_entered(body):
	if body.name == "TileMap":
		queue_free()
	if body.name.substr(0, 4) == "Play":
		queue_free()
		Game.PlayerHp -= 1
		Utils.saveGame()
