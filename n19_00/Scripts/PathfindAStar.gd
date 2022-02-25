extends TileMap

# Map bounds and size in cells
var map_rect = get_used_rect()
var map_size = map_rect.size

# The path start and end variables use setter methods.
# You can find them at the bottom of the script.
#var path_start_position = Vector2() setget _set_path_start_position
#var path_end_position = Vector2() setget _set_path_end_position

var _point_path = []

# You can only create an AStar node from code, not from the Scene tab.
onready var astar_node = AStar2D.new()
#onready var obstacles = get_used_cells()
onready var _half_cell_size = cell_size / 2



# Called when the node enters the scene tree for the first time.
func _ready():
	var cells_list = astar_add_walkable_cells()
	astar_connect_walkable_cells(cells_list)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
			# coordinates from and to Vector3s.
			astar_node.add_point(point_id, point)
	return points_array


func calculate_point_index(point):
	return map_size.x * point.y + point.x


# Once you added all points to the AStar node, you've got to connect them.
# The points don't have to be on a grid: you can use this class
# to create walkable graphs however you'd like.
# It's a little harder to code at first, but works for 2d, 3d,
# orthogonal grids, hex grids, tower defense, etc.
func astar_connect_walkable_cells(points_array):
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


func is_outside_map_bounds(point):
	return point.x < 0 or point.y < 0 or point.x >= map_size.x or point.y >= map_size.y
	
	
func calculate_path(start, end):
	var from = calculate_point_index( world_to_map(start))
	var to = calculate_point_index( world_to_map(end))
	var map_path = astar_node.get_point_path(from, to)
	var world_path = PoolVector2Array()
	
	for point in map_path:
		world_path.append(point * cell_size.x + _half_cell_size)
		
	print(world_path)
	return world_path
