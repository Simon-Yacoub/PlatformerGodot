extends CharacterBody2D

var SPEED = 30
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var count = 0
var patrol = 250
var notDead = true


func _ready():
	get_node("AnimatedSprite2D").play("flying")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Gravity for eagle
	velocity.y = 0
	count += 1
	if count > patrol:
		velocity.x = SPEED
		get_node("AnimatedSprite2D").flip_h = true
		if count > patrol * 2:
			count = 0
	else:
		velocity.x = SPEED * -1	
		get_node("AnimatedSprite2D").flip_h = false
	if notDead:
		move_and_slide()


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.PlayerHp -= 1
		Utils.saveGame()		
		death()
		
func death():	
	notDead = false
	$CollisionShape2D.queue_free() 
	$PlayerCollision.queue_free() 
	get_node("AnimatedSprite2D").play("death")	
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
