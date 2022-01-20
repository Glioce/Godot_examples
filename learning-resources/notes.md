# Notas

## Entender la ayuda de Godot (integrada en el editor)
Menú Help  
- Search (`F1`) - Lista de clases, explorar todos los nodos, buscar tema específico

`Node` es uno de los tipos esenciales (hay varios tipos esenciales).  

Hover mouse to get description.  

`Ctrl+A` para agregar nodo a una escena.  

DESCONTINUADO/OBSOLETO `F4` abre ventana Search. Puedes buscar clases y los métodos de esas clases (la info que aparece en Script Editor).  

En editor de código, clic en icono 4 flechas modo sin distracciones.  

OBSOLETO? `Ctrl+click` para abrir ayuda dentro del editor de código.  

## Introducción paso a paso
Project Manager - Primera ventana que aparece  
Tiene 2 pestañas: Local Projects (antes Project list) y Asset Library Projects (antes Templates) para descargar ejemplos.  
Para comenzar clic en New Project o en Import.  

Al crear o abrir un proyecto aparece el editor (por defecto en 3D).  
(arriba, centrado) Diferentes vistas 2D, 3D, Script, AssetLib (Cambiar con `Ctrl+` `F1`, `F2`, `F3`).  
Toolbar cambia en cada vista.  

Docks: FileSystem, Scene, Inspector, Import, Node.  

Bottom panel: Output, Debugger, Audio, Animation.  

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

VisualScript
- existe desde 3.0
- bloques y conexiones

.NET/C#
- popular
- Microsoft

GDNative/C++
- scripting en C++
- optimizar partes del código

