extends CharacterBody2D

var speed = 200
const JUMP_VELOCITY = -400.0
const LOWER_LIMIT = 800
@onready var anim = get_node("AnimationPlayer")
var modulator = 0
var modulateUp = true

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
	elif Input.is_action_just_pressed("ui_accept") and is_on_wall():
		#TODO tune this and add animation
		velocity.y = JUMP_VELOCITY
				
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
		$Muzzle.set_rotation_degrees(180)
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
		$Muzzle.set_rotation_degrees(0)
	if direction:
		velocity.x = direction * speed
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if velocity.y == 0:
			anim.play("Idle")
			
	if velocity.y > 0:
		anim.play("Fall")
		
	if Input.is_action_just_pressed("throw_projectile") && Game.Ammo > 0 :
		Game.Ammo -= 1
		var p = preload("res://acorn.tscn").instantiate()
		owner.add_child(p)
		p.transform = $Muzzle.global_transform
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://main.tscn")
		
		#var simultaneous_scene = preload("res://main.tscn").instantiate()
		#get_tree().root.add_child(simultaneous_scene)
	if $SugarRush.visible:
		modulateSugarRushLabel(delta)
	
	if Game.PlayerHp <= 0 || position.y > LOWER_LIMIT:
		playerDeath()
	else: 
		move_and_slide()		
	
		
func playerDeath():	
	anim.play("Death")
	velocity.y = JUMP_VELOCITY
	await anim.animation_finished
	get_tree().change_scene_to_file("res://game_over.tscn")
	
func speedBoost():	
	speed *= 1.5
	$SugarRush.visible = true
	await get_tree().create_timer(5.0).timeout
	speed /= 1.5
	modulator = 0
	$SugarRush.visible = false
	
func modulateSugarRushLabel(delta):
	if modulateUp:
		modulator += delta		
	else:
		modulator -= delta
	
	if modulator >= 0.7:
		modulateUp = false
	elif modulator <= 0.2:
		modulateUp = true
		
	$SugarRush.add_theme_color_override("font_color", Color(modulator,modulator * 0.5, 0, 1))
		
		
	#var color = $SugarRush.get_theme_color("font_color")
	#$SugarRush.add_theme_font_size_override("font_size", 10 * modulator)

