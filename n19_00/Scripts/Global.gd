# -= Global =-
# This script is auto-loaded (Project Settings)
# Contains global variables used in different scenes.
# Also contain notes of the game design
#
# Pirmero hacer todo el código en archivos separados y, si parece neceario,
# combinarlo en un solo archivo.

extends Node

#pause_mode = PAUSE_MODE_PROCESS

# Test variable
var terrible = true

# Wether the player is doing scene transition or not
var scene_transition := false

# The position the player changes when entering the new scene
# Relative position
var transition_pos := Vector2()

# Target group name used for transition
var transition_group := ""

# Sscene size in pixels (can be obtained from a tile map)
var scene_size := Vector2(1280, 720)

# Instruments/weapons stats (array of dictionaries)
#
# desc - description
# power - attack power
# range - distance
# speed - can it hit a fast piñata?
# precision/accuracy/ - optional, probability of hitting a piñata
#
# Refs
# http://howtomakeanrpg.com/a/how-to-make-an-rpg-stats.html
# https://en.wikipedia.org/wiki/Attribute_(role-playing_games)
var instruments = [
	{
		"name": "PALO DE ESCOBA", #1
		"desc": "xD",
		"power": 1, #LOW power
		"range": 1, #LOW range
		"speed": 2, #MEDIUM speed
	},
	{
		"name": "TABLA ASTILLADA", #2
		"desc": ":o",
		"power": 2, #MEDIUM power
		"range": 1, #LOW range
		"speed": 1, #LOW speed
	},
	{
		"name": "RAMA RETORCIDA", #3
		"desc": "~~~",
		"power": 1, #LOW power
		"range": 2, #MEDIUM range
		"speed": 3, #HIGH speed
	},
	{
		"name": "BAT DE MADERA", #4
		"desc": "o--",
		"power": 2, #MEDIUM power
		"range": 2, #MEDIUM range
		"speed": 2, #MEDIUM speed
	},
	{
		"name": "BAT DE ALUMINIO", #5
		"desc": "o==",
		"power": 3, #HIGH power
		"range": 2, #MEDIUM range
		"speed": 2, #MEDIUM speed
	},
	{
		"name": "TUBO DE ACERO", #6
		"desc": ":::",
		"power": 3, #HIGH power
		"range": 2, #MEDIUM range
		"speed": 3, #HIGH speed
	},
]

# Lost objects/collectables (array of dictionaries)
#
# desc - description
# char - character (optional), to indicate who can recieve the object
var collectables = [
	{
		"name": "ESTRELLA DE NAVIDAD", #0
		"desc": "Una estrella dorada para colocar en la punta de un árbol",
		"char": "Sara",
	},
	{
		"name": "BUFANDA", #1
		"desc": "Bufanda tejida a mano",
		"char": "Bruja",
	},
	{
		"name": "LLAVE ANTIGUA", #2
		"desc": "Debe abrir una puerta antigua",
		"char": "Puerta al bosque",
	},
	{
		"name": "FIGURILLA CABRA", #3
		"desc": "Figurilla de cerámica con forma de cabra",
		"char": "Iglesia",
	},
	{
		"name": "Zapatos para perro", #4
		"desc": "Diseño especializado",
		"char": "Perro",
	},
	{
		"name": "Axolopesos", #5
		"desc": "Dinero con temática de axolotes",
		"char": "Vendedor de piñatas",
	},
]
