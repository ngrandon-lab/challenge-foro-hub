# 🗨️ ForoHub API

API REST desarrollada con **Spring Boot 3** 
Permite gestionar tópicos de un foro: crear, listar, consultar, actualizar y eliminar, con autenticación mediante tokens JWT.

---

## 📑 Tabla de contenidos

- [Descripción](#-descripción)
- [Tecnologías](#-tecnologías)
- [Estructura del proyecto](#-estructura-del-proyecto)
- [Requisitos previos](#-requisitos-previos)
- [Configuración e instalación](#-configuración-e-instalación)
- [Migraciones de base de datos](#-migraciones-de-base-de-datos)
- [Endpoints disponibles](#-endpoints-disponibles)
- [Guía de pruebas con Insomnia](#-guía-de-pruebas-con-insomnia)
- [Reglas de negocio](#-reglas-de-negocio)
- [Datos de prueba](#-datos-de-prueba)
- [Códigos de respuesta](#-códigos-de-respuesta)

---

## 📖 Descripción

ForoHub es una API que replica el backend de un foro de preguntas y respuestas como el de Alura. Los usuarios autenticados pueden interactuar con **tópicos**, que representan preguntas o discusiones asociadas a un curso y un autor.

Las funcionalidades principales son:

- Registro de nuevos tópicos
- Listado paginado y ordenado por fecha
- Consulta de detalle por ID
- Actualización de título, mensaje y estado
- Eliminación de tópicos
- Autenticación stateless con JWT

---

## 🛠️ Tecnologías

| Tecnología              | Versión   |
|-------------------------|-----------|
| Java                    | 17        |
| Spring Boot             | 3.3.10    |
| Spring Security         | 6.x       |
| Spring Data JPA         | 3.x       |
| Flyway                  | 10.x      |
| MySQL                   | 8.x       |
| Auth0 Java JWT          | 4.5.0     |
| Lombok                  | Latest    |
| Maven                   | 3.x       |

---

## 📁 Estructura del proyecto

```
src/main/java/com/forohub/api/
├── ForoHubApplication.java
├── controller/
│   ├── AutenticacionController.java   # POST /login
│   └── TopicoController.java          # CRUD /topicos
├── domain/
│   ├── topico/
│   │   ├── Topico.java                # Entidad JPA
│   │   ├── StatusTopico.java          # Enum: ABIERTO, CERRADO, RESUELTO, NO_RESPONDIDO
│   │   ├── TopicoRepository.java
│   │   ├── DatosRegistroTopico.java   # DTO entrada POST
│   │   ├── DatosActualizacionTopico.java # DTO entrada PUT
│   │   ├── DatosListaTopico.java      # DTO salida GET lista
│   │   └── DatosDetalleTopico.java    # DTO salida GET detalle
│   ├── curso/
│   │   ├── Curso.java
│   │   ├── Categoria.java             # Enum: BACKEND, FRONTEND, DEVOPS...
│   │   └── CursoRepository.java
│   └── usuario/
│       ├── Usuario.java               # Implementa UserDetails
│       ├── UsuarioRepository.java
│       ├── DatosAutenticacion.java
│       └── AutenticacionService.java  # Implementa UserDetailsService
└── infra/
    ├── security/
    │   ├── SecurityConfigurations.java
    │   ├── SecurityFilter.java        # Filtro JWT por request
    │   ├── TokenService.java          # Generación y validación JWT
    │   └── DatosTokenJWT.java
    └── exceptions/
        └── GestorDeErrores.java       # Manejo global de errores

src/main/resources/
├── application.properties
└── db/migration/
    ├── V1__create-table-usuarios.sql
    ├── V2__create-table-cursos.sql
    ├── V3__create-table-topicos.sql
    ├── V4__insert-datos-prueba.sql    # Usuario admin + 3 cursos
    └── V5__insert-topicos-ejemplo.sql # 15 tópicos de ejemplo
```

---

## ✅ Requisitos previos

Antes de ejecutar el proyecto asegúrate de tener instalado:

- [Java 17+](https://adoptium.net/)
- [Maven 3+](https://maven.apache.org/)
- [MySQL 8+](https://dev.mysql.com/downloads/)
- [IntelliJ IDEA](https://www.jetbrains.com/idea/) u otro IDE compatible
- [Insomnia](https://insomnia.rest/) para probar los endpoints

---

## ⚙️ Configuración e instalación

### 1. Clona el repositorio

```bash
git clone https://github.com/tu-usuario/forohub.git
cd forohub
```

### 2. Crea la base de datos en MySQL

```sql
CREATE DATABASE forohub_db;
```

### 3. Configura `application.properties`

Edita el archivo `src/main/resources/application.properties` con tus credenciales:

```properties
spring.application.name=forohub

spring.datasource.url=jdbc:mysql://localhost/forohub_db
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.username=root
spring.datasource.password=tu_password

spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

server.error.include-stacktrace=never

api.security.token.secret=${JWT_SECRET:12345678}
```

### 4. Ejecuta la aplicación

```bash
mvn spring-boot:run
```

Flyway ejecutará automáticamente todas las migraciones al iniciar. La API quedará disponible en `http://localhost:8080`.

---

## 🗄️ Migraciones de base de datos

Flyway gestiona el esquema automáticamente en el orden siguiente:

| Versión | Archivo                              | Descripción                          |
|---------|--------------------------------------|--------------------------------------|
| V1      | `create-table-usuarios.sql`          | Tabla `usuarios`                     |
| V2      | `create-table-cursos.sql`            | Tabla `cursos`                       |
| V3      | `create-table-topicos.sql`           | Tabla `topicos` con FK a usuarios y cursos |
| V4      | `insert-datos-prueba.sql`            | Usuario admin + 3 cursos de prueba   |
| V5      | `insert-topicos-ejemplo.sql`         | 15 tópicos de ejemplo con distintos status |

> ⚠️ Si necesitas reiniciar la base de datos desde cero ejecuta en MySQL:
> ```sql
> DROP DATABASE forohub_db;
> CREATE DATABASE forohub_db;
> ```
> Luego reinicia la aplicación y Flyway reconstruirá todo.

---

## 🔌 Endpoints disponibles

| Método   | URL                    | Descripción                        | Auth requerida |
|----------|------------------------|------------------------------------|----------------|
| `POST`   | `/login`               | Obtiene token JWT                  | ❌             |
| `POST`   | `/topicos`             | Crea un nuevo tópico               | ✅             |
| `GET`    | `/topicos`             | Lista tópicos paginados            | ✅             |
| `GET`    | `/topicos/{id}`        | Detalle de un tópico               | ✅             |
| `PUT`    | `/topicos/{id}`        | Actualiza un tópico                | ✅             |
| `DELETE` | `/topicos/{id}`        | Elimina un tópico                  | ✅             |

---

## 🧪 Guía de pruebas con Insomnia

> Puedes importar la colección lista desde el archivo `forohub-insomnia-collection.json` en Insomnia:  
> `File → Import → From File`

---

### ⚠️ Manejo del Token JWT

Todos los endpoints **excepto `/login`** requieren autenticación.  
Después de hacer login, copia el token y agrégalo en el header de cada request:

```
Authorization: Bearer <tu_token_aqui>
```

En Insomnia configura esto en la pestaña **Auth → Bearer Token** de cada request.

---

### 🔐 1. Autenticación — Obtener Token JWT

| Campo  | Valor                         |
|--------|-------------------------------|
| Método | `POST`                        |
| URL    | `http://localhost:8080/login` |

**Body (JSON):**
```json
{
    "login": "admin",
    "contrasena": "123456"
}
```

**Respuesta esperada (200 OK):**
```json
{
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

> ✅ **Copia el valor de `token`** y úsalo en los siguientes requests como Bearer Token.

---

### 📋 2. Tópicos

#### 2.1 Crear un nuevo tópico

| Campo  | Valor                          |
|--------|--------------------------------|
| Método | `POST`                         |
| URL    | `http://localhost:8080/topicos` |
| Auth   | Bearer Token                   |

**Body (JSON):**
```json
{
    "titulo": "¿Cómo usar Spring Security con JWT?",
    "mensaje": "Estoy intentando configurar Spring Security con tokens JWT pero no sé por dónde empezar. ¿Alguna guía?",
    "autorId": 1,
    "cursoId": 1
}
```

**Respuesta esperada (201 Created):**
```json
{
    "id": 16,
    "titulo": "¿Cómo usar Spring Security con JWT?",
    "mensaje": "Estoy intentando configurar Spring Security con tokens JWT pero no sé por dónde empezar. ¿Alguna guía?",
    "fechaCreacion": "2026-03-03T21:00:00",
    "status": "ABIERTO",
    "autor": "admin",
    "curso": "Spring Boot 3"
}
```

> ⚠️ **Regla de negocio:** No se permiten tópicos con el mismo `titulo` y `mensaje`. Si lo intentas, recibirás `400 Bad Request`.

---

#### 2.2 Listar todos los tópicos

| Campo  | Valor                          |
|--------|--------------------------------|
| Método | `GET`                          |
| URL    | `http://localhost:8080/topicos` |
| Auth   | Bearer Token                   |

Los resultados se ordenan por `fechaCreacion` de forma **ascendente** y vienen paginados de **10 en 10**.

**Respuesta esperada (200 OK):**
```json
{
    "content": [
        {
            "id": 1,
            "titulo": "¿Cómo configurar Spring Security con JWT?",
            "mensaje": "Estoy intentando proteger mis endpoints...",
            "fechaCreacion": "2026-01-05T09:00:00",
            "status": "RESUELTO",
            "autor": "admin",
            "curso": "Spring Boot 3"
        }
    ],
    "totalElements": 15,
    "totalPages": 2,
    "size": 10,
    "number": 0
}
```

---

#### 2.3 Listar tópicos con paginación personalizada

| Campo  | Valor                                         |
|--------|-----------------------------------------------|
| Método | `GET`                                         |
| URL    | `http://localhost:8080/topicos?page=0&size=5` |
| Auth   | Bearer Token                                  |

**Query params disponibles:**

| Param  | Descripción               | Ejemplo |
|--------|---------------------------|---------|
| `page` | Número de página (0-based) | `0`     |
| `size` | Resultados por página      | `5`     |

---

#### 2.4 Ver detalle de un tópico específico

| Campo  | Valor                                 |
|--------|---------------------------------------|
| Método | `GET`                                 |
| URL    | `http://localhost:8080/topicos/{id}`  |
| Auth   | Bearer Token                          |

**Ejemplo:** `http://localhost:8080/topicos/1`

**Respuesta esperada (200 OK):**
```json
{
    "id": 1,
    "titulo": "¿Cómo configurar Spring Security con JWT?",
    "mensaje": "Estoy intentando proteger mis endpoints con JWT pero me aparece 403 en todos lados...",
    "fechaCreacion": "2026-01-05T09:00:00",
    "status": "RESUELTO",
    "autor": "admin",
    "curso": "Spring Boot 3"
}
```

> Si el ID no existe → `404 Not Found`

---

#### 2.5 Actualizar un tópico

| Campo  | Valor                                |
|--------|--------------------------------------|
| Método | `PUT`                                |
| URL    | `http://localhost:8080/topicos/{id}` |
| Auth   | Bearer Token                         |

**Ejemplo:** `http://localhost:8080/topicos/3`

**Body (JSON):**  
Solo envía los campos que quieras modificar. Todos son opcionales excepto `id`.

```json
{
    "id": 3,
    "titulo": "¿Cómo implementar paginación con JpaRepository? [RESUELTO]",
    "mensaje": "Solución encontrada: usar Pageable como parámetro en el controller con @PageableDefault.",
    "status": "RESUELTO"
}
```

**Valores válidos para `status`:**

| Valor           | Descripción                        |
|-----------------|------------------------------------|
| `ABIERTO`       | El tópico está activo sin respuesta|
| `NO_RESPONDIDO` | Nadie ha respondido aún            |
| `RESUELTO`      | La duda fue resuelta               |
| `CERRADO`       | Cerrado por el moderador           |

**Respuesta esperada (200 OK):**
```json
{
    "id": 3,
    "titulo": "¿Cómo implementar paginación con JpaRepository? [RESUELTO]",
    "mensaje": "Solución encontrada: usar Pageable como parámetro en el controller con @PageableDefault.",
    "fechaCreacion": "2026-01-18T14:00:00",
    "status": "RESUELTO",
    "autor": "admin",
    "curso": "Spring Boot 3"
}
```

---

#### 2.6 Eliminar un tópico

| Campo  | Valor                                |
|--------|--------------------------------------|
| Método | `DELETE`                             |
| URL    | `http://localhost:8080/topicos/{id}` |
| Auth   | Bearer Token                         |

**Ejemplo:** `http://localhost:8080/topicos/15`

**Respuesta esperada (204 No Content):** sin cuerpo de respuesta.

> Si el ID no existe → `404 Not Found`

---

### 🗂️ 3. Datos de prueba disponibles

Después de ejecutar las migraciones V4 y V5, estos son los datos cargados:

#### Usuario
| ID | Login | Contraseña |
|----|-------|------------|
| 1  | admin | 123456     |

#### Cursos
| ID | Nombre                 | Categoría |
|----|------------------------|-----------|
| 1  | Spring Boot 3          | BACKEND   |
| 2  | HTML, CSS y JavaScript | FRONTEND  |
| 3  | Cultura                | DEVOPS    |

#### Tópicos de ejemplo (15 registros — migración V5)

| ID | Curso                | Status         |
|----|----------------------|----------------|
| 1  | Spring Boot 3          | RESUELTO       |
| 2  | Spring Boot 3          | RESUELTO       |
| 3  | Spring Boot 3          | ABIERTO        |
| 4  | Spring Boot 3          | ABIERTO        |
| 5  | Spring Boot 3          | CERRADO        |
| 6  | HTML, CSS y JavaScript | RESUELTO       |
| 7  | HTML, CSS y JavaScript | RESUELTO       |
| 8  | HTML, CSS y JavaScript | ABIERTO        |
| 9  | HTML, CSS y JavaScript | NO_RESPONDIDO  |
| 10 | HTML, CSS y JavaScript | ABIERTO        |
| 11 | Cultura                | RESUELTO       |
| 12 | Cultura                | CERRADO        |
| 13 | Cultura                | RESUELTO       |
| 14 | Cultura                | NO_RESPONDIDO  |
| 15 | Cultura                | ABIERTO        |

---

### ❌ 4. Códigos de respuesta

| Código | Significado                                        |
|--------|----------------------------------------------------|
| `200`  | OK — operación exitosa                             |
| `201`  | Created — recurso creado correctamente             |
| `204`  | No Content — eliminación exitosa                   |
| `400`  | Bad Request — campos inválidos o tópico duplicado  |
| `401`  | Unauthorized — token ausente, inválido o expirado  |
| `403`  | Forbidden — sin permisos para el recurso           |
| `404`  | Not Found — ID inexistente                         |

---

### 💡 5. Tip: Configurar el token globalmente en Insomnia

En lugar de pegar el token manualmente en cada request:

1. Ve a **Manage Environments** (ícono de engranaje ⚙️)
2. Agrega la variable: `"token": "pega_aqui_tu_token"`
3. En el header de cada request usa: `Authorization: Bearer {{ _.token }}`

Así solo actualizas el token en un lugar cuando expire (cada 2 horas).

---

## 🔐 Seguridad

- Autenticación **stateless** con tokens JWT (Auth0 java-jwt)
- Contraseñas encriptadas con **BCrypt**
- El endpoint `/login` es el único público; todos los demás requieren token válido
- El token expira cada **2 horas**
- El secret del token se configura via variable de entorno `JWT_SECRET`

---

## 👨‍💻 Autor

Desarrollado por @ngrandon como parte del **Challenge Back End — ForoHub** de [Alura Latam](https://www.aluracursos.com/) + Oracle ONE.
