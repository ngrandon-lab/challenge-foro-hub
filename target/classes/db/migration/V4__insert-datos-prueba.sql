-- Usuario de prueba: login=admin, password=123456 (BCrypt)
INSERT INTO usuarios (login, contrasena) VALUES
('admin', '$2a$12$me9qR901sTnxOeekufCs7O1CPNjSmd1lUS29ODTlb7qb7cIn9a7tK');

-- Cursos de prueba
INSERT INTO cursos (nombre, categoria) VALUES
('Spring Boot 3', 'BACKEND'),
('HTML, CSS y JavaScript', 'FRONTEND'),
('Cultura', 'DEVOPS');
