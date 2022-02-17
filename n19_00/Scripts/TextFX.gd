extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var msg = """Este es el texto de prueba.
Me gusta complicarme la vida.-"""

# Words array
var wordArr = Array()
var labelArr = Array()
var pos = Vector2()
#var font = get_font("normal_font")
# range in array
var minIndex = 0
var maxIndex = 1
var val = 0.40 # value to start showing the next word
var delta = 0.04 # change in each step

# Note: The children inherit theme

# Called when the node enters the scene tree for the first time.
func _ready():
	bbcode_text = "" # delete text
	
#	var l = Label.new() # create label
#	print(l.rect_size)
#	l.text = "word45654" # assign text of new label
#	self.add_child(l)
#	print(l.rect_size)
	
	var word = "" # empty string, will be filled
	for c in msg: # iterate over characters
		if c == ' ' or c == '\n': # if the char is a separator
			word += ' ' # add space
			var label = Label.new() # create label
			label.text = word # assign text of new label
			self.add_child(label) # label becomes child
			label.rect_position = pos
			
			if c == ' ':
				pos.x += label.rect_size.x
			if c == '\n':
				pos.x = 0
				pos.y += label.rect_size.y
			
			# the word is not visible
			label.modulate.a = 0.0
			label.rect_scale.y = 0.0
			
			labelArr.append(label) # array of labels
			wordArr.append(word) # append word to array
			word = "" # empty again
		else:
			word += c # fill word
	
	# Create label for the last word
	var label = Label.new() # create label
	label.text = word # assign text
	self.add_child(label) # label becomes child
	label.rect_position = pos # set position
	label.modulate.a = 0.0
	label.rect_scale.y = 0.0
	labelArr.append(label)
	wordArr.append(word) # append the last word

	# Debug
	for item in wordArr:
		print(item + "#")
	
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
	var label
	for i in range(minIndex, maxIndex):
		label = labelArr[i]
		label.rect_scale.y += delta
		label.modulate.a += delta
		
		# not go over 1
		if label.modulate.a >= 1:
			label.rect_scale.y = 1
			label.modulate.a = 1
			minIndex += 1 # next index

		if i == maxIndex-1 and label.modulate.a >= val:
			maxIndex = min(maxIndex+1, labelArr.size()) # next index
	pass
