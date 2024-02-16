extends CharacterBody2D

var SPEED = 75
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Walk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_node("AnimatedSprite2D").animation != "Death":
		velocity.y += gravity * delta
		velocity.x = direction * SPEED
		move_and_slide()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.PlayerHp -= 1
		Utils.saveGame()		
		death()

func death():
	$CollisionShape2D.queue_free() 
	$PlayerCollision.queue_free() 
	get_node("AnimatedSprite2D").play("Death")	
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()


func _on_tile_map_collision_body_entered(body):
	if body.name != "Player" :
		direction *= -1
		get_node("AnimatedSprite2D").flip_h = (direction > 0)
		
