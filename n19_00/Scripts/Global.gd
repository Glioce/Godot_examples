extends Node
# This script is auto-loaded (Project Settings)
# Contains global variables used in different scenes

# Test variable
var terrible = true

# Wether the player is doing scene transition or not
var scene_transition := false

# The position the player moves when entering the new scene
# Relative position
var transition_pos := Vector2()

# Target group name used for transition
var transition_group := ""

# Sscene size in pixels (can be obtained from a tile map)
var scene_size := Vector2()
