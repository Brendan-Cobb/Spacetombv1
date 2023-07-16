extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 1000
var health = 100
onready var server = get_node("../Server")
onready var serverData = get_node("../ServerData")

func setInitialPosition(p):
	position = p

func getPosition():
	return position

func setVelocity(v):
	velocity = move_and_slide(v)

func getVelocity():
	return velocity

func takeDamage(d, source):
	health -= d
	if health > 0:
		server.setHealth(int(name), health, source)
	else:
		server.entityDead(int(name), source)
		serverData.playerIDS.erase(int(name))
		queue_free()
		
func getClass():
	return "Player"
