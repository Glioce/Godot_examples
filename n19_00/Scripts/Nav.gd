extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map = null


# Called when the node enters the scene tree for the first time.
func _ready():
	map = get_node("TileMapCol")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			var global_mouse_pos = get_global_mouse_position()
			var path = $TileMapCol.calculate_path($Player.position, global_mouse_pos)
			#var path = $TileMapCol.calculate_path($Player.position, event.position)
			#var path = $Navigation2D.get_simple_path($Player.position, event.position, false)
			$Line2D.points = path
			$Player.path = path
			$Player.state = $Player.S.FOLLOW
			print("click ", $Player.position, " ", event.position)
			#print(path)
