create database MundoGamer
use MundoGamer

create table productos(
id_productos bigint primary key,
nom_producto varchar(100),
precio_productos money,
cantidad_productos bigint,
descrip_prod varchar(100)
)
insert into productos values(10,'rtx4060',1500,1,'Tarjeta Grafica')
insert into productos values(11,'rtx4090',2000,2,'Tarjeta Grafica')
insert into productos values(12,'B550',500,3,'Placa Madre')
select * from productos

create table clientes(
id_cliente bigint primary key,
nom_cliente varchar(100),
correo varchar(100),
tel_cliente bigint,
ciudad varchar(50)
)
insert into clientes values(7,'Darwin','darwin@',123,'medellin')
insert into clientes values(8,'Mestra','Mestra@',147,'cali')
insert into clientes values(9,'Johan','johan@',258,'cartagena')

select * from clientes

create table ventas(
id_venta bigint primary key,
producto_vendido varchar(100),
cantidad bigint,
precio_venta money,
total_venta bigint
)
---agregando un campo a la tabla ventas:
ALTER TABLE ventas ADD descuento MONEY;

----modificando un campo en la tabla ventas
EXEC sp_rename 'ventas.precio_venta', 'precio_unitario', 'COLUMN';

select * from ventas



insert into ventas values(50,'rtx4060',1,1500,1500)
insert into ventas values(51,'rtx4090',2,2000,4000)
insert into ventas values(52,'B550',3,500,1500)
select * from ventas
 
create table productos_clientes(
id_productos bigint,
id_cliente bigint,

constraint apodo foreign key(id_productos) references productos (id_productos),
constraint apodo1 foreign key(id_cliente) references clientes (id_cliente)
)

create table clientes_ventas(
id_cliente bigint,
id_venta bigint,

constraint apodo2 foreign key(id_cliente) references clientes (id_cliente),
constraint apodo3 foreign key(id_venta) references ventas(id_venta)
)

--orden ascendente
SELECT * FROM productos ORDER BY precio_productos ASC;
--orden descendente
SELECT * FROM productos ORDER BY precio_productos DESC;
--top productos mas caros
SELECT TOP 2 * FROM productos ORDER BY precio_productos DESC;
--precio promedio
SELECT AVG(precio_productos) AS PrecioPromedio FROM productos;

--clientes de una ciudad en especifico
SELECT * FROM clientes WHERE ciudad = 'medellin';

--- Se require mostrar en el campo nom_cliente los datos que comiencen por la letra D
select nom_cliente from clientes where nom_cliente like 'D%'

--- Se require mostrar en el campo nom_cliente el dato que finalice por la letra N
select nom_cliente from clientes where nom_cliente like '%n' 

-- Se require mostrar en la tabla clientes los campos:correo,tel_cliente 
select tel_cliente, correo from clientes

--- Se require crear una consulta donde muestre solo el registro con identificacion 7
select * from clientes where id_cliente=7

--- Se require mostrar el campo id_cliente descendete
select id_cliente from clientes order by id_cliente desc



----PROCESOS ALMACENADOS

---Clientes en una ciudad específica:
--Este procedimiento devuelve los clientes que se encuentran en una ciudad específica (por ejemplo, “Medellín”).
CREATE PROC ObtenerClientesPorCiudad
@Ciudad VARCHAR(50)
AS
SELECT * FROM clientes WHERE ciudad = @Ciudad;

---Cliente por identificación: 
CREATE PROC ObtenerClientePorId
@IdCliente BIGINT
AS
SELECT * FROM clientes WHERE id_cliente = @IdCliente;

---Obtener cliente por correo electrónico:
CREATE PROC ObtenerClientePorCorreo
@Correo VARCHAR(100)
AS
SELECT * FROM clientes WHERE correo = @Correo;

---Clientes con teléfono específico:
CREATE PROC ObtenerClientesPorTelefono
@Telefono BIGINT
AS
SELECT * FROM clientes WHERE tel_cliente = @Telefono;

---Productos más caros (TOP 3):
CREATE PROC ObtenerProductosMasCaros
AS
SELECT TOP 3 * FROM productos ORDER BY precio_productos DESC;

---Productos ordenados por nombre:
CREATE PROC ObtenerProductosOrdenadosPorNombre
AS
SELECT * FROM productos ORDER BY nom_producto;

---Precio promedio de productos vendidos:
CREATE PROC CalcularPrecioPromedioVentas
AS
SELECT AVG(precio_venta) AS PrecioPromedioVentas FROM ventas;

-- que borre productos:
CREATE PROC EliminarProducto
@IdProducto BIGINT
AS
DELETE FROM productos WHERE id_productos = @IdProducto;

---ingreso de datos de la tabla clientes:
CREATE PROC InsertarCliente
@IdCliente BIGINT,
@NomCliente VARCHAR(100),
@Correo VARCHAR(100),
@TelCliente BIGINT,
@Ciudad VARCHAR(50)
AS
INSERT INTO clientes (id_cliente, nom_cliente, correo, tel_cliente, ciudad)
VALUES (@IdCliente, @NomCliente, @Correo, @TelCliente, @Ciudad);

---ingreso de datos de la tabla ventas:
CREATE PROCEDURE InsertarVenta
@IdVenta BIGINT,
@ProductoVendido VARCHAR(100),
@Cantidad BIGINT,
@PrecioUnitario MONEY,
@Descuento MONEY,
@TotalVenta BIGINT
AS
INSERT INTO ventas (id_venta, producto_vendido, cantidad, precio_unitario, descuento, total_venta)
VALUES (@IdVenta, @ProductoVendido, @Cantidad, @PrecioUnitario, @Descuento, @TotalVenta);





















