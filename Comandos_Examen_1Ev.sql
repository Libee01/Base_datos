------------------------------------------------
-- Lista de comandos examen final 1º Evaluación
------------------------------------------------

-- Creación de la estructura de una base de datos

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


-- Insertar datos en las tablas de la base de datos

Tabla profesor
--------------

insert into profesor values (012345678, "Juan", "Atocha", 123456789);
insert into profesor values (112345678, "Pedro", "Embajadores", 23456789);

Tabla alumno
----------------

insert into alumno values (01, "Álvaro", "Motero", "1980/05/13");
insert into alumno values (02, "Gonzalo", "Picasso", "2000/08/23");


-- Actualizar campos de una tabla

mysql> update profesor set asignaturas = "Redes" where nombre like "Juan";
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from profesor;
+----------+--------+-----------+-----------+-------------+
| DNI      | nombre | direccion | telefono  | asignaturas |
+----------+--------+-----------+-----------+-------------+
| 12345678 | Juan   | Atocha    | 123456789 | Redes       |
+----------+--------+-----------+-----------+-------------+
1 row in set (0.00 sec)


-- Eliminar datos de una tabla

mysql> delete from profesor where nombre like "Pedro";
Query OK, 1 row affected (0.00 sec)


-- Ver la lista de variables

mysql> show status;
496 rows in set (0.00 sec)

-- Ver la configuración del servidor MySQL

mysql> show variables;
655 rows in set, 1 warning (0.00 sec)


-- Ver los posibles motores de almacenamiento compatibles

mysql> show engines;
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| Engine             | Support | Comment                                                        | Transactions | XA   | Savepoints |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
| MEMORY             | YES     | Hash based, stored in memory, useful for temporary tables      | NO           | NO   | NO         |
| MRG_MYISAM         | YES     | Collection of identical MyISAM tables                          | NO           | NO   | NO         |
| CSV                | YES     | CSV storage engine                                             | NO           | NO   | NO         |
| FEDERATED          | NO      | Federated MySQL storage engine                                 | NULL         | NULL | NULL       |
| PERFORMANCE_SCHEMA | YES     | Performance Schema                                             | NO           | NO   | NO         |
| MyISAM             | YES     | MyISAM storage engine                                          | NO           | NO   | NO         |
| InnoDB             | DEFAULT | Supports transactions, row-level locking, and foreign keys     | YES          | YES  | YES        |
| ndbinfo            | NO      | MySQL Cluster system information storage engine                | NULL         | NULL | NULL       |
| BLACKHOLE          | YES     | /dev/null storage engine (anything you write to it disappears) | NO           | NO   | NO         |
| ARCHIVE            | YES     | Archive storage engine                                         | NO           | NO   | NO         |
| ndbcluster         | NO      | Clustered, fault-tolerant tables                               | NULL         | NULL | NULL       |
+--------------------+---------+----------------------------------------------------------------+--------------+------+------------+
11 rows in set (0.00 sec)


-- Cambiar el motor de almacenamiento de una tabla (InnoDB, MyISAM, MEMORY, NDB, etc)

mysql> alter table profesor engine = MEMORY;
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0


-- Ver información genérica de una base de datos

mysql> select table_name, table_type, engine from information_schema.tables where table_schema = 'pruebas';
+------------+------------+--------+
| TABLE_NAME | TABLE_TYPE | ENGINE |
+------------+------------+--------+
| alumno     | BASE TABLE | InnoDB |
| cursa      | BASE TABLE | InnoDB |
| modulo     | BASE TABLE | InnoDB |
| profesor   | BASE TABLE | MEMORY |
+------------+------------+--------+
4 rows in set (0.00 sec)


-- Ver la estructura de una tabla

mysql> describe profesor;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| DNI       | char(9)     | NO   | PRI | NULL    |       |
| nombre    | varchar(40) | YES  |     | NULL    |       |
| direccion | varchar(50) | YES  |     | NULL    |       |
| telefono  | char(9)     | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> show columns from profesor;
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| DNI       | char(9)     | NO   | PRI | NULL    |       |
| nombre    | varchar(40) | YES  |     | NULL    |       |
| direccion | varchar(50) | YES  |     | NULL    |       |
| telefono  | char(9)     | YES  |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)


-- Ver la lista de procesos actuales del servidor

mysql> show processlist;
+-----+-----------------+-----------------+---------+---------+---------+------------------------+------------------+
| Id  | User            | Host            | db      | Command | Time    | State                  | Info             |
+-----+-----------------+-----------------+---------+---------+---------+------------------------+------------------+
|   5 | event_scheduler | localhost       | NULL    | Daemon  | 1394325 | Waiting on empty queue | NULL             |
| 185 | root            | localhost:54087 | pruebas | Query   |       0 | init                   | show processlist |
+-----+-----------------+-----------------+---------+---------+---------+------------------------+------------------+
2 rows in set (0.00 sec)


-- Ver información de un usuario

mysql> show grants for root;
ERROR 1141 (42000): There is no such grant defined for user 'root' on host '%'


-- Ver los índices de una tabla

mysql> show index from profesor;
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| profesor |          0 | PRIMARY  |            1 | DNI         | NULL      |           0 |     NULL |   NULL |      | HASH       |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.01 sec)

mysql> show keys from alumno;
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| alumno |          0 | PRIMARY  |            1 | expediente  | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+--------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
1 row in set (0.00 sec)


-- Hacer transacciones

mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> alter table profesor add asignaturas varchar(50);
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> commit; -- rollback si queremos cancelar la transacción
Query OK, 0 rows affected (0.00 sec)

mysql> describe profesor;
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| DNI         | char(9)     | NO   | PRI | NULL    |       |
| nombre      | varchar(40) | YES  |     | NULL    |       |
| direccion   | varchar(50) | YES  |     | NULL    |       |
| telefono    | char(9)     | YES  |     | NULL    |       |
| asignaturas | varchar(50) | YES  |     | NULL    |       |
+-------------+-------------+------+-----+---------+-------+
5 rows in set (0.00 sec)


-- Bloquear una tabla en modo sólo lectura

mysql> lock tables profesor read;
Query OK, 0 rows affected (0.00 sec)

mysql> alter table profesor drop asignaturas;
ERROR 1099 (HY000): Table 'profesor' was locked with a READ lock and cant be updated


-- Bloquear una tabla para los demás usuarios

mysql> lock tables profesor write;
Query OK, 0 rows affected (0.00 sec)


-- Desbloquear las tablas

mysql> unlock tables;
Query OK, 0 rows affected (0.00 sec)


-- Consultas a las tablas (usando la base de datos tienda.sql)

1. Muestra el nombre de los productos cuyo fabricante empiece por "A"

Consulta con subselect

mysql> select nombre from producto where codigo_fabricante in (select codigo from fabricante where nombre like "A%");
+------------------------+
| nombre                 |
+------------------------+
| Monitor 24 LED Full HD |
| Monitor 27 LED Full HD |
| Disco SSD 2 TB         |
+------------------------+
3 rows in set (0.00 sec)

Consulta con join

mysql> select p.nombre, f.nombre from producto p
    -> join fabricante f on (p.codigo_fabricante=f.codigo)
    -> where f.nombre like "A%";
+------------------------+--------+
| nombre                 | nombre |
+------------------------+--------+
| Monitor 24 LED Full HD | Asus   |
| Monitor 27 LED Full HD | Asus   |
| Disco SSD 2 TB         | Apple  |
+------------------------+--------+
3 rows in set (0.00 sec)

Consulta con exists

mysql> select nombre from producto p
    -> where exists (select * from fabricante f
    -> where p.codigo_fabricante=f.codigo
    -> and f.nombre like "A%");
+------------------------+
| nombre                 |
+------------------------+
| Monitor 24 LED Full HD |
| Monitor 27 LED Full HD |
| Disco SSD 2 TB         |
+------------------------+
3 rows in set (0.00 sec)


-- Creación de vistas

mysql> create view vista_productos as
    -> (select p.nombre "producto", f.nombre "fabricante" from producto p
    -> join fabricante f on p.codigo_fabricante=f.codigo);
Query OK, 0 rows affected (0.01 sec)


-- Eliminación de vistas

mysql> drop view vista_productos;
Query OK, 0 rows affected (0.01 sec)


-- Creación de usuarios

mysql> create user mario identified by 'rootroot'; -- identified by indica la contraseña del usuario
Query OK, 0 rows affected (0.03 sec)

mysql> create user mario@localhost identified by 'root';
Query OK, 0 rows affected (0.01 sec)


-- Cambiar el nombre de un usuario

mysql> rename user mario to newmario;
Query OK, 0 rows affected (0.00 sec)


-- Asignación de permisos a un usuario (all, create, delete, drop, insert, update, select, index, execute, create view, lock tables, grant option)

mysql> grant select on pruebas.alumno to mario;
Query OK, 0 rows affected (0.00 sec)

mysql> grant select, update on pruebas.profesor to mario;
Query OK, 0 rows affected (0.00 sec)

mysql> grant select on *.* to mario; -- permiso de hacer consultas en todas las tablas de todas las bases de datos
Query OK, 0 rows affected (0.00 sec)


-- Quitar permisos a un usuario

mysql> revoke select on pruebas.alumno from mario;
Query OK, 0 rows affected (0.00 sec)

mysql> revoke select,update on pruebas.profesor from mario;
Query OK, 0 rows affected (0.00 sec)


-- Ver permisos de un usuario

mysql> show grants for mario;
+------------------------------------+
| Grants for mario@%                 |
+------------------------------------+
| GRANT SELECT ON *.* TO `mario`@`%` |
+------------------------------------+
1 row in set (0.00 sec)


-- Borrar usuarios (no debe tener permisos)

mysql> drop user mario;
Query OK, 0 rows affected (0.01 sec)


-- Modificar la contraseña de un usuario

mysql> alter user newmario identified by 'psmario';
Query OK, 0 rows affected (0.01 sec)


-- Realizar copias de seguridad

mysqldump -u root -p pruebas > pruebas.sql

C:\Windows\system32> mysql -u root -p pruebas alumno > "C:\Users\User\Desktop\alumnos.sql"


-- Restauración de copias de seguridad

mysql pruebas -u root -p < pruebas.sql


-- Creación de índices

mysql> create index index_alumnos on alumno(nombre);
Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> create index index_profesores on profesor(nombre);
Query OK, 1 row affected (0.02 sec)
Records: 1  Duplicates: 0  Warnings: 0


-- Ver los índices de una tabla

mysql> show index from alumno;
+--------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table  | Non_unique | Key_name      | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| alumno |          0 | PRIMARY       |            1 | expediente  | A         |           0 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| alumno |          1 | index_alumnos |            1 | nombre      | A         |           0 |     NULL |   NULL | YES  | BTREE      |         |               | YES     | NULL       |
+--------+------------+---------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.01 sec)

mysql> show index from profesor;
+----------+------------+------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name         | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| profesor |          0 | PRIMARY          |            1 | DNI         | NULL      |           1 |     NULL |   NULL |      | HASH       |         |               | YES     | NULL       |
| profesor |          1 | index_profesores |            1 | nombre      | NULL      |           0 |     NULL |   NULL | YES  | HASH       |         |               | YES     | NULL       |
+----------+------------+------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
2 rows in set (0.00 sec)


-- Eliminar índices

mysql> drop index index_alumnos on alumno;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> drop index index_profesores on profesor;
Query OK, 1 row affected (0.02 sec)
Records: 1  Duplicates: 0  Warnings: 0


-- Obtener información sobre los campos de una tabla

mysql> describe alumno;
+---------------------+-------------+------+-----+---------+-------+
| Field               | Type        | Null | Key | Default | Extra |
+---------------------+-------------+------+-----+---------+-------+
| expediente          | int         | NO   | PRI | NULL    |       |
| nombre              | varchar(40) | YES  |     | NULL    |       |
| apellidos           | varchar(50) | YES  |     | NULL    |       |
| fecha_de_nacimiento | date        | YES  |     | NULL    |       |
+---------------------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)

mysql> explain alumno;
+---------------------+-------------+------+-----+---------+-------+
| Field               | Type        | Null | Key | Default | Extra |
+---------------------+-------------+------+-----+---------+-------+
| expediente          | int         | NO   | PRI | NULL    |       |
| nombre              | varchar(40) | YES  |     | NULL    |       |
| apellidos           | varchar(50) | YES  |     | NULL    |       |
| fecha_de_nacimiento | date        | YES  |     | NULL    |       |
+---------------------+-------------+------+-----+---------+-------+
4 rows in set (0.00 sec)


-- Obtener información sobre una consulta a una tabla

mysql> explain select nombre, apellidos from alumno where nombre like 'M%';
+----+-------------+--------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table  | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+--------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | alumno | NULL       | ALL  | NULL          | NULL | NULL    | NULL |    1 |   100.00 | Using where |
+----+-------------+--------+------------+------+---------------+------+---------+------+------+----------+-------------+
1 row in set, 1 warning (0.01 sec)


-- Creación de index con fulltext

create fulltext index idx_nombre_descripcion on producto(nombre, descripcion);

-- Busca en el índice todos los productos cuyo nombre o descripción contenga la palabra acero

select * from producto where match(nombre, descripcion) against ('acero');