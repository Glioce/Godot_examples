extends Node2D

var tween = Tween.new()
var random = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(tween)
	add_child(tween)
	tween.connect("tween_all_completed", self, "move")
	move()

func _draw():
	draw_rect(Rect2(0, 0, 512, 512), Color.white)
	
	#material.blend_mode = BLEND_MODE_SUB
	#material.set_blend_mode(BLEND_MODE_MIX)
	#blend_mode = BLEND_MODE_MIX
	
	draw_rect(Rect2(100, 100, 100, 100), Color.red, true)
	
	draw_set_transform(Vector2(300, 150), 0, Vector2(0.5, 1))
	draw_circle(Vector2(0, 0), 75, Color.azure)
	
func move():
	print(position)
	var x = random.randf_range(-50, 50)
	var y = random.randf_range(-50, 50)
	tween.interpolate_property(self, "position", null, Vector2(x, y),
		1.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
