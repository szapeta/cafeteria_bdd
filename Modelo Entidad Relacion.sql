-- Base de datos
use B2FyyIIKaj;

-- Tabla demo
create table info(
nombre varchar(100) not null,
version double not null,
fecha datetime not null
);

-- Valor inicial
insert into info (nombre, version, fecha) values ("Cafeteria 4ta Avenida", 0.01, now());