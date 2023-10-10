# Demostración de MVC, rutas RESTful y CRUD con Sinatra

En primera instancia instalamos todas las gemas (bibliotecas o paquetes de software) especificadas en el archivo Gemfile de nuestro proyecto
con el comando `bundle install`
![Captura de pantalla de 2023-10-09 20-41-19](https://github.com/miguelvega/MVC-Resful/assets/124398378/61e1ec1c-eaf7-4ca4-a267-7073a8e820d1)

Ejecutamos `bundle exec ruby template.rb` para asegurar que el script `template.rb` se ejecute con las gemas y la configuración específicas del proyecto, lo que ayuda a evitar problemas de dependencias y a garantizar la consistencia en el entorno de desarrollo de nuestra  aplicación Sinatra.
![Captura de pantalla de 2023-10-09 19-45-07](https://github.com/miguelvega/MVC-Resful/assets/124398378/fb538cb9-9f06-4998-b6e7-0755edc35e84)
De salida, podemos observar que se ha ejecutado una migración para crear una tabla llamada "todos" en la base de datos. La tabla tiene una columna llamada "id" con tipo de dato "integer". Ademas, muestra que la aplicación Sinatra se ha iniciado con éxito en el puerto 4567, y está lista para manejar las solicitudes web entrantes.

Luego, ingresamos el siguiente enlace en el navegador `  http://localhost:4567/todos` y se oberva lo siguiente: 
![Captura de pantalla de 2023-10-09 19-45-40](https://github.com/miguelvega/MVC-Resful/assets/124398378/b9a24255-e31c-429b-a1f2-d7481666a518)

La aplicación está respondiendo con una lista de tareas almacenadas en la base de datos cuando se accede a la ruta /todos. Cada tarea en la lista tiene un identificador único (id) y una descripción (description).

Nos dirigimos a la terminal para ver las nuevas solicitudes realizadas.
![Captura de pantalla de 2023-10-09 19-45-46](https://github.com/miguelvega/MVC-Resful/assets/124398378/b15dbb39-5ca0-4ef9-ad4b-716577fb5f06)
Como se puede apreciar se realizó una solicitud GET a la ruta /todos en la aplicación Sinatra, y la solicitud se procesó con éxito.
![Captura de pantalla de 2023-10-09 19-46-02](https://github.com/miguelvega/MVC-Resful/assets/124398378/c169cae7-d03f-4717-9e2f-858764a919d4)
![Captura de pantalla de 2023-10-09 19-47-12](https://github.com/miguelvega/MVC-Resful/assets/124398378/997d23ff-f951-41e3-a5f7-1508727360fa)


## Parte 1

## Parte 2

## Parte 3


