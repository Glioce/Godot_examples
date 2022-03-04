extends KinematicBody2D


# States
enum S {IDLE, FOLLOW, TRANSITION, EXIT, ENTER, PAUSE}
# IDLE - the player does nothing
# FOLLOW - the player follows a path, can receive inputs
# TRANSITION - follows a path to exit o enter an area
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	# Read input
	v = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# State machine
	match state:
		
		S.IDLE:
			if door != null:
				$Label.text = str(door.calculate_exit_distance(self))
			else:
				$Label.text = "X"
			
			move_and_slide(v * speed)
				
		S.FOLLOW:
			if v != Vector2.ZERO:
				move_and_slide(v * speed)
				state = S.IDLE
			else:
				follow_path(delta)
			
			if door != null:
				$Label.text = str(door.calculate_exit_distance(self))
			else:
				$Label.text = "X"
				
			if path.size() == 0:
				state = S.IDLE
				
		S.TRANSITION:
			follow_path(delta)
			#if path.size() == 0:
				#state = S.IDLE


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
