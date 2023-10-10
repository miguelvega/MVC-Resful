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

Abrimos otra terminal y colocamos el comando `  curl http://localhost:4567/todos`
![Captura de pantalla de 2023-10-09 19-46-02](https://github.com/miguelvega/MVC-Resful/assets/124398378/c169cae7-d03f-4717-9e2f-858764a919d4)
Se obtiene una salida en formato JSON ya que la ruta /todos de la aplicación Sinatra está configurada para responder en formato JSON cuando se hace una solicitud GET a esa ruta.
![Captura de pantalla de 2023-10-09 19-47-12](https://github.com/miguelvega/MVC-Resful/assets/124398378/997d23ff-f951-41e3-a5f7-1508727360fa)

Con lo cual se puede observar nuevos registros de solicitudes realizadas.


## Parte 1

Lo primero que vamos a hacer es crear un modelo. A diferencia de Rails, Sinatra no tiene MVC integrado, así que vamos a piratear el nuestro. Usaremos `ActiveRecord` sobre una base de datos SQLite. En esta aplicación, ¿cuál será nuestro modelo y qué operaciones CRUD le aplicaremos?

- index: Esta operación mostrará una lista de todas las tareas por hacer existentes en la base de datos, se utiliza la ruta '/todos' para acceder a esta operación
```
get '/todos' do
  content_type :json
  Todo.all.to_json
end
```

El codigo nos muestra que cuando alguien acceda a la ruta '/todos', este bloque de código se ejecuta y devuelve una respuesta que contiene todas las tareas por hacer almacenadas en la base de datos en formato JSON.

![Captura de pantalla de 2023-10-09 22-57-54](https://github.com/miguelvega/MVC-Resful/assets/124398378/a33f8577-1db3-46bc-98be-80a54ce831ca)

- create: Esta operación permitirá agregar nuevas tareas por hacer a la base de datos.
```
post '/todos' do
  content_type :json
  request_body = JSON.parse(request.body.read)
  description = request_body['description']

  if description && !description.empty?
    new_todo = Todo.create(description: description)
    { msg: "create success", todo_id: new_todo.id }.to_json
  else
    { msg: "error: description can't be blank" }.to_json
  end
end

```
Este codigo, nos muestra que cuando alguien envía una solicitud POST a la ruta '/todos' con una descripción válida, este bloque de código crea una nueva tarea por hacer en la base de datos y devuelve un mensaje de éxito junto con el id de la nueva tarea en formato JSON. Ahora bien, si la descripción está vacía o no se proporciona, se devuelve un mensaje de error en formato JSON.

![Captura de pantalla de 2023-10-10 00-50-13](https://github.com/miguelvega/MVC-Resful/assets/124398378/4d799045-0414-40d5-a4fa-4ddf448caf29)

![Captura de pantalla de 2023-10-10 00-51-15](https://github.com/miguelvega/MVC-Resful/assets/124398378/944ed328-bdb9-4203-9afd-902fd7e0d4ad)

- read: Esta operación mostrará los detalles de una tarea específica, identificada por su ID.
```
get '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])
  if todo
    return {description: todo.description}.to_json
  else
    return {msg: "error: specified todo not found"}.to_json
  end
end

```

Este codigo, nos muestra que cuando alguien envía una solicitud GET a la ruta '/todos/:id' con un ID válido, este bloque de código busca la tarea correspondiente en la base de datos y devuelve los detalles de esa tarea en formato JSON. Si no se encuentra la tarea, se devuelve un mensaje de error en formato JSON.

![Captura de pantalla de 2023-10-09 22-56-13](https://github.com/miguelvega/MVC-Resful/assets/124398378/3c001c4a-ee9c-401f-a330-78342adabf0f)



![Captura de pantalla de 2023-10-09 23-21-28](https://github.com/miguelvega/MVC-Resful/assets/124398378/df4280b7-5a91-4793-a38c-7be42ee95542)

- update: Esta operación permitirá modificar una tarea existente.
```
put '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])

  if todo
    request_body = JSON.parse(request.body.read)
    new_description = request_body['description']

    if new_description && !new_description.empty?
      todo.update(description: new_description)
      { msg: "update success" }.to_json
    else
      { msg: "error: description can't be blank" }.to_json
    end
  else
    { msg: "error: specified todo not found" }.to_json
  end
end

```


![Captura de pantalla de 2023-10-10 01-05-05](https://github.com/miguelvega/MVC-Resful/assets/124398378/6747217d-cdda-49ce-8ee5-caebc0b5bd6c)

![Captura de pantalla de 2023-10-10 01-05-30](https://github.com/miguelvega/MVC-Resful/assets/124398378/d8ca2c44-7e15-4506-b135-25d1a5add74f)

- destroy: Esta operación eliminará una tarea existente de la base de datos.

```
delete '/todos/:id' do
  content_type :json
  todo = Todo.find_by_id(params[:id])

  if todo
    todo.destroy
    { msg: "delete success" }.to_json
  else
    { msg: "error: specified todo not found" }.to_json
  end
end

```


![Captura de pantalla de 2023-10-10 01-13-32](https://github.com/miguelvega/MVC-Resful/assets/124398378/cd7eff77-a68c-4dec-a6af-a66702f152cb)

![Captura de pantalla de 2023-10-10 01-13-50](https://github.com/miguelvega/MVC-Resful/assets/124398378/229a08f7-0892-4a3c-a94c-1b06cc58c0c6)

## Parte 2

## Parte 3


