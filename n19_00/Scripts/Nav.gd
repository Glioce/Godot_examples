# Navigation "Nav"
# Detects the click on the map and request the path for the plaer.
# It is done here because the map is independent of the player and 
# the map is a children of this node.
#
# Usar un TileMap especial para las colisiones
# Nombres que se pueden usar
# - CollisionMap
# - ColMap
# - TileCollisions
# - TileCol
# - TileMapCollision
#
# La construcción del escenario se puede hacer en capas.
# La mayor parte está construída con tile maps. Otras partes con sprites.
#
# Por lo general se deben tener 2 capas: Fondo (piso) y construcciones 
# (obstáculos). Una capa extra es para las colisiones (mencionada anteriomente)
#
# Se usan nodos Area2D para detectar colisiones con el Player y cambiar 
# de escena.

extends Node2D

var map = null

# Called when the node enters the scene tree for the first time.
func _ready():
	map = get_node("TileMapCol")


# Click to move the Player
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			
			# Generate path only if the Player is idle or following another path
			if $Player.state == $Player.S.IDLE or $Player.state == $Player.S.FOLLOW:
				var global_mouse_pos = get_global_mouse_position()
				var path = $TileMapCol.calculate_path($Player.position, global_mouse_pos)
				#var path = $TileMapCol.calculate_path($Player.position, event.position)
				#var path = $Navigation2D.get_simple_path($Player.position, event.position, false)
				$Line2D.clear_points()
				$Line2D.points = path
				$Player.path = path
				$Player.state = $Player.S.FOLLOW
				#print("click ", $Player.position, " ", event.position)
				#print(path)
