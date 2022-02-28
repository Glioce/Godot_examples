extends Area2D

# Path to scene
export var scene_path = "res://Scenes/Zones/"


func _ready():
	print(scene_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print(body)
	#body.state = body.S.PAUSE
	get_tree().change_scene(scene_path)
