# Notas

## Ayuda integrada en el editor
Menú Help  
- Search (`F1`) - Lista de clases, explorar todos los nodos, buscar tema específico

`Node` es uno de los tipos esenciales (hay varios tipos esenciales).  

Hover mouse to get description.  

`Ctrl+A` para agregar nodo a una escena.  

DESCONTINUADO/OBSOLETO `F4` abre ventana Search. Puedes buscar clases y los métodos de esas clases (la info que aparece en Script Editor).  

En editor de código, clic en icono 4 flechas modo sin distracciones.  

`Ctrl+Shift+click` para abrir ayuda dentro del editor de código.  

## Introducción paso a paso
Project Manager - Primera ventana que aparece  
Tiene 2 pestañas: Local Projects (antes Project list) y Asset Library Projects (antes Templates) para descargar ejemplos.  
Para comenzar clic en New Project o en Import.  

Al crear o abrir un proyecto aparece el editor (por defecto en 3D).  
(arriba, centrado) Diferentes vistas 2D, 3D, Script, AssetLib (Cambiar con `Ctrl+` `F1`, `F2`, `F3`).  
Toolbar cambia en cada vista.  

Docks: FileSystem, Scene, Inspector, Import, Node.  

Bottom panel: Output, Debugger, Audio, Animation.  

¿Rueda que gira cuando se redibuja la interfaz? Se ha eliminado.  

En editor de escenas, teclas QWER cambian a modos Select, Move, Rotate y Ruler.  
En la misma barra hay icono para hacer children not selectable.  

## Nodos!
Bloques de construcción con atributos:
- nombre
- prop editables
- puede recibir callback para procesar en cada frame
- extensible
- agregar a otros nodos (children)

## Escenas!
Grupo de nodos organizados jerárquicamente  
- tiene un nodo raíz  
- se puede guardar en disco y cargar  
- se puede instanciar  

`F5` para ejecutar juego  
`F6` para correr escena actual  
(`F7` pausar, `F8` detener)

Una escena solo puede correr si está guardada.  
Se debe definir una escena inicial/principal.  
`Project / P Settings / Application / Run / Main Scene`  
Extensión .tscn (text scene)  

El dock Scene tiene un botón para agregar nodo y un botón para instanciar escena.  
(`Ctrl+D` duplicar elementos de escena)  

Clic derecho en nodo > Guardar como escena.  
Escenas heredadas: Menú Scene > New Inherited Scene ...  

En Inspector está el botón Manage object properties (icono desarmador y llave). Tiene la opción Make sub-resources unique (¿sirve para cambiar propiedades sin afectar a otras escenas?).  

En Godot no se usan ids de instancias, en su lugar se usan rutas dentro del árbol de la escena.  

Al crear una escena, los nodos se crean de arriba a abajo (recuerda `_ready()` es como Room Start).  

## Lenguajes
GDScript y VisualScript son los principales.  
C# y C++ necesitan IDE separado ??  

GDScript
- simple, parece Python
- carga y compila rápido
- integración con editor, auto-completado
- muchos tipos de vectores
- soporta multi-hilo de forma eficiente
- no usa recolector de basura
- dinámico, se puede combinar con otros lenguajes (c++, GDNative)
- clic derecho "Attach Script"

VisualScript
- existe desde 3.0
- bloques y conexiones

.NET/C#
- popular
- Microsoft

GDNative/C++
- scripting en C++
- optimizar partes del código

## Señales!
Se emiten con diferentes acciones, se pueden conectar a funciones de cualquier script y se pueden crear señales propias.
1º conectar, 2º definir la función  
A través GUI: Dock Node -> Signals -> Connect -> Create connection  
A través de código `_on_[EmitterNode]_[SignalName]()`  

## GDScript intro
Función más utilizada `Node.get_node()`  
Los nodos se referencían por nombre, no por tipo. ¡Cuidado al cambiar nombres!  

Varias acciones en Godot son lanzadas por callbacks (= vitual functions)  

Es necesario procesar cosas en cada frame  
`Node._process(delta)`  
Idle process. Es como evento Step. Se puede activar y desctivar con `Node.set_process()`. Se ejecuta cada vez que se dibuja un frame.  
El parámetro delta guarda el tiempo transcurrido en segundos.  

`_physics_process()`  
Physics. Debe usarse antes del phy step. Es como evento Step. Ocurre a intervalos fijos. 60 FPS por defecto (cambiar en Project Settings / Physics / Common / Phy FPS).  

Primero `_physics_process()`, después `Node._process(delta)` ¿cómo?  

Funciones re-definibles (virtuales)  
`_enter_tree()` similar a evento Room Start sin hijos  
`_ready()` es cono evento Create más parecida a Room Start  
`_init()` es como constructor  
`_exit_tree()` parecida a ev Destroy  
`_process(delta)` como Step pero irregular  
`_physics_process()` más parecida a Step  

`Node.new()` crea nuevo nodo flotante  
`add_child()` agrega hijo  
`Scn.instance()` Crea instancia de una escena  
`Nodo.free()` remueve nodo  
`Node.queue_free()` forma más segura, borra cuando no emite señales  

`scn = load("res://...")` carga al ejecutar script  
`scn = preload("res://...")` carga en parse time  
devuelven PackedScene  

Convenciones de nombres  
Clases (nodos) - PascalClase  
Vars y funcs - snake_case  
Const - ALL_CAPS

`export (type) var var_name` para poner vars en editor ??  

`randomize()` igual que en GML  
Nodo Timer es como alarmas de GameMaker  
Nodo Path2D es como paths de GameMaker  
Canvas Layer para ordenar dibujado  
Class Control para UIs  

## Grupos!
x  
La clase SceneTree tiene varios métodos útiles.  

## Definir controles / Entradas
2 formas:
- Project Settings > pestaña Input Map - Se ùeden asignar varios botones/teclas por entrada. Se usan las unciones `Input.is_action_pressed("...")`, `just_pressed`, `just_released`
- Función `Inùt.is_key_pressed(KEY_*)` - no hay just_pressed, ni just_released

## Sonido / Audio !
Archivos comunes wav y ogg.  
Nodo AudioStreamPlayer solo carga archivo de sonido.  

Se puede crear un número ilimitado de bus (a veces llamado canal) y aplicar efectos a cada bus.
Un bus es una referencia con nombre.  

Escala decibeles - No se puede representar volumen 0. 0 dB es el máximo volumen sin recorte.
Cada -3 dB el volumen se reduce a la mitad.  

Todos los buses se mezclan en Master. El ruteo se hace de derecha a izquierda.  

Los audio buses pueden contener efectos aplicados en orden. Las propiedades de los efectos se pueden cambiar en inspector.  

AudioStream - objeto abstracto que emite sonido, normalmente un archivo de audio (wav, ogg).
En Import se pueden hacer ajustees.  

AudioStreamPlayer2D - posicional 2D (panning). Area 2D puede cambiar buses.  

AudioStreamPlayer3D - posicional 3D. Puede reproducir stereo 5.1 o 7.1. Area puede cambiar buses. Efecto Doppler.  

Métodos de los Player:  
- play()
- seek()
- stop()

## Partículas
El nodo Particles2D tiene muchas opciones (algunas similares a los sistemas de partículas de GM). Usa material y textura.  

## GUI!
Los nodos de la clase Control se pueden anidar en muchos niveles y casi no hay efectos en el rendimiento.  

## Tipos de datos
Los Nodos son tipos de datos muy importantes. Otro tipo de dato igual de importante es Resource.  
Contenedores de datos usados comúnmente:  
- Textura
- Script
- Mesh
- Anim
- AudioStream
- Font
- Translation

Resources pueden ser propiedades o variables de un objeto.  
Externo - tiene ruta a un archivo.  
Built-in - no tiene ruta, se puede gaurdar dentro de la escena al borrar la propiedad ruta
Ejemplo: `var res = load("res://img.png")`
`preload` es más óptimo. Solo funciona con string constante.  

PackedScene - escena dentro de un recurso.  

## Singleton  
Es similar a global en GML.  
Se carga antes que otras escenas.  
Hereda de Node, la clase de la que derivan todos los nodos.  
Project > Project Settings > AutoLoad tab > Nombre del nodo y Script  

Una forma de usar como global en GM  
```
var alias = get_node("/root/global")
alias.lv = 1
# es quivalente a 
global.lv = 1
```

## Canvas Layers
Nodos 2D heredan transformación de nodos superiores en árbol.  
Nodos 2D se muestran a través de un viewport `Viewport.canvas_transform`  

Son similares a View y Draw GUI de GM  
Sirven para
- Parallax
- HUD
- Transition FX

Viewport default layer 1  
>0 encima, <0 detás, independiente de orden en el árbol.  

Cada layer tiene transformaciones independientes.  
El orden de dibujo óptimo depende del árbol. No usar demasiadas canvas layers.  
`Node2D.z_index` es similar a depth de GML.  

## Custom Draw
Método `_draw` es similar al evento Draw de GM. Puede preprocesar el código de dibujo.  
Es un método de CanvasItem (virtual).  
Normalmente el método `_draw` solo se ejecuta una vez en cada nodo que hereda de CanvasItem.  
Para redibujar es necesario llamar a `update()` (que también pertenece a CanvasItem).
Se puede llamar en `_process()` que se ejecuta una vez por cada `_draw()` (update también es un método de CanvasItem).  

## Movimiento / Physics
Collision detection and collision response. Nodos y objetos son similares en 2D y 3D.  

Se pueden usar varios nodos 2D  
- Area2D
- KinematicBody2D
- RigidBody2D
Todos necesitan un hijo CollisionShape2D y un Sprite es opcional.  

Vector2 tiene varios métodos útiles  
- normalized()
- rotated(theta)
- length()

Hay disponibles 4 tipos de cuerpos "físicos". El primero hereda de CollisionObject2D.  

Area2D - provee detección e influencia. Detecta empalmes. Define áreas con propiedades físicas especiales.  

Los demás heredan de PhysicsBody2D.  

StaticBody2D - no se mueve con el motor de física. Se puede usar como parte del escenario que no se mueve.  

RigidBody2D - simula física. No se puede controlar directamente, pero se aplican fuerzas.
Puede cambiar a 4 modos: Rigid, Static, Character, Kinematic.  

KinematicBody2D - Colisión pero no simula física. Se puede mover con código.  

Un objeto puede contener varios Shape2D. Por lo menos debe tener uno para detectar colisión (CollisionShape2D o CollisionPolygon2D).  

`_physics_process()` callback para acceder a propiedades físicas. Se llama antes de cada paso de física (por defecto a 60 fps).  

El modo Character es similar a Rigid, pero no puede rotar!  
Para modificar prop físicas directamente a un RigidBody, se debe usar el callback `integrate_forces()`
en lugar de `_physics_process()` para tener aceeso a Physics2DDirectBodyState.  
En estado Sleep no se ejecuta `integrate_forces(state)`.  
Propiedades interesantes: can_sleep, contacts_reported, contact_monitor (usando señales). Método get_contact_count().  

Métodos de KinematicBody
- move_and_collide() - devuelve objeto KinematicCollision2D con propiedades: position (lugar de colisión), normal (vector normal de colisión)
- Vector2.bounce(Vec2) - rebota usando Vec2 como normal
- move_and_slide(...) - no necesita delta en los parámetros

Node2D  
- look_at(Vec2) rotar nodo mirando hacia un punto
- rotation  

### Kinematic Character (2D)
Havok promueve dynamic character controller, PhysX promueve Kinematic.  

Controlador dinámico - Rigid body con tensor de inercia infinito. No puede rotar. Primero coisiones, luego resuelve.
Interacción total, pero impredecible. Soluciones pueden tardar más de un frame (pequeños desplazamientos visibles).  

Controlador cinemático - Intenta moverse a posición sin colisión. Control y mov. más predecible. Sin embargo,
no puede interactuar directamente con objs del entorno.

### SoftBody
Nodo usado para simulación de cuerpos deformables.  

### Ragdoll system
Soporte desde 3.1. Ejemplos con Platformer 3D Demo.  
Nodo PhysicsBone - se crea fácilmente a partir de un nodo Skeleton. En el editor de escena, clic Skeleton > Create physical skeleton  
No todos los huesos generados son necesarios.  
Se pueden cambiar los volúmenes de colisión.  

## Intro to 2D Animation
Nodo AnimationPlayer - Se puede "animar" cualquier variable del Inspector y de Scripts. También llamar funciones.  

Animation Panel aparece en el fondo de la pantalla: Controls, Tracks, Timeline, Keyframe settings, Track and timeline controls  

Se basa en fotogramas clave (keyframes)(diamantes blancos y azules).  
Cada línea es una pista de animación (animation track). Su nombre es una ruta a la propiedad
(Ej. "AnimationPlayer/Sprite:position")

Shift+D reproducir animación desde el principio.  
loc, rot, scl - location (position), rotation, scale  

Al cambiar nombres de nodos, las pistas se actualizan automáticamente.  
En loop, por defecto, el primer frame es el último.  

Update mode ( o update rate)  
- Continous - actualiza cada frame
- Discrete - solo en keyframes
- Trigger - en llaves o triggers (¿cómo funciona?)
- Capture - ??

Interpolation mode
- Nearest - parece lo mismo que update mode discrete
- Linear - simple linear
- Cubic - mov lento cerca de keyframes

Loop wrap mode
- Clamp - al final resetea valores
- Wrap - al final primera llave como sig. llave

### Layers and Masks ??
Cada CollisionObject2D tiene 20 capas y 20 máscaras.  
- Capa - es donde aparece el objeto
- Máscara . es donde puede colisionar
Los objetos pueden tener ninguna capa ni máscara seleccionada.  

## Luces y sombras 2D
Básicamente se necesitan 2 tipos de nodos:  
- Light2D - usa una textura para sumar a la escena
- LightOccluder2D - usa un polígono

CanvasModulate se puede usar para oscurecer una escena.  

## Ray-casting
Godot almacena la info de bajo nivel en servidores. La escena es frontend, Ray-casting es una tarea de bajo nivel.  

Espacio - guarda toda la info de física y colisiones.
Se puede obtener con `CanvasItem.get_world_2d().space` o con `Spatial.get_world().space`.  
Devuelven un RID (resource's unique id)(número entero) que se puede usar en Physics2DServer o PysicsServer.  

Código base
```py
func _physics_process(delta):
	var space_rid = get_world_2d().space
	var space_state = Physics2DServer.space_get_direct_state(space_rid)

# o equivalente

func _process(delta):
	var space_state = get_world_2d().direct_space_state
```

Ray-cast query
Un poco similar a collision_line() de GML
```py
var space_state = get_world_2d().direct_space_state
var result = space_state.intersect_ray(from, to, ...)
```
Devuelve un diccionario  
position: Vec2  
normal: Vec2  
collider: obj or null  
collider_id: objID  
rid: RID  
shape: int  
metadata: Variant()  

## Otros
¿Existe editor de spr integrado?  

Para texturas sin filtro linear  
Seleccionar en File dock, quitar filtro en Import dock.  

Area2D - como player  
AnimSprite - como spr  
Coll shape - como mask  

`$` es similar a `get_node()`  

Fonts: cargar .ttf (dynamic) o bitmap font  

¿Cómo conectar señales de diferentes escenas?  

Sprite puede servir como background  

project.godot define la raíz del proyecto y describe el proyecto. Formato win ini.  

Directorios sandbox res:// user://  
