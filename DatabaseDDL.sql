-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS AntiguedadesDB;
USE AntiguedadesDB;

-- Tabla de Roles
CREATE TABLE IF NOT EXISTS Roles (
    RolID INT PRIMARY KEY AUTO_INCREMENT,
    NombreRol VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS Usuarios (
    UsuarioID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Contraseña VARCHAR(100),
    RolID INT,
    FechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RolID) REFERENCES Roles(RolID)
);

-- Tabla de Categorías
CREATE TABLE IF NOT EXISTS Categorías (
    CategoríaID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100) UNIQUE NOT NULL
);

-- Tabla de Antigüedades
CREATE TABLE IF NOT EXISTS Antigüedades (
    AntigüedadID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(255),
    Descripción TEXT,
    Precio DECIMAL(10, 2),
    EstadoConservación VARCHAR(100),
    CategoríaID INT,
    FechaAñadido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Estado ENUM('en venta', 'vendido', 'retirado'),
    FOREIGN KEY (CategoríaID) REFERENCES Categorías(CategoríaID)
);

-- Tabla de Fotos
CREATE TABLE IF NOT EXISTS Fotos (
    FotoID INT PRIMARY KEY AUTO_INCREMENT,
    AntigüedadID INT,
    URL VARCHAR(255),
    FOREIGN KEY (AntigüedadID) REFERENCES Antigüedades(AntigüedadID)
);

-- Tabla de Transacciones
CREATE TABLE IF NOT EXISTS Transacciones (
    TransacciónID INT PRIMARY KEY AUTO_INCREMENT,
    CompradorID INT,
    VendedorID INT,
    AntigüedadID INT,
    Precio DECIMAL(10, 2),
    FechaTransacción TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CompradorID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (VendedorID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (AntigüedadID) REFERENCES Antigüedades(AntigüedadID)
);

-- Tabla de Consultas
CREATE TABLE IF NOT EXISTS Consultas (
    ConsultaID INT PRIMARY KEY AUTO_INCREMENT,
    AntigüedadID INT,
    FechaConsulta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AntigüedadID) REFERENCES Antigüedades(AntigüedadID)
);