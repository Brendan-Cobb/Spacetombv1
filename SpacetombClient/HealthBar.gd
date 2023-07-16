extends TextureProgress

# vars
# get player object
onready var player = get_node("../../Player")



# Called when the node enters the scene tree for the first time.
func _ready():
	#initializes health bar to  player health
	value = player.health
	
	# connects the _whenPlayerDamaged() function to trigger whenever the player is damaged
	player.connect("damaged", self, "_whenPlayerDamaged")

# triggers when player sends the damaged signal
func _whenPlayerDamaged(_damage):
	
	value = player.health
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
