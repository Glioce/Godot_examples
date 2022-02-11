extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonPlay_pressed():
	print("Play pressed")
	get_tree().change_scene("res://Scenes/West.tscn")


func _on_ButtonCredits_pressed():
	print("Credits pressed")


func _on_ButtonExit_pressed():
	print("Exit pressed")
