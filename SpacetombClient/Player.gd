extends KinematicBody2D

# vars
onready var bulletScene = preload("res://Bullet.tscn")

var velocity = Vector2.ZERO
var screen_size
export var bulletSpeed = 1000
export var deceleration = 200
export var speed = 600
export var health = 100
var damagedTexture = load("res://playertesterspriteDamagedFrame.png")
var normalTexture = load("res://playertestersprite.png")
var flashTimer = 0

# signals
signal damaged(source)
signal killed()

# Damage function, emits a damaged signal
# IMPORTANT: You MUST use this function to damage the player or many effects that take place when the player is damaged will not take
# place! (INCLUDING THE HEALTH BAR UPDATING!)
func setHealth(h, source):
	flashTimer = .1
	emit_signal("damaged", source)
	health = h
	get_node("Sprite").set_texture(damagedTexture)

# Death function, will be changed later
func die(source):
	# In GDScript, queue_free() destroys the node it is on
	#FIXME: need to make a better death system later
	setHealth(0, source)
	emit_signal("killed")
	queue_free()


# this function causes the player to constantly decelerate in the direction it is moving
func decelerate():
		# Player constantly decelerates
	# Top statement is for canceling positive movement, bottom is for negative
	if velocity.x > 0:
		velocity.x -= deceleration
		if velocity.x < 0:
			velocity.x = 0
	elif velocity.x < 0:
		velocity.x += deceleration
		if velocity.x > 0:
			velocity.x = 0

	# Vertical deceleration
	if velocity.y > 0:
		velocity.y -= deceleration
		if velocity.y < 0:
			velocity.y = 0
	elif velocity.y < 0:
		velocity.y += deceleration
		if velocity.y > 0:
			velocity.y = 0

# spawns a bullet
func shoot():
		# creates new bullet instance
		var bullet = bulletScene.instance()
		# creates direction vector from player position to mouse position
		var directionVector = get_global_mouse_position() - position
		
		#Vector math to find offset relative to direction
		var offsetVector = directionVector.normalized() * 30
		
		#adds instance as child object
		bullet.initialize(directionVector, Vector2(position.x + offsetVector.x, position.y + offsetVector.y), bulletSpeed, int(name))
		get_parent().add_child(bullet)
		
		#shares shot with server (which will then go to other players)
		Server.shoot(directionVector, Vector2(position.x + offsetVector.x, position.y + offsetVector.y), bulletSpeed)

# get screen size variable when loaded in
func _ready():
	screen_size = get_viewport_rect().size
	
# Called whenever an input is read
func _input(event):
	
	# shoots when shoot button pressed
	if event.is_action_pressed("shoot"):
		shoot()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	playerRotation()
	### MOVEMENT ###
	decelerate()
	
	# When movement key pressed, player's velocity is set to speed variable in corresponding direction
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed

	# DEBUG: Spawns an enemy on press of the key. REMOVE LATER!!!!!!!!
	if Input.is_action_just_pressed("debug_key"):
		Server.debugSpawnEnemy()
	#Calls client playerMove function with values for initial position and velocity
	Server.playerMove(position, velocity)
	
	# Player constantly accelerates in the direction of its velocity
	velocity = move_and_slide(velocity)
	
	if flashTimer > 0:
		flashTimer -= 1*delta
	else:
		flashTimer = 0
		get_node("Sprite").set_texture(normalTexture)
	
func playerRotation():
	get_node("Sprite").rotation = (get_global_mouse_position() - position).angle() + deg2rad(90)
	get_node("CollisionShape2D").rotation = (get_global_mouse_position() - position).angle() + deg2rad(90)
	Server.sendPlayerRotation(get_node("Sprite").rotation)
