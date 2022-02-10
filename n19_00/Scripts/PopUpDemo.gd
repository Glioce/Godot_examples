extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$FileDialog.popup()
	$FileDialog.popup_centered()
	#$FileDialog.show()
	#$FileDialog.show_modal()
	
	$ConfirmationDialog.popup()
	$ConfirmationDialog.get_cancel().connect("pressed", self, "_on_Cancel")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_FileDialog_file_selected(path):
	print("File selected " + path)
	#pass # Replace with function body.


func _on_ConfirmationDialog_confirmed():
	print("Yoy confirmed")
	#pass # Replace with function body.

func _on_Cancel():
	print("You cancelled")
