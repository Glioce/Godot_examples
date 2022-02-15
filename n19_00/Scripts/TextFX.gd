extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var msg = """-Este es el texto de prueba.
Me gusta complicarme la vida.-"""

var arr = msg.split(" ")


# Called when the node enters the scene tree for the first time.
func _ready():
	bbcode_text = msg
	for item in arr:
		print(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	pass
