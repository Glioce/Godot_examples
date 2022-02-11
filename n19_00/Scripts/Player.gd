extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var v = 2 # walking speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _physics_process(_delta):
	if Input.is_action_pressed("ui_right"):
		self.position.x += v
	if Input.is_action_pressed("ui_left"):
		self.position.x -= v
	if Input.is_action_pressed("ui_down"):
		self.position.y += v
	if Input.is_action_pressed("ui_up"):
		self.position.y -= v
