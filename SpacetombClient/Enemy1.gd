extends KinematicBody2D

# vars
var velocity = Vector2.ZERO
var speed = 100
var health = 20


signal damaged(source)
signal enemy_killed(source)
# Damage function, emits a damaged signal
# IMPORTANT: You MUST use this function to damage the enemy or many effects will not work
func setHealth(amount, source):
	health = amount
	emit_signal("damaged", source)
	
func setInitialPosition(p):
	position = p

func setVelocity(v):
	velocity = move_and_slide(v)
	
# death function, used when enemy dies
func die(source):
	# In GDScript, queue_free() destroys the node it is on
	#FIXME: need to make a better death system later
	#lets other scripts know the enemy died
	emit_signal("enemy_killed", source)
	queue_free()
	
