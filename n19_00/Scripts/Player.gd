extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var r = 3*60 # walking speed
var v = Vector2() # velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	v = Vector2(0, 0) # reset velocity
	
	if Input.is_action_pressed("ui_right"):
		v.x += 1
	if Input.is_action_pressed("ui_left"):
		v.x -= 1
	if Input.is_action_pressed("ui_down"):
		v.y += 1
	if Input.is_action_pressed("ui_up"):
		v.y -= 1
	
	v = v.normalized()
	move_and_slide(v * r)
	
#	if Input.is_action_pressed("ui_right"):
#		self.position.x += v
#	if Input.is_action_pressed("ui_left"):
#		self.position.x -= v
#	if Input.is_action_pressed("ui_down"):
#		self.position.y += v
#	if Input.is_action_pressed("ui_up"):
#		self.position.y -= v
