-- Inserción de Roles
INSERT INTO Roles (NombreRol) VALUES 
    ('Administrador'),
    ('Vendedor'),
    ('Comprador'),
    ('Curador'),
    ('Asistente'),
    ('Historiador'),
    ('Restaurador'),
    ('Coleccionista'),
    ('Investigador'),
    ('Consultor');

-- Inserción de Usuarios
INSERT INTO Usuarios (Nombre, Email, Contraseña, RolID) VALUES 
    ('Carlos Mendoza', 'carlos.mendoza@example.com', 'contraseña123', 1),
    ('Laura García', 'laura.garcia@example.com', 'miContraseña!2024', 2),
    ('Juan Pérez', 'juan.perez@example.com', 'password2024', 3),
    ('Ana López', 'ana.lopez@example.com', 'pass1234', 4),
    ('Miguel Rodríguez', 'miguel.rodriguez@example.com', 'contraseñaMiguel', 5),
    ('Elena Torres', 'elena.torres@example.com', 'elena2024', 6),
    ('Pablo Fernández', 'pablo.fernandez@example.com', 'pablo@123', 7),
    ('Sofía Martínez', 'sofia.martinez@example.com', 'sofia2024!', 8),
    ('Jorge Gómez', 'jorge.gomez@example.com', 'jorge1234', 9),
    ('Paola Jiménez', 'paola.jimenez@example.com', 'paolaPass', 10);

-- Inserción de Categorías
INSERT INTO Categorías (Nombre) VALUES 
    ('Muebles Antiguos'),
    ('Arte'),
    ('Joyería'),
    ('Relojes'),
    ('Cerámica'),
    ('Textiles'),
    ('Libros'),
    ('Armas Antiguas'),
    ('Esculturas'),
    ('Monedas');

-- Inserción de Antigüedades
INSERT INTO Antigüedades (Nombre, Descripción, Precio, EstadoConservación, CategoríaID, Estado) VALUES 
    ('Silla Luis XVI', 'Silla de época Luis XVI con tapicería original.', 1200.00, 'Excelente', 1, 'en venta'),
    ('Cuadro de Van Gogh', 'Reproducción de un cuadro famoso de Van Gogh.', 50000.00, 'Muy Bueno', 2, 'en venta'),
    ('Anillo de Esmeraldas', 'Anillo de esmeraldas del siglo XIX.', 8000.00, 'Bueno', 3, 'en venta'),
    ('Reloj de Bolsillo', 'Reloj de bolsillo de plata con grabados.', 1500.00, 'Excelente', 4, 'en venta'),
    ('Jarrón Ming', 'Jarrón Ming de porcelana china.', 25000.00, 'Muy Bueno', 5, 'en venta'),
    ('Tapiz Medieval', 'Tapiz medieval con escenas de caza.', 3000.00, 'Bueno', 6, 'en venta'),
    ('Edición Original de Don Quijote', 'Primera edición de Don Quijote, en español.', 6000.00, 'Excelente', 7, 'en venta'),
    ('Espada de Caballero', 'Espada antigua de caballero del siglo XV.', 12000.00, 'Bueno', 8, 'en venta'),
    ('Busto de mármol', 'Busto de mármol de época romana.', 10000.00, 'Muy Bueno', 9, 'en venta'),
    ('Moneda de Oro', 'Moneda de oro del siglo XVIII.', 5000.00, 'Excelente', 10, 'en venta');

-- Inserción de Fotos
INSERT INTO Fotos (AntigüedadID, URL) VALUES 
    (1, 'http://example.com/fotos/silla_luis_xvi.jpg'),
    (2, 'http://example.com/fotos/cuadro_van_gogh.jpg'),
    (3, 'http://example.com/fotos/anillo_esmeraldas.jpg'),
    (4, 'http://example.com/fotos/reloj_bolsillo.jpg'),
    (5, 'http://example.com/fotos/jarron_ming.jpg'),
    (6, 'http://example.com/fotos/tapiz_medieval.jpg'),
    (7, 'http://example.com/fotos/don_quijote.jpg'),
    (8, 'http://example.com/fotos/espada_caballero.jpg'),
    (9, 'http://example.com/fotos/busto_marmol.jpg'),
    (10, 'http://example.com/fotos/moneda_oro.jpg');

-- Inserción de Transacciones
INSERT INTO Transacciones (CompradorID, VendedorID, AntigüedadID, Precio) VALUES 
    (3, 2, 1, 1200.00),
    (7, 1, 2, 50000.00),
    (5, 3, 3, 8000.00),
    (8, 4, 4, 1500.00),
    (6, 5, 5, 25000.00),
    (9, 7, 6, 3000.00),
    (10, 8, 7, 6000.00),
    (4, 9, 8, 12000.00),
    (2, 10, 9, 10000.00),
    (1, 6, 10, 5000.00);

-- Inserción de Consultas
INSERT INTO Consultas (AntigüedadID) VALUES 
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9),
    (10);



-- Listar todas las antigüedades disponibles para la venta

SELECT 
    A.Nombre AS NombreAntigüedad,
    C.Nombre AS Categoría,
    A.Precio,
    A.EstadoConservación
FROM 
    Antigüedades A
JOIN 
    Categorías C ON A.CategoríaID = C.CategoríaID
WHERE 
    A.Estado = 'en venta';

-- Buscar antigüedades por categoría y rango de precio
SELECT 
    A.Nombre AS NombreAntigüedad,
    A.Precio
FROM 
    Antigüedades A
JOIN 
    Categorías C ON A.CategoríaID = C.CategoríaID
WHERE 
    C.Nombre = 'Muebles Antiguos' AND
    A.Precio BETWEEN 500 AND 2000
    AND A.Estado = 'en venta';

-- Mostrar el historial de ventas de un cliente específico

SELECT 
    A.Nombre AS NombreAntigüedad,
    T.FechaTransacción,
    T.Precio,
    U.Nombre AS Comprador
FROM 
    Transacciones T
JOIN 
    Antigüedades A ON T.AntigüedadID = A.AntigüedadID
JOIN 
    Usuarios U ON T.CompradorID = U.UsuarioID
WHERE 
    T.VendedorID = 2; 

-- Obtener el total de ventas realizadas en un periodo de tiempo

SELECT 
    SUM(T.Precio) AS TotalVentas
FROM 
    Transacciones T
WHERE 
    T.FechaTransacción BETWEEN '2024-09-17' AND '2024-09-30';

-- Encontrar los clientes más activos (con más compras realizadas)

SELECT 
    U.Nombre AS Cliente,
    COUNT(T.CompradorID) AS NúmeroCompras
FROM 
    Transacciones T
JOIN 
    Usuarios U ON T.CompradorID = U.UsuarioID
GROUP BY 
    U.UsuarioID
ORDER BY 
    NúmeroCompras DESC
LIMIT 10;

-- Listar las antigüedades más populares por número de visitas o consultas 

SELECT 
    A.Nombre AS NombreAntigüedad,
    COUNT(C.ConsultaID) AS NúmeroConsultas
FROM 
    Antigüedades A
JOIN 
    Consultas C ON A.AntigüedadID = C.AntigüedadID
GROUP BY 
    A.AntigüedadID
ORDER BY 
    NúmeroConsultas DESC
LIMIT 10;

-- Listar las antigüedades vendidas en un rango de fechas específico

SELECT 
    A.Nombre AS NombreAntigüedad,
    U.Nombre AS Vendedor,
    U2.Nombre AS Comprador,
    T.FechaTransacción,
    T.Precio
FROM 
    Transacciones T
JOIN 
    Antigüedades A ON T.AntigüedadID = A.AntigüedadID
JOIN 
    Usuarios U ON T.VendedorID = U.UsuarioID
JOIN 
    Usuarios U2 ON T.CompradorID = U2.UsuarioID
WHERE 
    T.FechaTransacción BETWEEN '2024-09-17' AND '2024-09-30';


-- Obtener un informe de inventario actual

SELECT 
    C.Nombre AS Categoría,
    COUNT(A.AntigüedadID) AS CantidadArtículos
FROM 
    Antigüedades A
JOIN 
    Categorías C ON A.CategoríaID = C.CategoríaID
WHERE 
    A.Estado = 'en venta'
GROUP BY 
    C.Nombre;

