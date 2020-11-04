-- Creamos la nueva base de datos y accedemos a ella:
drop database if exists PROYECTO;
create database proyecto;
\c proyecto;
-- Paso 1: Creamos las entidades con sus respectivos atributos:
create table local(id_local integer, ubicacion_local varchar(50), horario_atencion varchar(15), es_rival varchar(2));
create table maton(cantidad_locales_extorcionados integer, rut_maton varchar(10), direccion_maton varchar(50) , arma varchar(20), sueldo integer);
create table producto(id_producto integer, precio_producto integer);
create table trabajador(horario_trabajador varchar(15), sueldo integer, rut_trabajador varchar(10));
create table camion(patente_camion varchar(20), marca_camion varchar(50), id_camion integer, estado_camion varchar(80));
create table cliente(numero_atencion integer, nombre varchar(80));
create table insumo(cantidad integer, tipo_insumo varchar(30), codigo_insumo varchar(50));

-- Paso 2: Asignamos las Primary Keys de cada relacion 
alter table local add Primary key(id_local, ubicacion_local);
alter table maton add Primary key(rut_maton, direccion_maton);
alter table producto add Primary key(id_producto);
alter table trabajador add Primary key(rut_trabajador);
alter table camion add Primary key(patente_camion, id_camion);
alter table cliente add Primary key(numero_atencion);
alter table insumo add Primary key(codigo_insumo);

-- Paso 3: Para cada vinculo 1-1, traspase las llaves primarias hacia la otra entidad:

-- Paso 4: Asignamos las llaves Foraneas a cada vinculo 1-n:
alter table local add rut_trabajador varchar(10);
alter table local add rut_maton varchar(50);
alter table local add direccion_maton varchar(50);
alter table local add Foreign key(rut_trabajador) references trabajador(rut_trabajador);
alter table local add Foreign key(rut_maton, direccion_maton) references maton(rut_maton, direccion_maton);

-- Paso 5: Para cada vinculo n-m, cree nuevas relaciones con la concatenacion de las primary keys:
create table consume(numero_atencion_cliente integer, id_producto integer);
alter table consume add Primary key(numero_atencion_cliente, id_producto);
alter table consume add Foreign key(numero_atencion_cliente) references cliente(numero_atencion);
alter table consume add Foreign key(id_producto) references producto(id_producto);

create table abastece(id_local integer, ubicacion_local varchar(50), patente_camion varchar(20), id_camion integer);
alter table abastece add Primary key(id_local, ubicacion_local, patente_camion, id_camion);
alter table abastece add Foreign key(id_local, ubicacion_local) references local(id_local, ubicacion_local);
alter table abastece add Foreign key(patente_camion, id_camion) references camion(patente_camion, id_camion);

create table crea(id_producto integer, codigo_insumo varchar(50));
alter table crea add Primary key(id_producto, codigo_insumo);
alter table crea add Foreign key(id_producto) references producto(id_producto);
alter table crea add Foreign key(codigo_insumo) references insumo(codigo_insumo);

create table lleva(patente_camion varchar(20), id_camion integer, codigo_insumo varchar(50));
alter table lleva add Primary key(patente_camion, id_camion, codigo_insumo);
alter table lleva add Foreign key(patente_camion, id_camion) references camion(patente_camion, id_camion);
alter table lleva add Foreign key(codigo_insumo) references insumo(codigo_insumo);

create table acude(id_local integer, ubicacion_local varchar(50), numero_atencion_cliente integer);
alter table acude add Primary key(id_local, ubicacion_local, numero_atencion_cliente);
alter table acude add Foreign key(id_local, ubicacion_local) references local(id_local, ubicacion_local);
alter table acude add Foreign key(numero_atencion_cliente) references cliente(numero_atencion);

-- Paso 6: Para cada vinculo n-ario, cree nuevas relaciones con la concatenacion de las primary keys:




insert into maton values (15, '13645954-k', 'pudahuel', 'ak-47', 1500000);
insert into maton values (0, '8884553-0', 'quinta normal', 'bazooka', 1);
insert into maton values (5, '9456333-5', 'santiago', 'cuchillo', 500000);
insert into maton values (1, '8431255-9', 'del bosque', 'sniper', 10000);
insert into maton values (6, '54661252-k', 'santiago', 'revolver', 800000);

insert into trabajador values ('16:00-19:00', 250000, '12222131-0');
insert into trabajador values ('10:00-18:00', 550000, '18484963-k');
insert into trabajador values ('15:00-20:00', 500000, '5899666-2');
insert into trabajador values ('09:00-15:00', 850000, '20111545-6');
insert into trabajador values ('16:00-19:00', 1550000, '22169878-3');

insert into producto values (12312213, 1000);
insert into producto values (64376865, 5000);
insert into producto values (49768344, 50000);
insert into producto values (13465973, 500);
insert into producto values (11111314, 80000);

insert into cliente values (1, 'Juanito Pérez');
insert into cliente values (55, 'Señor Pretoriano');
insert into cliente values (23, 'LeBron James');
insert into cliente values (6, 'Juanita Pérez');
insert into cliente values (2, 'Martín Gutierrez');

insert into camion values ('4A52FGN9', 'Isuzu', 22, 'tiene las ruedas pinchadas');
insert into camion values ('4ER52TY6', 'Mercedes Benz', 1, 'presenta fallas en el motor');
insert into camion values ('SD5445R0', 'Volvo', 226, 'bueno');
insert into camion values ('D4S5A3S2', 'Volvo', 5, 'sin revisión técnica');
insert into camion values ('5AAS4D51', 'Iveco', 999, 'ventanales rotos');

insert into insumo values (100, 'papas', 01);
insert into insumo values (29, 'tomate', 02);
insert into insumo values (69, 'caja de pollos', 03);
insert into insumo values (86, 'aceite', 04);
insert into insumo values (90, 'caja de carne',05);

insert into local values (01, 'santiago', '16:00-20:00', 'no','12222131-0', '13645954-k', 'pudahuel');
insert into local values (02, 'maipu', '10:00-20:20', 'si', '18484963-k', '8884553-0', 'quinta normal');
insert into local values (03, 'santiago', '12:00-20:30', 'si', '5899666-2', '9456333-5', 'santiago');
insert into local values (04, 'cerrillos', '06:00-16:15', 'no', '20111545-6', '8431255-9', 'del bosque');
insert into local values (05, 'providencia', '14:00-22:45', 'si', '22169878-3', '54661252-k', 'santiago');

insert into consume values (1, 12312213);
insert into consume values (55, 64376865);
insert into consume values (23, 49768344);
insert into consume values (6, 13465973);
insert into consume values (2, 11111314);

insert into abastece values (01, 'santiago', '4A52FGN9', 22);
insert into abastece values (02, 'maipu', '4ER52TY6', 1);
insert into abastece values (03, 'santiago', 'SD5445R0', 226);
insert into abastece values (04, 'cerrillos', 'D4S5A3S2', 5);
insert into abastece values (05, 'providencia', '5AAS4D51', 999);

insert into crea values (12312213, 01);
insert into crea values (64376865, 02);
insert into crea values (49768344, 03);
insert into crea values (13465973, 04);
insert into crea values (11111314, 05);

insert into lleva values ('4A52FGN9', 22, 01);
insert into lleva values ('4ER52TY6', 1, 02);
insert into lleva values ('SD5445R0', 226, 03);
insert into lleva values ('D4S5A3S2', 5, 04);
insert into lleva values ('5AAS4D51', 999, 05);

insert into acude values (01, 'santiago', 1);
insert into acude values (02, 'maipu', 55);
insert into acude values (03, 'santiago', 23);
insert into acude values (04, 'cerrillos', 6);
insert into acude values (05, 'providencia', 2);

--consulta 1) Ubicación locales no rivales:
select local.ubicacion_local from local where local.es_rival='no';
--consulta 2) Listado de precios de los productos:
select producto.precio_producto from producto;
--consulta 3) Horarios de atención locales no rivales:
select local.horario_atencion from local where local.es_rival='no';
----------------UPDATE 1) LOS LOCALES DE MAIPÚ HAN SIDO EXTORSIONADOS!!!
update local set es_rival='no' where local.ubicacion_local='maipu';
-- SE REPITEN LAS CONSULTAS QUE INVOLUCRABAN LOCALES ALIADOS
 select local.ubicacion_local from local where local.es_rival='no';
 select local.horario_atencion from local where local.es_rival='no';
--consulta 4) Cantidad de camiones disponibles para el uso:
select count (camion.estado_camion) from camion where camion.estado_camion='bueno';
----------------UPDATE 2) LOS CAMIONES CON PROBLEMAS BÁSICOS (RUEDAS PINCHADAS, VENTANALES ROTOS) SE HAN ARREGLADO!!!
update camion set estado_camion='bueno' where camion.estado_camion='tiene las ruedas pinchadas' or camion.estado_camion='ventanales rotos';
-- se repite la consulta anterior
select count (camion.estado_camion) from camion where camion.estado_camion='bueno';
-------consulta 5) Registro de locales extorsionados por parte de cada maleante:
select maton.cantidad_locales_extorcionados, maton.rut_maton from maton;
---------------UPDATE 3) el matón que tenía 0 extorciones ha conseguido su primera extorción CON UN BAZOOKA!!!
update maton set cantidad_locales_extorcionados=1 where rut_maton='8884553-0' and direccion_maton='quinta normal';
-- se repite la consulta anterior
select maton.cantidad_locales_extorcionados, maton.rut_maton from maton;
--consulta 6) Listado de números de atención de cliente:
select cliente.numero_atencion, cliente.nombre from cliente order by cliente.numero_atencion asc;