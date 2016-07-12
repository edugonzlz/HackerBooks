# HackerBooks
**Ejercicio práctico para el módulo de fundamentos de iOS del Master Mobile de KeepCoding.** 

Realizado con Swift. No implementa aún gestion de colas en segundo plano y bloquea la app al descargar contenido.

HackerBooks es un aplicación para descargar y leer libros relacionados con la programación.

- Se descarga un archivo JSON de internet con la información relativa a los libros.
- Visualizamos una lista de libros en forma de tabla, pudiendo ordenarlos por orden alfabético de título o por temáticas (tags) alfabeticamente.
- Es posible seleccionar cada libro como favorito mediante un botón. La lista de favoritos aparecera cuando ordenemos la tabla por temáticas. La condición de favorito se guarda con el sistema NSUserDefaults.
- Las imagenes de cada libro se descargan según las solicita la tabla de libros y se guardan en la carpeta Documents del Sandbox.
- Los archivos pdf de cada libro, debido a su peso, se descargan cuando se desean leer pulsando el botón y se guardan en la cache para poder ser eliminados por el sistema.


#####NOTAS:

- El enunciado de el ejercicio solicita: "Al arrancar comprobar si es la primera vez y descargar JSON"
	- No lo hago asi, porque puede ser que no tuvieramos conexion la primera vez. En este caso se comprueba si se tiene el Json en local y si no es así se descarga.

### Preguntas a responder

- isKindOfClass, en que modos podemos trabajar? is, as?
	- ???
- Imagen de portada y pdf, ¿donde guardarlos?
	- las imagenes de portada las guardo en la carpeta Documents para que esten siempre accesibles
	- el pdf es un documento de mayor peso y de acceso menos habitual, asi que lo guardo en el directorio Cached, para poder ser eliminados si el sistema lo solicita
- Guardar favoritos, formas, elección y justificacion
	- Podríamos usar NSUserDefaults, NSCoding o la carpeta Documents
	- He elegido NSUserDefaults porque vamos a almacenar datos muy pequeños
	- En primer lugar pense guardarlo como un BoolForKey, pero en el caso de que necesitemos guardar otro dato para cada libro en el futuro estaremos limitados, asi que decidí guardar mediante un ObjectForKey un diccionario donde se almacena el titulo del libro que es favorito con su valor booleano true, para indicar que es un favorito
- ¿Como enviar info de cambio de favorito de book a la LibraryTable?, formas, elección y justificacion
	- Podriamos enviarlo mediante un protocolo delegado o mediante notificaciones
	- Me ha parecido mas práctico elegir notificaciones, porque el delegado nos limita en un futuro por solo poder tener uno. Tenemos mas flexibilidad con la notificación.
- reloadData, ¿es una aberracion para el rendimiento? ¿hay forma alternativa? ¿cuando merece la pena hacerlo?
	 - no se responder a esta pregunta
- En un splitViewController, como informar a la vista de detalle de un cambio en la vista de tabla
	- Mediante una notificación o con un protocolo delegado si no lo tenemos ya asignado
- ¿Que funcionalidades añadirias antes de subir a la appStore? ¿Que otras versiones similares se te ocurren? ¿y como monetizarlas?
	- funcionalidades: poder ajustar el brillo facilmente desde la app, poder guardar o marcar alguna pagina en concreto, poder añadir notas para un libro, 
	- versiones: casi cualquier aplicacion usa la funcionalidades que hemos implementado, se me ocurren muchas opciones!
	- monetización: podriamos añadir publicidad, hacer la app de pago(habría que mejorarla mucho para que alguien pague por ella), o podemos ofrecer una opcion de pago con funciones extras, como poder añadir libros propios, o las funcionalidades antes mencionadas, como poder crear una seccion de favoritos o notas
