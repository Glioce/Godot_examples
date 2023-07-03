extends TileMap


# Map bounds and size
var map_rect = get_used_rect()
var map_size = map_rect.size

# You can only create an AStar node from code, not from the Scene tab.
onready var astar_node = AStar2D.new()
onready var half_cell_size = cell_size / 2


# Called when the node enters the scene tree for the first time.
func _ready():
	# Assign global scene size in pixels
	Global.scene_size = map_size * cell_size.x
	# Find walkable cells and connect them
	var cells_list = astar_add_walkable_cells()
	astar_connect_walkable_cells(cells_list)


# Loops through all cells within the map's bounds and
# adds all points to the astar_node, except the obstacles.
func astar_add_walkable_cells():
	var obstacles = get_used_cells()
	var points_array = []
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x, y)
			if point in obstacles:
				continue

			points_array.append(point)
			# The AStar class references points with indices.
			# Using a function to calculate the index from a point's coordinates
			# ensures we always get the same index with the same input point.
			var point_id = calculate_point_index(point)
			# AStar works for both 2d and 3d, so we have to convert the point
			# coordinates from and to Vectors.
			astar_node.add_point(point_id, point)
	return points_array


func calculate_point_index(point):
	return map_size.x * point.y + point.x


# Once you added all points to the AStar node, you've got to connect them.
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like.
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense, etc.
func astar_connect_walkable_hv(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		# For every cell in the map, we check the one to the top, right.
		# left and bottom of it. If it's in the map and not an obstalce.
		# We connect the current point with it.
		var points_relative = PoolVector2Array([
			point + Vector2.RIGHT,
			point + Vector2.LEFT,
			point + Vector2.DOWN,
			point + Vector2.UP,
		])
		for point_relative in points_relative:
			var point_relative_index = calculate_point_index(point_relative)
			if is_outside_map_bounds(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			# Note the 3rd argument. It tells the astar_node that we want the
			# connection to be bilateral: from point A to B and B to A.
			# If you set this value to false, it becomes a one-way path.
			# As we loop through all points we can set it to false.
			astar_node.connect_points(point_index, point_relative_index, false)


# This is a variation of the method above.
# It connects cells horizontally, vertically AND diagonally.
func astar_connect_walkable_cells_diag(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		for local_y in range(-1, 2):
			for local_x in range(-1, 2):
				var point_relative = Vector2(point.x + local_x, point.y + local_y)
				var point_relative_index = calculate_point_index(point_relative)
				if point_relative == point or is_outside_map_bounds(point_relative):
					continue
				if not astar_node.has_point(point_relative_index):
					continue
				astar_node.connect_points(point_index, point_relative_index, true)


# This variation does not connect diagonals that cause collisions
func astar_connect_walkable_cells(points_array):
	for point in points_array:
		var point_index = calculate_point_index(point)
		
		var diagonals = PoolVector2Array([
			point + Vector2(1, -1), #right up [0]
			point + Vector2(-1, -1), #left up [1]
			point + Vector2(-1, 1), #left down [2]
			point + Vector2(1, 1), #right down [3]
		])
		
		# Check vertical and horizontal relative cells
		var point_relative = point + Vector2.RIGHT
		var point_relative_index = calculate_point_index(point_relative)
		# If point is outside, do nothing to it
		if not is_outside_map_bounds(point_relative):
			if astar_node.has_point(point_relative_index):
				astar_node.connect_points(point_index, point_relative_index, true)
			else: # If point is an obstacle, disable diagonals
				diagonals.set(0, point)
				diagonals.set(3, point)
		
		point_relative = point + Vector2.UP
		point_relative_index = calculate_point_index(point_relative)
		# If point is outside, do nothing to it
		if not is_outside_map_bounds(point_relative):
			if astar_node.has_point(point_relative_index):
				astar_node.connect_points(point_index, point_relative_index, true)
			else: # If point is an obstacle, disable diagonals
				diagonals.set(0, point)
				diagonals.set(1, point)
		
		point_relative = point + Vector2.LEFT
		point_relative_index = calculate_point_index(point_relative)
		# If point is outside, do nothing to it
		if not is_outside_map_bounds(point_relative):
			if astar_node.has_point(point_relative_index):
				astar_node.connect_points(point_index, point_relative_index, true)
			else: # If point is an obstacle, disable diagonals
				diagonals.set(1, point)
				diagonals.set(2, point)
		
		point_relative = point + Vector2.DOWN
		point_relative_index = calculate_point_index(point_relative)
		# If point is outside, do nothing to it
		if not is_outside_map_bounds(point_relative):
			if astar_node.has_point(point_relative_index):
				astar_node.connect_points(point_index, point_relative_index, true)
			else: # If point is an obstacle, disable diagonals
				diagonals.set(2, point)
				diagonals.set(3, point)
		
		for diagonal in diagonals:
			point_relative_index = calculate_point_index(diagonal)
			if diagonal == point or is_outside_map_bounds(point_relative):
				continue
			if not astar_node.has_point(point_relative_index):
				continue
			astar_node.connect_points(point_index, point_relative_index, true)


func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y


# Returns a PoolVector2Array with points in world coordinates
# If there's no path, returns an empty array
func calculate_path(start, end):
	# Convert world coordinates to map coordinates
	var startmap = world_to_map(start)
	var endmap = world_to_map(end)
	# Create empty array
	var world_path = PoolVector2Array()
	
	# Check the start and end points are within the map
	if not is_outside_map_bounds(startmap) and not is_outside_map_bounds(endmap):
		# Calculate ids
		var from = calculate_point_index(startmap)
		var to = calculate_point_index(endmap)
		var map_path = astar_node.get_point_path(from, to)
		for point in map_path:
			#world_path.append(point * cell_size.x + half_cell_size)
			world_path.append(map_to_world(point) + half_cell_size)
			
	#print(world_path)
	# Compare distances to prevent the player move back when generating a new path
	if world_path.size() > 1:
		var d1 = world_path[1].distance_to(start)
		var d2 = world_path[1].distance_to(world_path[0])
		if d1 < d2:
			world_path.remove(0)
	return world_path
