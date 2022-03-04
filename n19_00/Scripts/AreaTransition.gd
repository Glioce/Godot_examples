extends Area2D

# Path to scene
export var scene_path := "res://Scenes/Zones/"

# Player object
#var player_object = null

# This vector points to the direction the Player can exit
var exit_vector := Vector2(1, 0).rotated(rotation_degrees)


func _ready():
	print(scene_path)


func _on_Area2D_body_entered(body):
	# Set object door
	body.door = self
	
	#player_object = body
	#print(body)
	#body.state = body.S.PAUSE
	#get_tree().change_scene(scene_path)


func _on_Area2D_body_exited(body):
	# Delete value of door
	body.door = null


func calculate_exit_distance(obj):
	return exit_vector.dot( obj.position - self.position)
