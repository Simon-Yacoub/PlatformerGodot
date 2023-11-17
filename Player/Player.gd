extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const LOWER_LIMIT = 700
@onready var anim = get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")
			
	if Game.PlayerHp <= 0 || position.y > LOWER_LIMIT:
		playerDeath()
	else: 
		move_and_slide()
	
	
func playerDeath():	
	anim.play("Death")
	velocity.y = JUMP_VELOCITY
	await anim.animation_finished 
	queue_free()
	Game.PlayerHp = 10
	Game.Gold = 0
	get_tree().change_scene_to_file("res://game_over.tscn")
