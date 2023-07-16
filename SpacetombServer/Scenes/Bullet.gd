extends Area2D
var velocity
var source
export var lifetime = 2000
export var damage = 5
onready var server = get_node("/root/Server")
onready var serverData = get_node("/root/ServerData")

func getClass():
	return "Bullet"

func initialize(velocityVector, positionVector, speed, playerSource):
	source = str(playerSource)
	position = positionVector
	velocity = velocityVector.normalized() * speed

func _process(delta):
	
	# Bullet moves along velocity vector
	position += velocity * delta
	#when it collides with a body that isn't the player, or another bullet
	
	# destroys self when lifetime is up, used to reduce lag from too many bullets existing
	if lifetime <= 0:
		queue_free()
	
	# lifetime goes down by 1 every frame
	lifetime -= 1 * delta


func _on_Area2D_area_entered(area):
	if area.name != source:
		if area.has_method("takeDamage"):
			area.takeDamage(damage, "Bullet")
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name != source:
		if body.has_method("takeDamage"):
			body.takeDamage(damage, "Bullet")
		queue_free()
