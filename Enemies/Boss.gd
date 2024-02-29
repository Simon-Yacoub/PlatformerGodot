extends Node2D

var health = 3
var attacking = false
var attackCoolDown = 0
var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !dead:
		attackCoolDown += 1
		if attacking:
			var anim = get_node("AnimatedSprite2D")
			anim.play("attack")
			await anim.animation_finished
			var p = preload("res://fly.tscn").instantiate()
			p.position = Vector2(p.position.x - 20, p.position.y + 30)
			owner.add_child(p)
			attackCoolDown = 0


func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.PlayerHp -= 5
		Utils.saveGame()
		
func damage():
	health -= 1
	if health <= 0:
		dead = true
		death() 		


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		attacking = true


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		attacking = false
		get_node("AnimatedSprite2D").play("idle")
		
func death():	
	$CollisionShape2D.queue_free() 
	$PlayerCollision.queue_free() 
	get_node("AnimatedSprite2D").play("death")	
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
