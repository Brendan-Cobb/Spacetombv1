extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed = 100
export var health = 40
export var damage = 3
export var attackDelay = 0.02
var damageTick = 0.0
onready var server = get_node("/root/Server")
onready var serverData = get_node("/root/ServerData")

func getClass():
	return "Enemy1"

func initialize(p):
	self.position = p
	
func getNearestPlayer():
	var distanceToPlayer = 900
	var nearestPlayer = 0
	
	for player_id in serverData.playerIDS:
		var newDistance = self.position.distance_to(get_parent().get_node_or_null(str(player_id)).position)
		if newDistance < distanceToPlayer:
			distanceToPlayer = newDistance
			nearestPlayer = player_id
	
	return get_tree().get_root().get_node_or_null(str(nearestPlayer))
	
func enemyMove(target):
	
	if target:
		velocity = self.position.direction_to(target.position) * speed
		
	velocity = move_and_slide(velocity)
	
	
func takeDamage(d, source):
	health -= d
	if health > 0:
		server.setHealth(int(name), health, source)
	else:
		serverData.enemyIDS.erase(int(name))
		server.entityDead(int(name), source)
		queue_free()
	
func _process(delta):
	
	server.returnEntityMovement(int(self.name), self.position, self.velocity)
	
	var target = getNearestPlayer()

	if target:
		if self.get_node("DetectorEnemy1").overlaps_body(target) and damageTick == 0:
			target.takeDamage(damage, "Enemy")
			damageTick = attackDelay
			
	enemyMove(target)
		
	if damageTick > 0:
		damageTick -= 0.1 * delta
	else:
		damageTick = 0
		


