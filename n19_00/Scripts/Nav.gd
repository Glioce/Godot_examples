extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map = null


# Called when the node enters the scene tree for the first time.
func _ready():
	map = get_node("TileMapBg")
	var cells = []
	var bits = []
	
	cells.append(map.get_cell(0, 0))
	cells.append(map.get_cell(1, 1))
	cells.append(map.get_cell(2, 2))
	cells.append(map.get_cell(2, 3))
	cells.append(map.get_cell(0, 9))
	cells.append(0)
	#print(cells)
	
	for cell in cells:
		bits.append(map.get_collision_mask_bit(cell))
	#print(bits)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			#var path = $Navigation2D.get_simple_path($Player.position, event.position, false)
			#$Line2D.points = path
			#$Line2D.add_point(event.position)
			#$Player.path = path
			print("click ", $Player.position, " ", event.position)
			#print(path)
