extends Area2D

# vars
var normDirection
var velocity
export var lifetime = 50
export var damage = 2
var debug = 0
onready var usesEnemyLayer
var ownedBy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# function takes a target position and a speed and sets the bullet's velocity to the given speed towards that point
func initialize(directionVector, positionVector, speed, ownr):
	position = positionVector
	normDirection = directionVector.normalized()
	velocity = normDirection * speed
	ownedBy = ownr

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	# Bullet moves along velocity vector
	position += velocity * delta
	
	#collision detection
	
	# destroys self when lifetime is up, used to reduce lag from too many bullets existing
	if lifetime <= 0:
		queue_free()
	
	# lifetime and collisionDelay go down by 1 every second
	lifetime -= 1* delta

func _on_Area2D_area_entered(area):
	if area.get_parent().name != str(ownedBy):
		print(area.name)
		print(str(ownedBy))
		queue_free()



func _on_Area2D_body_entered(body):
	if body.name != str(ownedBy):
		print(body.name)
		print(str(ownedBy))
		queue_free()
