-----------------------------------------------------------
-- Practica 3_1 Administración de usuarios y privilegios
-- Database: pruebas.sql
-- Realizado por Mario Liberato
-----------------------------------------------------------

create database pruebas;

use pruebas;

create table modulo(
    codigo int primary key,
    nombre varchar(40)
);

create table profesor(
    DNI char(9) primary key,
    nombre varchar(40),
    direccion varchar(50),
    telefono char(9)
);

create table alumno(
    expediente int primary key,
    nombre varchar(40),
    apellidos varchar(50),
    fecha_de_nacimiento date
);

create table cursa(
    codigo_modulo int references modulo(codigo),
    expediente_alumno int references alumno(expediente),
    primary key (codigo_modulo,expediente_alumno)
);


1. Crear un usuario llamado “alumno” que tenga acceso a las tablas ALUMNO, CURSA, Y MODULO desde cualquier lugar

create user alumno@localhost;
Query OK, 0 rows affected (0,01 sec)

grant select on pruebas.alumno to alumno@localhost;
Query OK, 0 rows affected (0,01 sec)

grant select on pruebas.cursa to alumno@localhost;
Query OK, 0 rows affected (0,01 sec)

grant select on pruebas.modulo to alumno@localhost;
Query OK, 0 rows affected (0,01 sec)

show grants for alumno@localhost;

+------------------------------------------------------------+
| Grants for alumno@localhost                                |
+------------------------------------------------------------+
| GRANT USAGE ON *.* TO `alumno`@`localhost`                 |
| GRANT SELECT ON `pruebas`.`alumno` TO `alumno`@`localhost` |
| GRANT SELECT ON `pruebas`.`cursa` TO `alumno`@`localhost`  |
| GRANT SELECT ON `pruebas`.`modulo` TO `alumno`@`localhost` |
+------------------------------------------------------------+

4 rows in set (0,00 sec)


2. Crear un usuario llamado “profesor” que tenga permiso de lectura (no puede añadir y
modificar nada) a toda la base de datos

create user profesor@localhost;
Query OK, 0 rows affected (0,01 sec)

grant select on pruebas.* to profesor@localhost;
Query OK, 0 rows affected (0,01 sec)

show grants for profesor@localhost;

+-------------------------------------------------------+
| Grants for profesor@localhost                         |
+-------------------------------------------------------+
| GRANT USAGE ON *.* TO `profesor`@`localhost`          |
| GRANT SELECT ON `pruebas`.* TO `profesor`@`localhost` |
+-------------------------------------------------------+

2 rows in set (0,00 sec)


3. Crear un usuario llamado “profesorasir” con los privilegios anteriores y los privilegios
de inserción y borrado en la tabla.

create user profesorasir@localhost;

grant select, insert, delete on pruebas.* to profesorasir@localhost;

show grants for profesorasir@localhost;

+---------------------------------------------------------------------------+
| Grants for profesorasir@localhost                                         |
+---------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `profesorasir`@`localhost`                          |
| GRANT SELECT, INSERT, DELETE ON `pruebas`.* TO `profesorasir`@`localhost` |
+---------------------------------------------------------------------------+

2 rows in set (0,00 sec)


4. Crear un usuario llamado “adminasir” que tenga todos los privilegios a todas las bases
de datos de nuestro servidor. Este administrador no tendrá la posibilidad de dar
privilegios.

create user adminasir@localhost;

grant all on *.* to adminasir@localhost;

revoke grant option on *.* from adminasir@localhost;


5. Crear un usuario llamado “superasir” con los privilegios anteriores y con posibilidad de dar privilegios

create user superasir@localhost;

grant all on *.* to superasir@localhost;


6. Crear un usuario llamado “ocasional” con permiso para realizar consultas(select) en las tablas.

create user ocasional@localhost;

grant select on pruebas.* to ocasional@localhost;


7. Cambiar la contraseña de root a “css99”

use mysql;

alter user 'root'@'localhost' identified by "root";


8. Quitar los privilegios al usuario “profesorasir”

revoke all on pruebas.* from profesorasir@localhost;


9. Eliminar todos los privilegios al usuario "alumno"

revoke all on pruebas.alumno from alumno@localhost;

revoke all on pruebas.cursa from alumno@localhost;

revoke all on pruebas.modulo from alumno@localhost;

10. Muestra los privilegios de usuario alumno

show grants for alumno@localhost;
+--------------------------------------------+
| Grants for alumno@localhost                |
+--------------------------------------------+
| GRANT USAGE ON *.* TO `alumno`@`localhost` |
+--------------------------------------------+

1 row in set (0,00 sec)


