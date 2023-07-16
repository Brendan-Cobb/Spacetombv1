extends KinematicBody2D


# vars
var velocity = Vector2.ZERO
var speed = 1000
var health = 100
var color
var flashTimer = 0
var damagedTexture = load("res://playertesterspriteDamagedFrame.png")
var normalTexture = load("res://opponenttestersprite.png")
var index

func setInitialPosition(p):
	position = p

func setVelocity(v):
	velocity = move_and_slide(v)

func setHealth(h, source):
	health = h
	flash()
	
func die(source):
	queue_free()

func setRotation(r):
	get_node("Sprite").rotation = r
	get_node("CollisionShape2D").rotation = r

func flash():
	get_node("Sprite").set_texture(damagedTexture)
	flashTimer = 0.1

func updateIndex(ind):
	index = ind
	set_collision_layer_bit(6 + index, true)
	
func _process(delta):
	if flashTimer > 0:
		flashTimer -= 1*delta
	else:
		flashTimer = 0
		if get_node_or_null("Sprite") != null:
			get_node("Sprite").set_texture(normalTexture)
