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

# Tut turn-based combar system
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
# Fast sprites to test
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

#extends Node2D
extends Control

onready var actionsArr = $Actions.get_children()
onready var gridArr = $Grid.get_children()
onready var random = RandomNumberGenerator.new()

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
	random.randomize()
	move_pina()

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
	var x = random.randf_range(320, 960)
	var y = random.randf_range(144, 400)
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
