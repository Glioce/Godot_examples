extends Node2D

# States
enum S {FADE_IN, FADE_OUT, GUI, SEL_MOVE, SEL_AREA, MOVE_ANIM, END}
# FADE_IN - Intro animation, Player and Piñata fade in, text on the bottom
# FADE_OUT - Player and Piñata fade out, text dont move
# GUI - The GUI appears
# SEL_MOVE - Select move or attack
# SEL_AREA - Select area to attack
# MOVE_ANIM - Animation of the attack
# END - The player win or fail
var state = S.FADE_IN
var state_begin := true # To trigger animations just one time

onready var animation_player := $AnimationPlayer

func _ready():
	#animation_player.play("Intro")
	pass


func _process(delta):
	match state:
		S.FADE_IN:
			if state_begin:
				animation_player.play("Intro")
				state_begin = false
		S.FADE_OUT:
			if state_begin:
				animation_player.play("Intro", 1, 1, true)
				state_begin = false
	
	pass


func _on_TouchScreenButton_pressed():
	print("TOUCH")
	pass # Replace with function body.
