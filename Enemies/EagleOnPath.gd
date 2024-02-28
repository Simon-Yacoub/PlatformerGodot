extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("flying")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.PlayerHp -= 1
		Utils.saveGame()		
		death()

func death():	
	$CollisionShape2D.queue_free() 
	$PlayerCollision.queue_free() 
	get_node("AnimatedSprite2D").play("death")	
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
