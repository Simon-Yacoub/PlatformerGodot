extends Area2D

var speed = 350

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta):
	if true:
		position += transform.x * speed * delta
	else:
		position += -1 * transform.x * speed * delta

func _on_body_entered(body):
	var name = body.name.substr(0, 4)
	if name == "Frog":
		body.death()
		queue_free()
	
