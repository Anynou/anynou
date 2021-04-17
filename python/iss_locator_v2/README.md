# ISS locator v2

## Descripción
_Aplicación que muestra la localización de la estación espacial internacional._
_Para lanzarla, simplemente ejecutamos con python el fichero app.py. En la ejecución nos levantará
un servidor flask y podremos acceder en http://localhost_
_También podemos crear una imagen de docker con el Dockerfile, para cualquier plataforma._

## Actualización v2
_Se ha añadido una pequeña base de datos sqlite que guarda 5 valores_
_En el inicio guarda los primeros 15 registros, antes de iniciar el servidor flask._
_También se ha incluido un daemon que se encarga de ir actualizando los registros de la base de datos._
