extends KinematicBody2D


# States
enum S {IDLE, FOLLOW, TRANSITION, EXIT, ENTER, PAUSE}
# IDLE - the player does nothing
# FOLLOW - the player follows a path, can receive inputs
# TRANSITION - follows a path to exit o enter an area, not receive inputs
# EXIT - similar to transition, but just exits the current scene
# ENTER - similar to transition, but just enters to a new scene
var state = S.IDLE

const speed = 3*60 # walking speed in pixels per second
var v = Vector2() # velocity
var path := PoolVector2Array()

var door = null


func _ready():
	# Set limits of the camera
	#$Camera2D.limit_left = 0
	#$Camera2D.limit_top = 0
	$Camera2D.limit_right = Global.scene_size.x
	$Camera2D.limit_bottom = Global.scene_size.y
	
	if Global.scene_transition == true:
		print("Transitioning")
		# Search the door
		var nodes_array = get_tree().get_nodes_in_group(Global.transition_group)
		door = nodes_array[0] # There's must be only one node in the group
		# Move the Player to the starting position
		position = door.position + Global.transition_pos
		# Add point to path
		path.resize(0) # Clear path
		path.append(position - (door.exit_vector * 33)) # Negative vector to enter
		state = S.TRANSITION # Change state of the Player
		# Disble flag
		Global.scene_transition = false


func _physics_process(delta):
	# Read input
	v = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Check distance to scene border
	if door != null:
		var distance = door.calculate_exit_distance(self)
		$Label.text = str(distance)
		
		# Start the transition
		if state == S.IDLE and distance >= -32:
			path.resize(0) # clear path
			path.append(position + (door.exit_vector * 64))
			state = S.TRANSITION
			
		# Exit scene
		if state == S.TRANSITION and distance >= 0:
			# Set transition flag to true
			Global.scene_transition = true
			# Save relative position
			Global.transition_pos = position - door.position
			# Save name of target object
			Global.transition_group = door.target_group
			# Chage scene
			print("Change")
			get_tree().change_scene(door.target_scene)
			
			
	else: # There's no door
		$Label.text = "X"
	
	# State machine
	match state:
		
		S.IDLE:
			move_and_slide(v * speed)
				
		S.FOLLOW:
			if v != Vector2.ZERO:
				move_and_slide(v * speed)
				state = S.IDLE
			else:
				follow_path(delta)
				
			if path.size() == 0:
				state = S.IDLE
				
		S.TRANSITION:
			follow_path(delta)
			if path.size() == 0:
				state = S.IDLE


func follow_path(d):
	# Calculate the movement distance for this frame
	var distance_to_walk = speed * d
	
	# Move the player along the path until he has run out of movement or the path ends.
	while distance_to_walk > 0 and path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
		# Update the distance to walk
		distance_to_walk -= distance_to_next_point

# Reset velocity
	#v = Vector2(0, 0)
	# Read inputs
	#if Input.is_action_pressed("ui_right"):
	#	v.x += 1
	#if Input.is_action_pressed("ui_left"):
	#	v.x -= 1
	#if Input.is_action_pressed("ui_down"):
	#	v.y += 1
	#if Input.is_action_pressed("ui_up"):
	#	v.y -= 1
	# Normalize velocity
	#v = v.normalized()
	
# Exit to the right
			# The global scene size is assigned in TileMapCol _ready func
#			if position.x >= Global.scene_size.x - 32:
#				path.resize(0) # clear path
#				path.append(position + Vector2(64, 0))
#				state = S.TRANSITION
#			# Exit to the left
#			elif position.x <= 32:
#				path.resize(0) # clear path
#				path.append(position - Vector2(64, 0))
#				state = S.TRANSITION
#			# Exit down
#			elif position.y >= Global.scene_size.y - 32:
#				path.resize(0) # clear path
#				path.append(position + Vector2(0, 64))
#				state = S.TRANSITION
#			# Exit up
#			elif position.y <= 32:
#				path.resize(0) # clear path
#				path.append(position - Vector2(0, 64))
#				state = S.TRANSITION
