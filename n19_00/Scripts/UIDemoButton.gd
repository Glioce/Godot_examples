extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var n = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_color_override("font_color_hover", Color(0, 0, 0))
	
	var myTheme = Theme.new()
	myTheme.set_color("font_color", "Button", Color(1, 1, 0))
	self.set_theme(myTheme)
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	n += 1
	self.text = "Click number " + str(n)
