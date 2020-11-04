create database library;

-- Usuario postgres: psql -U postgres -h localhost

-- listar databases creadas 
\l

-- conectar o usar la base de datos creada
\c


create table books (
    section int,
    title text,
    author text
);

-- descripcion de la tabla \d books

-- insertar datos
insert into books values
(1, 'star wars', 'george lucas'),
(2, 'las cronicas de pretoriano', 'martin gutierrez'),
(3, 'los de abajo', 'universidad de chile');
