extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_PlayButton_pressed():
	get_tree().change_scene("res://mapFrame.tscn")
	Server.startConnection(1909)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_LiscenseButton_pressed():
	get_tree().change_scene("res://LisenceScreen.tscn")
