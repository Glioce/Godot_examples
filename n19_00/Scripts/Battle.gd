# The battle scene has GUI and animations
# In this scene the player destroy píñatas
# The same scene is used for all piñatas, just different resources are loaded

# State machine:
# - Before this scene is loaded, global values are saved
# - Intro
# - Game
# - Outro
# Some battles are tutorials. How to manage the text instruciones?


# Tut radio button
# https://www.youtube.com/watch?v=rwxHN25PFGQ

# Tut turn-based combat system
# https://github.com/jontopielski/Turn-Based-Combat

# In the game mode there are 2 button sets: actions and grid/zones
# Each set has a button group resource and behave like radio buttons
# The buttons can be selected and pressed with keyboard, mouse, and touchscreen

# First the actions are active. They have 3 textures for 3 states:
#  Normal - black rectangle
#  Pressed/selected - white rect (colored with self_modulate)
#  Focused - white lines outside

# Second the grid is active. There are 2 grid types: with 3 and 6 rects
# Like the actions, the grid use 3 textures:
#  Normal - transparent rectangle
#  Pressed/selected - aim icon ?
#  Focussed - white lines outside

# Connect signals with script to prevent to do manually many times
# Fast drawn sprites to test
# Define Input Map keys for "yes" and "no" ("accept" and "cancel")

# If there are less actions ulocked make buttons invisible
# If actions change, the signal connections with code are useful

# Useful props and methods
# focus_mode
# has_focus()
# get_focus_owner()
# release_focus()
# grab_focus()
# grab_click_focus()
# focus_neighbour_*
#
# Piñata movement
# Defined with the next properties:
# - Name/ID - name of the definition
# - Mode - random or pattern/sequence
# - Grid - grid size (3x1, 3x2, etc., optional)
# - Diagonal - are diagonal movements allowed?
# - Pattern - arrays of Vector2 (only if mode is pattern)
# We can add piñata object properties
# ¿Can they be saved as a resource?
# - Name - the same as above
# - Sprite - appearence
# - Desc- description
# - Health - the piñatas are no alive
# - Speed - does it has any sense?

#extends Node2D
extends Control

# Objects
onready var actionsArr = $Actions.get_children()
onready var gridArr = $Grid.get_children() #buttons on the grid
onready var random = RandomNumberGenerator.new()

# How to save the instruments info
# Each instrument is like an object, having the following attributes:
# name, description, atk power, size/range/length, speed, effectiveness
# And can have amulets to modify attributes
# Are the attacks/moves contained in the player or in the instruments?

# Piñata definition example
var pina = {
	"name": "Olla de Barro",
	"sprite": 0, #how to assing?
	"desc": "Una piñata sin picos es solo una olla. Está adornada con tiras de papel",
	"health": 10, #easy to break
	"speed": 1, #slow
	"grid": Vector2(3, 1),
	"mode": "random", #movement
	"diag": false,
	"maxd": 1, #max distance
	"pattern": [
		Vector2(0,0),
		Vector2(1,0),
		Vector2(2,0),
		Vector2(1,0),
	],
}
# Maybe the gid size must be defined outside of pinata object

# Variables of battle
var pinaHealth = 100 # Health of the piñata
var time = 100 # Remaining time to break the piñata
var instrument = Global.instruments[0]

# Other variables
#var gridSize := Vector2()
var cellSize := Vector2(320, 256)
var cellOffset := Vector2(320, 144)
var grid := Vector2(3, 2) #grid size, just for test, fix later
var i # position in the grid
var j

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make the grid invisible
	$Grid.visible = false
	# Focus the first button on the actions
	actionsArr[0].grab_focus()
	$Actions/Stop.visible = false
	# Test piñata animation
	$Img/Tween.connect("tween_all_completed", self, "move_pina")
	#$Img/Tween.connect("tween_completed", self, "move_pina")
	
	# Random seed for movement
	random.randomize()
	
	# Starting position of piñata
	i = random.randi_range(0, grid.x - 1)
	j = random.randi_range(0, grid.y - 1)
	$Img/Pina.position.x = i * cellSize.x + cellOffset.x
	$Img/Pina.position.y = j * cellSize.y + cellOffset.y
	
	move_pina()
	print(instrument.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_test"):
		# Disable action buttons
		for item in actionsArr:
			item.focus_mode = Control.FOCUS_NONE
			# The next node receives mouse clicks and stops propagation
			$Actions/Stop.visible = true
			#set_pause_node(item, true)
			#item.disabled = true
			#item.pressed = true
		# Enable grid buttons
		$Grid.visible = true
		gridArr[1].grab_focus()
		#get_tree().paused = true
		
func move_pina():
	# Completely random
#	var x = random.randf_range(320, 960)
#	var y = random.randf_range(144, 400)
	
	# Random but aligned to grid
#	i = random.randi_range(0, grid.x - 1)
#	j = random.randi_range(0, grid.y - 1)
#	var x = i * cellSize.x + cellOffset.x
#	var y = j * cellSize.y + cellOffset.y
	
	# Random with step of 1
	# If the piñata speed is low, the new random position can be the same
	# We create a list of posible next positions
	var posArr = []
	#if pina.speed < 2: posArr.append(Vector2.ZERO) # slow
	if i > 0: posArr.append(Vector2(-1, 0)) # can go to the left
	if i < grid.x - 1: posArr.append(Vector2(1, 0)) # can go to the right
	if j > 0: posArr.append(Vector2(0, -1)) # can go up
	if j < grid.y - 1: posArr.append(Vector2(0, 1)) # can go down
	var item = posArr[random.randi_range(0, posArr.size() - 1)] # random item
	i += item.x
	j += item.y
	var x = i * cellSize.x + cellOffset.x
	var y = j * cellSize.y + cellOffset.y
	
	$Img/Tween.interpolate_property($Img/Pina, "position",
		null, Vector2(x, y), 1.0, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Img/Tween.start()
	
	
# Scripts by TheFamousRat
# https://www.reddit.com/r/godot/comments/bkrtzi/utility_functions_to_pause_a_scenea_node/

#(Un)pauses a single node
func set_pause_node(node : Node, pause : bool) -> void:
	node.set_process(!pause)
	node.set_process_input(!pause)
	node.set_process_internal(!pause)
	node.set_process_unhandled_input(!pause)
	node.set_process_unhandled_key_input(!pause)

#(Un)pauses a scene
#Ignored childs is an optional argument, that contains the path of nodes whose state must not be altered by the function
func set_pause_scene(rootNode : Node, pause : bool, ignoredChilds : PoolStringArray = [null]):
	set_pause_node(rootNode, pause)
	for node in rootNode.get_children():
		if not (String(node.get_path()) in ignoredChilds):
			set_pause_scene(node, pause, ignoredChilds)

#var btn = $Actions.get_children()[0]
#btn.grab_focus()
#		set_pause_scene($NinePatchRect, true)
#		set_pause_node($NinePatchRect/TextureButton1, true)
#		get_tree().paused = true
