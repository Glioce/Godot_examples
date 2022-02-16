extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var msg = """-Este es el texto de prueba.
Me gusta complicarme la vida.-"""

# Words array
var arr = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
	bbcode_text = msg
	
	var word = "" # empty string, will be filled
	for c in msg: # iterate over characters
		word += c # concatenate in word
		if c == ' ' or c == '\n': # if the char is a space or a new line
			arr.append(word) # append word to array
			word = "" # empty string
	arr.append(word) # append the last word found
		
	for item in arr:
		print(item)
		print("#")
	
#	var lines = msg.split('\n') # split lines
#	var words
#
#	for line in lines:
#		words = line.split(' ')
#		for word in words:
#			arr.append(word + ' ')
#		#arr.append('\n')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(_delta):
	pass
