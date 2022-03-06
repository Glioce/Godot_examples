extends Area2D

# Path to scene
export var target_scene := "res://Scenes/Zones/"
export var target_group := ""

# Player object
#var player_object = null

# This vector points to the direction the Player can exit
var degrees = round(rotation_degrees)
var radians = deg2rad(degrees)
var exit_vector := Vector2(cos(radians), -sin(radians))
#var exit_vector := Vector2(1, 0).rotated(radians)


func _ready():
	print(target_scene)
	print(exit_vector)
	#print(degrees)
	#print(radians)


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


# Project the vector door-to-player on the exit vector using dot product
# The result is how near is the player to the scene border
func calculate_exit_distance(obj):
	return exit_vector.dot( obj.position - self.position)
