/** 
* Esta carpeta se encarga de mantener las querys como crear nuestras tablas, 
* es una buena practica escribir las querys, schemas y las tablas antes de 
* correrlas en la terminal
*/

/**
* Creamos la base de datos del proyecto con la siguiente linea
*/

CREATE DATABASE todo_app;

/**
* Accedemos a la tabla creada con la siguiente query
*/

USE todo_app;

/**
* Creamos nuestra primer tabla (Users)
*/

-- DELETE FROM todo_app

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255)
);

/**
* Creamos la segunda tabla donde guardaremos las tareas (todos)
*/

CREATE TABLE todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  completed BOOLEAN DEFAULT false,
  user_id INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE 
);
/**
* Tabla de tareas compartidas entre usuarios (shared_todo)
*/

CREATE TABLE shared_todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  todo_id INT,
  user_id INT,
  shared_with_id INT,
  FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);

/**
* Insertamos usuarios dentro de la tabla users
*/

INSERT INTO users (name, email, password) VALUES ('Santi', 'user1@example.com', 'password1');
INSERT INTO users (name, email, password) VALUES ('Santiago', 'user2@example.com', 'password2');
/**
* Para ver los usuarios agreados o existentes en la tabla users ejecutar:
*/
-- SELECT * FROM users

/** 
* Para borra usuarios en la tabla users
*/
-- DELETE FROM users WHERE name = 'Santi';

/**
* Para seleccionar un usuario segun su id
*/
-- SELECT * FROM users WHERE id = 2;

/**
* Agregamos tareas como ejemplo a la base de datos
* Estos todos van a ser del usuario 1 (Santi)
*/

INSERT INTO todos (title, user_id) 
VALUES 
("🏃‍♀️ Salir a correr temprano", 1),
("💻 Terminar aplicacion de chat 💼", 1),
("🛒 Hacer las compras 🛍️", 1),
("📚 Terminar modulo de Javascript", 1),
("🍲 Cocinar para mañana ", 1),
("📖 Empezar curso php ", 1),
("🧹 Limpiar el departamento 🧼", 1),
("🛌 Intertar domir 6hs ", 1);

/**
* Seleccion de todos segun el id del usuario
*/

-- SELECT * FROM todos WHERE user_id = 1;

/**
* Compartimos los todos entre los usuarios
*/
INSERT INTO shared_todos (todo_id, user_id, shared_with_id)
VALUES (1, 1, 2);

/**
* Seleccionamos todos los todos ccompartidos por el usuario aparte de los todos creados por este usuario
*/

SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = 2 OR shared_todos.shared_with_id = 2;