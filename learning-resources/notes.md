# Notas

## Entender la ayuda de Godot (integrada en el editor)
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

## Sonido!
Archivos comunes wav y ogg.  
Nodo AudioStreamPlayer solo carga archivo de sonido.  

## Partículas
El nodo Particles2D tiene muchas opciones.  

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
