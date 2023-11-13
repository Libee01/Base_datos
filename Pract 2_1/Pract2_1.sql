-----------------------------------------------------------
-- Practica 2_1 Admin Básica
-- Database: World.sql
-- Realizado por Mario Liberato
-----------------------------------------------------------


Parte DML
---------

1. Crear la Base de Datos

mysql> create database futbolasir;
Query OK, 1 row affected (0.01 sec)


2. Crear las tablas Jugadores, Equipos Partidos y Goles

create table equipos(
    id_equipo int(2) primary key,
    nombre varchar(50),
    estadio varchar(50),
    aforo int(9),
    ano_fundacion int(4),
    ciudad varchar(50)
);

create table jugadores(
    id_jugador int(3) primary key,
    nombre varchar(50),
    fecha_nac date,
    demarcacion varchar(50),
    internacional int(3),
    id_equipo int(2) references equipos (id_equipo)
);

create table partidos(
    id_equipo_casa int(2),
    id_equipo_fuera int(2),
    fecha date,
    goles_casa int(2),
    goles_fuera int(2),
    observaciones varchar(200)
);

create table goles(
    id_equipo_casa int(2) references partidos (id_equipo_casa),
    id_equipo_fuera int(2) references partidos (id_equipo_fuera),
    minuto int(2),
    descripcion varchar(200),
    id_jugador int(3) references jugadores (id_jugador)
);


3. Añadir una columna nueva a la tabla partidos que indique la hora de comienzo del partido.

alter table partidos add hora_partido time;


4. Crear un índice primario único para la tabla jugadores identificado con la columna id_jugador.

create unique index indice_jugadores on jugadores(id_jugador);


5. Crear un índice primario único para la tabla equipos identificado con la columna id_equipo.

create unique index indice_equipos on equipos(id_equipo);


6. Cambiar el nombre de la columna ano_fundacion de la tabla equipos por fundacion.

alter table equipos change ano_fundacion fundacion int(4);


7. Añadir una columna a la tabla equipos que almacene el anagrama de dicho equipo.

alter table equipos add anagrama varchar(30);


8. Definir el campo o columna id_equipo en la tabla Jugadores como clave foránea
correspondiente a la clave primaria de la tabla Equipos.

alter table jugadores add constraint id_equipo foreign key (id_equipo) references equipos (id_equipo);


9. Generar las instrucciones del SQL en MySQL necesarias para realizar las siguientes
inserciones a las tablas.


Tabla equipos
---------------

insert into equipos values (01, "Real Madrid", "Santiago Bernabeu", 80000, 1950, "Madrid", null);
insert into equipos values (02, "F.C. Barcelona", "Camp Nou", 70000, 1948, "Barcelona", null);
insert into equipos values (03, "Valencia C.F", "Mestalla", 90000, 1952, "Valencia", null);
insert into equipos values (04, "Atlético de Madrid", "Vicente Calderón", 55000, 1945, "Madrid", null);


Tabla jugadores
----------------

insert into jugadores values (01, "Iker", "80/5/9", "Portero", 50, 1);
insert into jugadores values (02, "Ronaldo", "74/7/7", "Delantero", 80, 1);
insert into jugadores values (03, "Ramos", "98/9/9", "Centrocampista", 75, 1);
insert into jugadores values (04, "Neymar", "99/3/3", "Delantero", 50, 2);


Tabla partidos
---------------

insert into partidos values (01, 02, "3/3/14", 2, 1, null, null);
insert into partidos values (01, 03, "4/4/14", 3, 1, null, null);
insert into partidos values (02, 03, "3/4/14", 0, 4, null, null);


Tabla goles
------------

insert into goles values (1, 2, 35, "De falta", 2);
insert into goles values (1, 2, 70, null, 2);
insert into goles values (1, 2, 88, null, 4);
insert into goles values (1, 3, 5, null, 3);
insert into goles values (1, 3, 10, "De penalti", 2);


10. Copia de la BBDD

mysqldump -u root -p futbolasir > pract21_mario.sql


Parte DML
----------

Consultas sobre la tabla city
------------------------------

1. Ver estructura de la tabla

describe city;

5 rows in set (0.01 sec)


2. Ver todas las tuplas de la tabla

select * from city;

4079 rows in set (0.00 sec)


3. Ver todos los nombres y distritos de las ciudades

select name, district from city;

4079 rows in set (0.00 sec)


4. Ver todas las ciudades que tienen el código ESP

select * from city where countrycode like "ESP";

59 rows in set (0.00 sec)


5. Ver todas las ciudades y sus códigos de país ordenados por código de país

select name, countrycode from city order by countrycode;

4079 rows in set (0.00 sec)


6. Ver cuántas ciudades tiene cada país

select count(city.name), country.name from city
join country on (city.countrycode = country.code)
group by country.name;

232 rows in set (0.01 sec)


7. Sacar la población menor

select min(population) from city;

+-----------------+
| min(population) |
+-----------------+
|              42 |
+-----------------+
1 row in set (0.00 sec)


8. ¿Cómo será la mayor?

select max(population) from city;

+-----------------+
| max(population) |
+-----------------+
|        10500000 |
+-----------------+
1 row in set (0.00 sec)


9. Sacar el nombre de la ciudad con más habitantes

select name from city where population = (select max(population) from city);

+-----------------+
| name            |
+-----------------+
| Mumbai (Bombay) |
+-----------------+
1 row in set (0.00 sec)


10. Averigua la suma de todos los habitantes

select sum(population) from city;

+-----------------+
| sum(population) |
+-----------------+
|      1429559884 |
+-----------------+
1 row in set (0.00 sec)


11. Saca los distintos códigos de país

select distinct(countrycode) from city;

232 rows in set (0.00 sec)


12. Cuenta los distintos códigos de país

select count(distinct(countrycode)) from city;

+------------------------------+
| count(distinct(countrycode)) |
+------------------------------+
|                          232 |
+------------------------------+
1 row in set (0.00 sec)


13. Saca las ciudades del país USA que su población sea mayor de 10000

select city.name, country.name from city
join country on (city.countrycode=country.code)
where countrycode like "USA" and city.population > 10000;

274 rows in set (0.00 sec)


14. Cuenta todos los códigos de países

select count(countrycode) from city;

+--------------------+
| count(countrycode) |
+--------------------+
|               4079 |
+--------------------+
1 row in set (0.00 sec)


15. Suma todas las poblaciones distintas

select name, sum(distinct(population)) from city
group by name;

3998 rows in set (0.01 sec)


16. Saca el nombre de la ciudad con menos habitantes

select name from city where population = (select min(population) from city);

+-----------+
| name      |
+-----------+
| Adamstown |
+-----------+
1 row in set (0.00 sec)


17. Saca sólo las provincias distintas de España

select distinct(name) from city where countrycode like "ESP";

59 rows in set (0.00 sec)


18. Saca el número de ciudades por provincias

select count(city.name), country.name from city
join country on (city.countrycode=country.code)
group by country.name;

232 rows in set (0.01 sec)


19. Saca todas las ciudades de Extremadura

select district, name from city where name like "Extremadura";

Empty set (0.00 sec)


20. Saca la cuenta de las ciudades agrupadas por provincias y por países

select count(city.district), country.name from city 
join country on (city.countrycode=country.code) group by 2
union
select distinct(district), count(name) from city 
group by 1;






21. Saca la suma de todos los distritos de España

select count(district) from city where countrycode like "ESP";

+-----------------+
| count(district) |
+-----------------+
|              59 |
+-----------------+
1 row in set (0.00 sec)


22. Cuál es el distrito español con más habitantes

select district from city
where countrycode like "ESP"
and population = (select max(population) from city where countrycode like "ESP");

+----------+
| district |
+----------+
| Madrid   |
+----------+

1 row in set (0,00 sec)


Consultas sobre la tabla Country
---------------------------------

1. ¿Cuál es la esperanza de vida máxima?

select max(lifeexpectancy) from country;

+---------------------+
| max(lifeexpectancy) |
+---------------------+
|                83.5 |
+---------------------+
1 row in set (0.00 sec)

2. Saca la lista de las capitales de todos los países

select name, capital from country;

239 rows in set (0.00 sec)


3. Saca la lista de las capitales europeas

select capital from country where continent like "Europe";

46 rows in set (0.00 sec)


4. Saca la lista de las capitales africanas y norteamericanas

select capital, continent from country where continent like "Africa"
or continent like "North America" or continent like "South America";

109 rows in set (0.00 sec)


5. Halla la población media

select avg(population) from country;

+-----------------+
| avg(population) |
+-----------------+
|   25434098.1172 |
+-----------------+
1 row in set (0.00 sec)


6. Saca los países con mayor y menor esperanza de vida

select name, lifeexpectancy from country
where lifeexpectancy = (select max(lifeexpectancy) from country)
or lifeexpectancy = (select min(lifeexpectancy) from country);

+---------+----------------+
| name    | lifeexpectancy |
+---------+----------------+
| Andorra |           83.5 |
| Zambia  |           37.2 |
+---------+----------------+
2 rows in set (0.00 sec)


7. Saca una lista de continentes ordenadas por la esperanza de vida media de forma descendente

select continent from country order by lifeexpectancy desc;

239 rows in set (0.00 sec)


8. Cuál es la mayor esperanza de vida (2 formas de hacerlo, con una variable y de una forma nueva,
usar select como tabla)

Forma 1
--------

select max(lifeexpectancy) from country;

+---------------------+
| max(lifeexpectancy) |
+---------------------+
|                83.5 |
+---------------------+
1 row in set (0.00 sec)

Forma 2
-------

select lifeexpectancy from country
order by lifeexpectancy desc limit 0,1;

+----------------+
| lifeexpectancy |
+----------------+
|           83.5 |
+----------------+
1 row in set (0.00 sec)


9. Sacar el país con mayor extensión de terreno

select max(surfacearea) from country;

+------------------+
| max(surfacearea) |
+------------------+
|      17075400.00 |
+------------------+
1 row in set (0.00 sec)


10. Cuántas regiones distintas tenemos

select count(distinct(region)) from country;

+-------------------------+
| count(distinct(region)) |
+-------------------------+
|                      25 |
+-------------------------+
1 row in set (0.00 sec)


11. Saca el nombre local de todos los países

select localname, name from country;

239 rows in set (0.00 sec)


12. Saca el nombre local de todos los países europeos y asiáticos

select localname from country where continent like "Europe"
or continent like "Asia";

97 rows in set (0.00 sec)


13. Saca las distintas formas de gobierno

select distinct(governmentform) from country;

35 rows in set (0.00 sec)


Consultas de todo
------------------

1. Enumera todos los idiomas que se hablan en USA

select language from countrylanguage
join country on (countrylanguage.countrycode=country.code)
where country.name like "United States";

12 rows in set (0.00 sec)


2. Obtén la superficie de cada país y el número de ciudades

select count(city.name) "n ciudades", surfacearea, country.name from country
join city on (country.code=city.countrycode)
group by 2,3;

232 rows in set (0.01 sec)


3. Averigua la longevidad media en todos los países que hablan español

select avg(lifeexpectancy), name from country
join countrylanguage on (country.code=countrylanguage.countrycode)
where language like "spanish"
group by 2;

28 rows in set (0.00 sec)


4. Cuántas ciudades tenemos en Spain

select count(city.name) from city
join country on (city.countrycode=country.code)
where country.name like "spain";

+------------------+
| count(city.name) |
+------------------+
|               59 |
+------------------+
1 row in set (0.00 sec)


5. ¿Cómo puedes averiguar el número de habitantes de cualquier país que no reside en una ciudad?

select country.name, country.population from country
join city on (country.code=city.countrycode)
where city.name is null;

Empty set (0.00 sec)


6. ¿Qué países tienen por idioma oficial el inglés?

select country.name from country
join countrylanguage on (country.code=countrylanguage.countrycode)
where countrylanguage.language like "English"
and IsOfficial is true;

60 rows in set (0.00 sec)


7. De todas las ciudades que tenemos en un país que sushabitantes llaman España, cuales tienen más de 10000 habitantes

select city.name from city
join country on (city.countrycode=country.code)
where city.population > 10000
and country.name like "Spain";

59 rows in set (0,01 sec)


8. Saca cada país con su nombre completo y el número de distritos

select count(district), country.name from city
join country on (city.countrycode=country.code)
group by 2;

232 rows in set (0,01 sec)


9. Saca cada ciudad con el país al que corresponde, ordenado por ciudad

select distinct(city.name), country.name from city
join country on (city.countrycode=country.code)
order by 1;

4056 rows in set (0,01 sec)


10. Obtén una lista con los siguientes campos: Ciudad, población, país, superficie, idioma oficial

select city.name, city.population, country.name, surfacearea, countrylanguage.language from country
join city on (country.code=city.countrycode)
join countrylanguage on (country.code=countrylanguage.countrycode)
where isofficial is true;

30670 rows in set (0,04 sec)


11. Obtén una lista con los siguientes campos: población, país, superficie, idioma oficial. Agrupada por países
(No permite agruparlo por país)

select country.name, country.population, surfacearea, countrylanguage.language from country
join countrylanguage on (country.code=countrylanguage.countrycode)
where isofficial is true
group by 1;


12. Obtén el nombre de la capital de todos los países

select city.name, country.name from country
join city on (country.code=city.countrycode)
where country.capital=city.id;

232 rows in set (0,00 sec)


13. Di el nombre de la capital del país más grande

select city.name from city
join country on (city.countrycode=country.code)
where country.surfacearea = (select max(surfacearea) from country)
and country.capital=city.id;

+--------+
| name   |
+--------+
| Moscow |
+--------+

1 row in set (0,00 sec)


14. Di el nombre de la capital del país con más esperanza de vida

select city.name from city
join country on (city.countrycode=country.code)
where country.lifeexpectancy = (select max(lifeexpectancy) from country)
and country.capital=city.id;

+------------------+
| name             |
+------------------+
| Andorra la Vella |
+------------------+

1 row in set (0,00 sec)


15. Di el nombre de la capital del país con más población

select city.name from city
join country on (city.countrycode=country.code)
where country.population = (select max(population) from country)
and country.capital=city.id;

+--------+
| name   |
+--------+
| Peking |
+--------+

1 row in set (0,00 sec)


16. Lista todos los países con más de 1 millón de habitantes con sus capitales y sus lenguas no oficiales

select country.name, city.name, countrylanguage.language from country
join city on (country.code=city.countrycode)
join countrylanguage on (country.code=countrylanguage.countrycode)
where country.population > 1000000
and country.capital=city.id
and countrylanguage.isofficial is false;

Empty set (0,00 sec)


17. Cuántos idiomas tiene cada país

select count(countrylanguage.language), country.name from country
join countrylanguage on (country.code=countrylanguage.countrycode)
group by 2;

233 rows in set (0,00 sec)


18. ¿Tenemos algún país con dos lenguas oficiales? (hacer con having)

select country.name from country
join countrylanguage on (country.code=countrylanguage.countrycode)
where countrylanguage.isofficial is true
group by 1
having count(countrylanguage.language) >= 2;

212 rows in set (0.01 sec)


19. Saca el jefe de gobierno de un país cuya capital es Madrid

select headofstate from country
join city on (country.code=city.countrycode)
where country.capital=city.id
and city.name like "Madrid";

+---------------+
| headofstate   |
+---------------+
| Juan Carlos I |
+---------------+
1 row in set (0.00 sec)


Creación de vistas
-------------------

1. Crea una vista con la media de habitantes

create view media_habitantes_paises as
select avg(population) from country;

Query OK, 0 rows affected (0.00 sec)


2. Crea una vista con la ciudad que tenga exactamente la media de habitantes

create view ciudad_media_habitantes as
select name from city
where population = (select avg(population) from city);

Query OK, 0 rows affected (0.00 sec)


3. Crea una vista con todas las provincias (Distritos) de España

create view provincias_Espana as
select district from city
join country on (city.countrycode=country.code)
where country.name like "Spain";

Query OK, 0 rows affected (0.00 sec)


4. Crea una vista con todos los países con sus capitales y la lengua oficial

create view paises_capitales_lenguaof as
select country.name "país", city.name "capital", countrylanguage.language from country
join city on (country.code=city.countrycode)
join countrylanguage on (country.code=countrylanguage.countrycode)
where country.capital=city.id
and countrylanguage.isofficial like "T";

Query OK, 0 rows affected (0.00 sec)


5. Crea una vista con los países con más de 1 millón de habitantes con sus capitales y la lengua oficial

create view paises_1M as
select country.name "país", city.name "capital", countrylanguage.language from country
join city on (country.code=city.countrycode)
join countrylanguage on (country.code=countrylanguage.countrycode)
where country.capital=city.id
and countrylanguage.isofficial like "T"
and country.population > 1000000;

Query OK, 0 rows affected (0.00 sec)