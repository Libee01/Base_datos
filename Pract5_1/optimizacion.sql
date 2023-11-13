-----------------------------------------------------------
-- Practica 5_1 Optimización
-- Database: clientes.sql
-- Realizado por Mario Liberato
-----------------------------------------------------------
/*
Siguiendo el siguiente esquema que muestra los types de mejor a peor:
- system
- const
- eq_ref
- ref
- fulltext
- ref_or_null
- index_merge
- unique_subquery
- index_subquery
- range
- index
- ALL
*/

1. Consulte cuáles son los índices que hay en la tabla producto utilizando las instrucciones SQL que nos permiten obtener esta información de la tabla.

mysql> show index from producto;

+----------+------------+----------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name | Seq_in_index | Column_name     | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+----------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| producto |          0 | PRIMARY  |            1 | codigo_producto | A         |         276 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| producto |          1 | gama     |            1 | gama            | A         |           4 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+----------+--------------+-----------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+

2 rows in set (0,02 sec)


2. Haga uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas y diga cuál de las dos consultas 
realizará menos comparaciones para encontrar el producto que estamos buscando. ¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?

mysql> explain select * from producto where codigo_producto = 'OR-114';

+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref   | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | producto | NULL       | const | PRIMARY       | PRIMARY | 62      | const |    1 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+-------+------+----------+-------+

1 row in set, 1 warning (0,00 sec)

mysql> explain select * from producto where nombre = 'Evonimus Pulchellus';

+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | producto | NULL       | ALL  | NULL          | NULL | NULL    | NULL |  276 |    10.00 | Using where |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+-------------+

1 row in set, 1 warning (0,00 sec)

Explicación:
-------------
Si comparamos ambos explains, podemos ver que cuando hacemos la búsqueda por codigo de producto nos devuelve una única fila, ya que dicho campo es un clave primaria por lo que es único,
sin embargo al buscar por nombre nos devuelve un total de 276 filas, que puede incluir valores nulos por lo que es menos fiable. Por último si nos fijamos en los campos "type" veremos
que la consulta por el campo de código de producto es de tipo const mientras que la consulta por nombre es de tipo ALL.


3. Suponga que estamos trabajando con la base de datos clientes y queremos saber optimizar las siguientes consultas. ¿Cuál de las dos sería más eficiente?.
Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.

mysql> explain select avg(total) from pago where year(fecha_pago) = 2008;

+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | pago  | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   26 |   100.00 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+

1 row in set, 1 warning (0,00 sec)


mysql> explain select avg(total) from pago where fecha_pago >= '2008-01-01' and fecha_pago <= '2008-12-31';
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | pago  | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   26 |    11.11 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-------------+

1 row in set, 1 warning (0,00 sec)

Explicación:
--------------
Ambas consultas nos devuelven el mismo número de líneas y valores, ya que ambas filtran los datos que sean del año 2008, si nos fijamos por el campo type veremos que ambas son del tipo ALL por lo que
fijarnos en este campo tampoco nos da ninguna información, entonces si nos fijamos en el campo filtered veremos que la segunda consulta tiene un valor mucho menor y esto se puede explicar ya que en la
primera consulta estamos haciendo uso de la función year para extraer los años de las fechas, lo cual implicaría primero que de todas las fechas extrayese en otro campo sólo el campo year (año) y luego
de dicha columna filtraría los que su valor fuera 2008, mientras que la segunda consulta compara las fechas directamente dentro de un rango.


4. Optimiza la siguiente consulta creando índices cuando sea necesario. Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.

mysql> explain select * from cliente join pedido on cliente.codigo_cliente=pedido.codigo_cliente where cliente.nombre_cliente like 'A%';

+----+-------------+---------+------------+------+----------------+----------------+---------+---------------------------------+------+----------+-------------+
| id | select_type | table   | partitions | type | possible_keys  | key            | key_len | ref                             | rows | filtered | Extra       |
+----+-------------+---------+------------+------+----------------+----------------+---------+---------------------------------+------+----------+-------------+
|  1 | SIMPLE      | cliente | NULL       | ALL  | PRIMARY        | NULL           | NULL    | NULL                            |   36 |    11.11 | Using where |
|  1 | SIMPLE      | pedido  | NULL       | ref  | codigo_cliente | codigo_cliente | 4       | clientes.cliente.codigo_cliente |    6 |   100.00 | NULL        |
+----+-------------+---------+------------+------+----------------+----------------+---------+---------------------------------+------+----------+-------------+

2 rows in set, 1 warning (0,00 sec)

mysql> create index index_cliente on cliente (codigo_cliente);
Query OK, 0 rows affected (0,10 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> create index index_pedido on pedido (codigo_cliente);
Query OK, 0 rows affected (0,17 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> create index index2_cliente on cliente (nombre_cliente);
Query OK, 0 rows affected (0,14 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select * from cliente join pedido on cliente.codigo_cliente=pedido.codigo_cliente where cliente.nombre_cliente like 'A%';

+----+-------------+---------+------------+-------+--------------------------------------+----------------+---------+---------------------------------+------+----------+-----------------------+
| id | select_type | table   | partitions | type  | possible_keys                        | key            | key_len | ref                             | rows | filtered | Extra                 |
+----+-------------+---------+------------+-------+--------------------------------------+----------------+---------+---------------------------------+------+----------+-----------------------+
|  1 | SIMPLE      | cliente | NULL       | range | PRIMARY,index_cliente,index2_cliente | index2_cliente | 202     | NULL                            |    3 |   100.00 | Using index condition |
|  1 | SIMPLE      | pedido  | NULL       | ref   | index_pedido                         | index_pedido   | 4       | clientes.cliente.codigo_cliente |    6 |   100.00 | NULL                  |
+----+-------------+---------+------------+-------+--------------------------------------+----------------+---------+---------------------------------+------+----------+-----------------------+

2 rows in set, 1 warning (0,00 sec)

Explicación:
--------------
Creamos 2 índices en la tabla clientes, uno que contenga los códigos de cliente y otro que contenga los nombres de cliente y creamos otro índice de la tabla pedido que contenga los códigos de cliente
que será el campo que se relacione mediante el join entre ambas tablas.


5. Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto y nombre contacto de la tabla cliente.

mysql> create index index_ej5 on cliente (apellido_contacto, nombre_contacto);
Query OK, 0 rows affected (0,12 sec)
Records: 0  Duplicates: 0  Warnings: 0

Una vez creado el índice del ejercicio anterior realice las siguientes consultas haciendo uso de EXPLAIN:

a. Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?

mysql> explain select * from cliente where nombre_cliente = 'Javier Villar';

+----+-------------+---------+------------+------+----------------+----------------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type | possible_keys  | key            | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+------+----------------+----------------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | cliente | NULL       | ref  | index2_cliente | index2_cliente | 202     | const |    1 |   100.00 | NULL  |
+----+-------------+---------+------------+------+----------------+----------------+---------+-------+------+----------+-------+

1 row in set, 1 warning (0,00 sec)

b. Busca el cliente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?

mysql> explain select * from cliente where apellido_contacto = 'Villar';

+----+-------------+---------+------------+------+---------------+-----------+---------+-------+------+----------+-------+
| id | select_type | table   | partitions | type | possible_keys | key       | key_len | ref   | rows | filtered | Extra |
+----+-------------+---------+------------+------+---------------+-----------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | cliente | NULL       | ref  | index_ej5     | index_ej5 | 123     | const |    1 |   100.00 | NULL  |
+----+-------------+---------+------------+------+---------------+-----------+---------+-------+------+----------+-------+

1 row in set, 1 warning (0,00 sec)

c. Busca el cliente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta encontrar el resultado? ¿Qué ha ocurrido en este caso?

mysql> explain select * from cliente where nombre_contacto = 'Javier';

+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
| id | select_type | table   | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | cliente | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   36 |    10.00 | Using where |
+----+-------------+---------+------------+------+---------------+------+---------+------+------+----------+-------------+

1 row in set, 1 warning (0,00 sec)