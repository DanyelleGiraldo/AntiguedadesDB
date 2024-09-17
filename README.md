# AntiguedadesDB

## Descripción

`AntiguedadesDB` es una base de datos diseñada para la gestión de un negocio de antigüedades. Facilita el seguimiento de roles de usuario, antigüedades, categorías, fotos y transacciones. Este README proporciona una visión general de la estructura de la base de datos, las tablas incluidas, y ejemplos de consultas que pueden ser útiles para extraer información relevante.

## Estructura de la Base de Datos

La base de datos se llama `AntiguedadesDB` y está compuesta por las siguientes tablas:

### Roles

- **RolID**: Identificador único del rol (INT, PK, AUTO_INCREMENT)
- **NombreRol**: Nombre del rol (VARCHAR(50), UNIQUE, NOT NULL)

### Usuarios

- **UsuarioID**: Identificador único del usuario (INT, PK, AUTO_INCREMENT)
- **Nombre**: Nombre del usuario (VARCHAR(100))
- **Email**: Correo electrónico del usuario (VARCHAR(100), UNIQUE)
- **Contraseña**: Contraseña del usuario (VARCHAR(100))
- **RolID**: Identificador del rol asignado (INT, FK)
- **FechaRegistro**: Fecha y hora de registro del usuario (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Categorías

- **CategoríaID**: Identificador único de la categoría (INT, PK, AUTO_INCREMENT)
- **Nombre**: Nombre de la categoría (VARCHAR(100), UNIQUE, NOT NULL)

### Antigüedades

- **AntigüedadID**: Identificador único de la antigüedad (INT, PK, AUTO_INCREMENT)
- **Nombre**: Nombre de la antigüedad (VARCHAR(255))
- **Descripción**: Descripción de la antigüedad (TEXT)
- **Precio**: Precio de la antigüedad (DECIMAL(10, 2))
- **EstadoConservación**: Estado de conservación de la antigüedad (VARCHAR(100))
- **CategoríaID**: Identificador de la categoría de la antigüedad (INT, FK)
- **FechaAñadido**: Fecha y hora de adición de la antigüedad (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- **Estado**: Estado de la antigüedad (ENUM('en venta', 'vendido', 'retirado'))

### Fotos

- **FotoID**: Identificador único de la foto (INT, PK, AUTO_INCREMENT)
- **AntigüedadID**: Identificador de la antigüedad a la que pertenece la foto (INT, FK)
- **URL**: URL de la foto (VARCHAR(255))

### Transacciones

- **TransacciónID**: Identificador único de la transacción (INT, PK, AUTO_INCREMENT)
- **CompradorID**: Identificador del comprador (INT, FK)
- **VendedorID**: Identificador del vendedor (INT, FK)
- **AntigüedadID**: Identificador de la antigüedad transaccionada (INT, FK)
- **Precio**: Precio de la antigüedad en la transacción (DECIMAL(10, 2))
- **FechaTransacción**: Fecha y hora de la transacción (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Consultas

- **ConsultaID**: Identificador único de la consulta (INT, PK, AUTO_INCREMENT)
- **AntigüedadID**: Identificador de la antigüedad consultada (INT, FK)
- **FechaConsulta**: Fecha y hora de la consulta (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Consultas de Ejemplo

### Lista de Antigüedades Disponibles para la Venta

```sql
SELECT 
    a.Nombre AS NombreAntigüedad,
    c.Nombre AS Categoría,
    a.Precio,
    a.EstadoConservación
FROM 
    Antigüedades a
JOIN 
    Categorías c ON a.CategoríaID = c.CategoríaID
WHERE 
    a.Estado = 'en venta';
```
### Buscar Antigüedades por Categoría y Rango de Precio

```sql
SELECT 
    a.Nombre AS NombreAntigüedad,
    a.Precio
FROM 
    Antigüedades a
JOIN 
    Categorías c ON a.CategoríaID = c.CategoríaID
WHERE 
    c.Nombre = 'Muebles Antiguos'
    AND a.Precio BETWEEN 500 AND 2000
    AND a.Estado = 'en venta';
```
### Historial de Ventas de un Cliente Específico

```sql
SELECT 
    a.Nombre AS NombreAntigüedad,
    t.FechaTransacción,
    t.Precio,
    u.Nombre AS Comprador
FROM 
    Transacciones t
JOIN 
    Antigüedades a ON t.AntigüedadID = a.AntigüedadID
JOIN 
    Usuarios u ON t.CompradorID = u.UsuarioID
WHERE 
    u.Nombre = 'Juan Pérez';
```
### Obtener el Total de Ventas Realizadas en un Periodo de Tiempo

```sql
SELECT 
    SUM(t.Precio) AS TotalVentas
FROM 
    Transacciones t
WHERE 
    t.FechaTransacción BETWEEN '2024-09-17' AND '2024-09-30';
```
### Encontrar los Clientes Más Activos (Con Más Compras Realizadas)

```sql
SELECT 
    u.Nombre AS Cliente,
    COUNT(t.CompradorID) AS NúmeroCompras
FROM 
    Transacciones t
JOIN 
    Usuarios u ON t.CompradorID = u.UsuarioID
GROUP BY 
    u.UsuarioID
ORDER BY 
    NúmeroCompras DESC
LIMIT 10;
```
### Listar las Antigüedades Más Populares por Número de Visitas o Consultas

```sql
SELECT 
    a.Nombre AS NombreAntigüedad,
    COUNT(c.ConsultaID) AS NúmeroConsultas
FROM 
    Antigüedades a
JOIN 
    Consultas c ON a.AntigüedadID = c.AntigüedadID
GROUP BY 
    a.AntigüedadID
ORDER BY 
    NúmeroConsultas DESC
LIMIT 10;
```
### Listar las Antigüedades Vendidas en un Rango de Fechas Específico

```sql
SELECT 
    a.Nombre AS NombreAntigüedad,
    u.Nombre AS Vendedor,
    u2.Nombre AS Comprador,
    t.FechaTransacción,
    t.Precio
FROM 
    Transacciones t
JOIN 
    Antigüedades a ON t.AntigüedadID = a.AntigüedadID
JOIN 
    Usuarios u ON t.VendedorID = u.UsuarioID
JOIN 
    Usuarios u2 ON t.CompradorID = u2.UsuarioID
WHERE 
    t.FechaTransacción BETWEEN '2024-09-17' AND '2024-09-30';
```

### Obtener un Informe de Inventario Actual

```sql
SELECT 
    c.Nombre AS Categoría,
    COUNT(a.AntigüedadID) AS CantidadArtículos
FROM 
    Antigüedades a
JOIN 
    Categorías c ON a.CategoríaID = c.CategoríaID
WHERE 
    a.Estado = 'en venta'
GROUP BY 
    c.Nombre;
```
