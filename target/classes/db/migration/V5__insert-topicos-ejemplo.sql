-- Migración V5: 15 tópicos de ejemplo con distintos status y cursos
-- Autores disponibles: id=1 (admin)
-- Cursos disponibles: id=1 (Spring Boot 3), id=2 (HTML, CSS y JavaScript), id=3 (Cultura)

INSERT INTO topicos (titulo, mensaje, fecha_creacion, status, autor_id, curso_id) VALUES

-- Spring Boot 3 (curso_id=1) -------------------------
(
    '¿Cómo configurar Spring Security con JWT?',
    'Estoy intentando proteger mis endpoints con JWT pero me aparece 403 en todos lados. ¿Qué configuración necesito en SecurityFilterChain?',
    '2026-01-05 09:00:00',
    'RESUELTO',
    1, 1
),
(
    'Error al conectar Flyway con MySQL en Spring Boot',
    'Al iniciar la app me aparece el error "Unable to obtain connection from database". Tengo configurado el datasource en application.properties pero no funciona.',
    '2026-01-10 11:30:00',
    'RESUELTO',
    1, 1
),
(
    '¿Cómo implementar paginación con JpaRepository?',
    'Quiero retornar los resultados paginados desde mi endpoint GET. Vi que existe Pageable pero no sé cómo integrarlo con el controller y el repository.',
    '2026-01-18 14:00:00',
    'ABIERTO',
    1, 1
),
(
    'Diferencia entre @RestController y @Controller en Spring',
    'Entiendo que @RestController combina @Controller y @ResponseBody, pero ¿en qué casos concretos debo usar uno u otro? ¿Hay impacto en el rendimiento?',
    '2026-01-25 16:45:00',
    'ABIERTO',
    1, 1
),
(
    'Validaciones con @Valid no funcionan en mi endpoint POST',
    'Tengo anotaciones @NotBlank y @NotNull en mi record DTO pero el endpoint acepta valores nulos sin retornar error. Ya tengo spring-boot-starter-validation en el pom.xml.',
    '2026-02-02 10:15:00',
    'CERRADO',
    1, 1
),

-- HTML, CSS y JavaScript (curso_id=2) -------------------------
(
    '¿Cuál es la diferencia entre display flex y display grid en CSS?',
    'Sé que ambos sirven para hacer layouts pero no tengo claro cuándo usar flexbox y cuándo grid. ¿Hay una regla general para decidir cuál aplicar?',
    '2026-01-08 08:30:00',
    'RESUELTO',
    1, 2
),
(
    '¿Cómo centrar un div vertical y horizontalmente en CSS moderno?',
    'Siempre me cuesta centrar elementos. He visto soluciones con margin auto, flexbox y grid. ¿Cuál es la forma más limpia y compatible actualmente?',
    '2026-01-15 13:00:00',
    'RESUELTO',
    1, 2
),
(
    '¿Qué es el event bubbling en JavaScript y cómo se evita?',
    'Cuando hago click en un elemento hijo, el evento también se dispara en el padre. Entiendo que es el bubbling pero no sé cómo detenerlo correctamente sin romper otros eventos.',
    '2026-01-22 15:20:00',
    'ABIERTO',
    1, 2
),
(
    'Mi página HTML se ve diferente en Chrome y Firefox',
    'Apliqué estilos CSS y en Chrome se ve perfecto, pero en Firefox hay diferencias en el espaciado y en la fuente. ¿Cómo hago que sea consistente entre navegadores?',
    '2026-02-01 09:45:00',
    'NO_RESPONDIDO',
    1, 2
),
(
    '¿Cómo usar async/await correctamente en JavaScript?',
    'Estoy migrando código con callbacks y promesas a async/await pero no entiendo bien cómo manejar los errores con try/catch ni cómo ejecutar múltiples llamadas en paralelo.',
    '2026-02-10 11:00:00',
    'ABIERTO',
    1, 2
),

-- Cultura (curso_id=3) -------------------------
(
    '¿Qué es la metodología Agile y cómo se aplica en equipos de desarrollo?',
    'Escucho mucho sobre Agile y Scrum pero no tengo claro cómo se implementan en la práctica. ¿Cuáles son los roles, las ceremonias y los artefactos principales?',
    '2026-01-12 10:00:00',
    'RESUELTO',
    1, 3
),
(
    '¿Cómo dar y recibir feedback constructivo en un equipo tech?',
    'En mi equipo evitamos darnos feedback directo por miedo a conflictos. ¿Existen técnicas o frameworks para hacer este proceso más natural y efectivo?',
    '2026-01-20 14:30:00',
    'CERRADO',
    1, 3
),
(
    '¿Qué diferencia hay entre cultura de empresa y clima laboral?',
    'Mi empresa dice tener buena cultura pero el ambiente del día a día no se siente bien. ¿Son lo mismo la cultura organizacional y el clima laboral o son conceptos distintos?',
    '2026-01-28 16:00:00',
    'RESUELTO',
    1, 3
),
(
    '¿Cómo manejar el síndrome del impostor en tecnología?',
    'Aunque llevo un año programando, siento que no sé suficiente comparado con mis compañeros. Me cuesta participar en code reviews y proponer ideas. ¿Es normal? ¿Cómo lo superaron?',
    '2026-02-05 09:30:00',
    'NO_RESPONDIDO',
    1, 3
),
(
    '¿Qué habilidades blandas son más valoradas en desarrolladores junior?',
    'Estoy terminando mi formación y quiero prepararme mejor para el mundo laboral. ¿Qué soft skills hacen la diferencia al momento de conseguir el primer trabajo en tecnología?',
    '2026-02-15 12:00:00',
    'ABIERTO',
    1, 3
);
