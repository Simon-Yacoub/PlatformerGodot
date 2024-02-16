extends Area2D

var speed = 450

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta):
	if true:
		position += transform.x * speed * delta
	else:
		position += -1 * transform.x * speed * delta

func _on_body_entered(body):
	if body.name == "TileMap":
		queue_free()
	if body.name.substr(0, 4) == "Frog":
		body.death()
		queue_free()
	if body.name.substr(0, 5) == "Eagle":
		body.death() 
		queue_free()
	if body.name.substr(0, 6) == "Possum":
		body.death() 
		queue_free()
