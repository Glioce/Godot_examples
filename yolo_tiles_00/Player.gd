extends Sprite

# class member variables
var g   =  0.4 #gravedad
var vs  = -7.0 #velocidad de salto
var vx  =  0.0 #velocidad horizontal
var vy  =  0.0 #velocidad vertical
var vym = 16.0 #velocidad vertical maxima
var vxm = 16/4 #velocidad horizontal maxima
var dx  =    0 #diferencia horizontal
var i
var j
onready var map = get_node("../TileMap")

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	$Label.text = str(1/delta)
	
	# entrada
	if Input.is_action_just_pressed("ui_right"): vx = vxm
	if Input.is_action_just_pressed("ui_left"): vx = -vxm
	
	# if place snapped
	if (fmod(position.x, 16) == 0):
		if (vx > 0): # if moving to the right and player is pressing right
			if Input.is_action_pressed("ui_right"): vx = vxm # keep moving
			else: vx = 0 # stop
		if (vx < 0): # if moving to the  left and player is pressing left
			if Input.is_action_pressed("ui_left"): vx = -vxm # keep moving
			else: vx = 0 # stop
	
	# change direction
	if Input.is_action_just_released("ui_right"):
		if Input.is_action_pressed("ui_left"):
			vx = -vxm
	if Input.is_action_just_released("ui_left"):
		if Input.is_action_pressed("ui_right"):
			vx = vxm
		
	position.x += vx #desplazar
	dx = 0 #anular diferencia
	
	# avanzar a la izquierda
	if (vx < 0):
		i = floor(position.x / 32) #celda a la izquierda
		j = position.y / 32 #ordenadas relativas a la matriz
		
		# si hay un bloque a la izquierda
		if (map.get_cell(i, floor(j)) != -1) or (map.get_cell(i, ceil(j)) != -1):
			var xx = (i + 1) * 32 # borde derecho del bloque donde puede colisionar
			dx = position.x - xx # distancia de traslape
			position.x = xx # colocar en posición sin traslape
	
	# avanzar a la izquierda
	if (vx > 0):
		i = ceil(position.x / 32) # celda a la derecha
		j = position.y / 32 # ordenada relativa a la matriz
		
		# si hay un bloque a la derecha
		if (map.get_cell(i, floor(j)) != -1) or (map.get_cell(i, ceil(j)) != -1):
			var xx = (i - 1) * 32 # borde izquierdo
			dx = position.x - xx # distancia de traslape
			position.x = xx # colocar en posición sin traslape
	
	# Movimiento vertical
	vy += g # efecto de la gravedad
	if Input.is_action_just_pressed("ui_select"): vy = vs #saltar
	if (vy > vym): vy = vym # limitar velocidad de caída
	#position.y += vy
	
	if (vy < 0): # avanzar hacia arriba
		if (dx != 0): # si hubo traslape en el mov horizontal
			j = floor(position.y / 32) # siguiente celda arriba
			var f = j*32 - position.y # cualto falta para alinearse con esa celda
			
			if (vy <= f): # si la velocidad vertical alcanza para alinearse (o pasarse)
				if (map.get_cell(i, j) == -1): # y no hay bloque
					position.x += dx # puede avanzar horizontalmente
		
		position.y += vy # desplazar hacia arriba
		i = position.x / 32 # celda en posición actual
		j = floor(position.y / 32)
		
		# si colisiona con un bloque
		if (map.get_cell(floor(i), j) != -1) or (map.get_cell(ceil(i), j) != -1):
			position.y = (j + 1) * 32 # bajar un poco para salir  de la colisión
			vy = 0 # parar
	
	if (vy > 0): # avanzar hacia abajo
		if (dx != 0): # si hubo traslape en el mov horizontal
			j = ceil(position.y / 32) # siguiente celda abajo
			var f = j*32 - position.y # cualto falta para alinearse con esa celda
			
			if (vy >= f): # si la velocidad vertical alcanza para alinearse (o pasarse)
				if (map.get_cell(i, j) == -1): # y no hay bloque
					position.x += dx # puede avanzar horizontalmente
		
		position.y += vy # desplazar hacia abajo
		i = position.x / 32 # celda en posición actual
		j = ceil(position.y / 32)
		
		# si colisiona con un bloque
		if (map.get_cell(floor(i), j) != -1) or (map.get_cell(ceil(i), j) != -1):
			position.y = (j - 1) * 32 # subir un poco para salir  de la colisión
			vy = 0 # parar

	# "envolver" escenario
	if (position.x > 1024): position.x -= 1024+32
	if (position.x < -32): position.x += 1024+32
	if (position.y > 576): position.y -= 576+32
	if (position.y < -32): position.y += 576+32
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() # cerrar juego
		
	pass
