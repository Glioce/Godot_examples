# Trasition
#
# Puertas en las casas y en las orillas de los mapas.
# Se usa para indicar las zonas por donde se puede acceder a otra escena.
# body entered signal para guardar identificador de objeto
# body exited signal para borrar identificador de objeto
# se puede rotar para indicar la dirección de salida
#
#
#Antes de cambiar de escena guarda:
#- coordenadas relativas al objeto puerta
#- nombre del objeto destino en la nueva escena (o nombre de grupo)
#
#En la nueva escena el Player revisa si se realizó una transición en Global
#Global.scene_transition == true
#
#Si ocurre la transición
#- Busca el objeto puerta en el que debe iniciar
#- Se transporta al objeto en las coordenadas relativas
#- Se agrega un punto a path para indicar la posición en la que termina la animación de transición
#  El punto se agrega en dirección contraria al vector de salida (exit_vector)
#- Player inicia en el estado TRANSITION
#- Se desactiva la variable que indica la transisición de escena (Global.scene_transition)
#
#Tal vez es mejor usar los estados enter y exit. Por ahora el estado transition ha funcionado
#
#func _ready():
#    add_to_group("guards")

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
