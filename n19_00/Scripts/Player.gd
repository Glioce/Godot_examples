extends KinematicBody2D


# Constants and variables
enum S {IDLE, FOLLOW}
var state = S.IDLE
const speed = 3*60 # walking speed in pixels per second
var v = Vector2() # velocity
var path := PoolVector2Array()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(delta):
	v = Vector2(0, 0) # reset velocity
	
	if Input.is_action_pressed("ui_right"):
		v.x += 1
	if Input.is_action_pressed("ui_left"):
		v.x -= 1
	if Input.is_action_pressed("ui_down"):
		v.y += 1
	if Input.is_action_pressed("ui_up"):
		v.y -= 1
	
	v = v.normalized()
	move_and_slide(v * speed)
	if v != Vector2.ZERO: state = S.IDLE
	
	if state == S.FOLLOW:
		# Calculate the movement distance for this frame
		var distance_to_walk = speed * delta
		
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
