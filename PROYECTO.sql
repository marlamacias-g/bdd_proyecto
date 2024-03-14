create database floreria;
use floreria;

Create table Cliente (
	Id_cliente int not null,
    primary key(Id_cliente),
    Nombre varchar(50) not null , Apellido varchar(50) not null, Direccion varchar(100)not null, Telefono int not null, Correo varchar(100)not null
);

Create table Empleados (
	Id_empleado int not null,
    primary key(Id_empleado),
    Nombre varchar(50) not null,
    Apellido varchar(50) not null, Puesto varchar(100)not null
);

Create table Pedidos(
    Id_pedido int not null,
    primary key(Id_pedido),
    Id_cliente int not null,
    foreign key (Id_cliente) references Cliente (Id_cliente),
    Id_empleado int not null,
	foreign key (Id_empleado) references Empleados(Id_empleado),
    Fecha varchar(10) not null,
    Total decimal not null
);

Create table MetodoPago (
	Id_metodopago int not null,
    primary key(Id_metodopago),
    Nombre varchar(50) not null 
);

Create table Proveedores (
	Id_Proveedor int not null,
    primary key(Id_Proveedor),
    Nombre varchar(50) not null, Telefono int not null, Correo varchar(100)
);

Create table CategoriaProducto (
	Id_catprod int not null,
    primary key(Id_catprod),
    Nombre varchar(50) not null
);


Create table Productos(
    Id_Producto int not null,
    primary key (Id_Producto),
    id_catprod int not null,
    foreign key (id_catprod) references CategoriaProducto (id_catprod),
    Id_Proveedor int not null,
	foreign key (Id_Proveedor) references Proveedores(Id_Proveedor),
    Descripción varchar(200) not null,
    Precio decimal not null, Stock int not null
);

Create table Envios(
    Id_Envios int not null,
    primary key (Id_Envios),
    Id_Pedido int not null,
    foreign key (Id_Pedido) references Pedidos (Id_Pedido),
    Metodo_Envio varchar(200) not null,
    Estado_Envio varchar(120) not null
);

Create table Ventas(
    Id_Venta int not null,
    primary key (Id_Venta),
    Id_Cliente int not null,
    foreign key (Id_Cliente) references Cliente (Id_Cliente),
    Id_metodopago int not null,
    foreign key (Id_metodopago) references MetodoPago (Id_metodopago),
    Fecha varchar(50) not null, Total decimal not null
);


Create table DetallesVenta(
    Id_detalles_venta int not null,
    primary key (Id_detalles_venta),
    Id_Venta int not null,
    foreign key (Id_Venta) references Ventas (Id_Venta),
    Id_Producto int not null,
    foreign key (Id_Producto) references Productos (Id_Producto),
    Cantidad int not null, total decimal not null
);


DELIMITER //
CREATE TRIGGER validar_idcliente
AFTER INSERT 
ON Cliente 
FOR EACH ROW 
BEGIN
   IF NEW.Id_Cliente <= 0 then
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El Id_Cliente no puede ser 0';
	END IF;
END
// DELIMITER ;


delimiter //
Create Trigger validar_nombre_Empleado
before insert
on Empleados
for each row
BEGIN
   declare validarvacio varchar(15);
   set validarvacio = trim(new.Nombre);
   if validarvacio = '' then
     signal sqlstate '45001' SET message_text='No haz ingresado el NOMBRE del Empleado, intentalo de nuevo';
	end if;
end
// delimiter ;


delimiter //
Create Trigger validar_Apellido_Empleado
before insert
on Empleados
for each row
BEGIN
   declare validarvacio varchar(15);
   set validarvacio = trim(new.Apellido);
   if validarvacio = '' then
     signal sqlstate '45001' SET message_text='No haz ingresado el NOMBRE del Empleado, intentalo de nuevo';
	end if;
end
// delimiter ;


delimiter //
Create Trigger validar_nombre_producto
before insert
on CategoriaProducto
for each row
BEGIN
   declare validarvacio varchar(15);
   set validarvacio = trim(new.Nombre);
   if validarvacio = '' then
     signal sqlstate '45001' SET message_text='No haz ingresado el NOMBRE del Producto, intentalo de nuevo';
	end if;
end
// delimiter ;





-- Pruebas de Triggers

insert into Cliente values (0,'Matilde','Llanez','Calle Ing. Juan Ojeda Robles 205, Col Buena Vista, Buena Vista, 22415 Tijuana, B.C.',664111111,'matilde@correo.com');
insert into Empleados values (1, 'Kevin', '', 'Administrador');
insert into CategoriaProducto values (2,'    ');

-- inserts 

insert into Cliente values (1001,'Matilde','Llanez','Calle Ing. Juan Ojeda Robles 205, Col Buena Vista, Buena Vista, 22415 Tijuana, B.C.',664111111,'matilde@correo.com');
insert into Cliente values (1002,'Andrea','Cruz','Colombia 9111, Madero Cacho, 22040 Tijuana, B.C.',664222222,'andrea@correo.com');
insert into Cliente values (1003,'Omar','Flores','Rampa, Aeropuerto 16000 Col, Otay Constituyentes, 22390 Tijuana, B.C.',664333333,'omar@correo.com');
insert into Cliente values (1004,'Isaac','Huerta','2745 Otay Pacific Dr, San Diego, CA 92154, United States',664444444,'isaac@correo.com');
insert into Cliente values (1005,'Gema','Flores','C. Río Mocorito Sn, Ex-Ejido Coahuila, 21360 Mexicali, B.C.',664555555,'gema@correo.com');
insert into Cliente values (1006,'Andres','Aleman','C. de la Grieta 1950, Playas, Dorada, 22505 Tijuana, B.C.',664666666,'aleman@correo.com');
 

insert into Empleados values(2001,'Nathalia','Fregoso','Dueña');
insert into Empleados values(2002,'Marla','Macias','Gerente');
insert into Empleados values(2003,'Kevin','Reyes','Vendedor');
insert into Empleados values(2004,'Alexander','Soprano','Vendedor');
insert into Empleados values(2005,'Ana','Laura','Vendedor');
insert into Empleados values(2006,'Empleado','Procedure','NADA')

insert into Pedidos values (3001,1001,2003,'2024-01-27', 180.00);
insert into Pedidos values (3002,1006,2005,'2024-02-19', 600.00);
insert into Pedidos values (3003,1001,2003,'2024-02-14', 180.00);

insert into MetodoPago values (4001, 'Efectivo');
insert into MetodoPago values (4002, 'Tarjeta de Debito');
insert into MetodoPago values (4003, 'Tarjeta de Credito');
insert into MetodoPago values (4001, 'Efectivo');

insert into Proveedores values (5001, 'le flourie', 66411114, 'leflorie@correo.com');
insert into Proveedores values (5002, 'Flores el Corral', 66422515, 'floreselcorral@correo.com');
insert into Proveedores values (5003, 'LUTEA', 664333142, 'lutea@correo.com');

insert into CategoriaProducto values (6001, 'Flores');
insert into CategoriaProducto values (6002, 'Ramo');
insert into CategoriaProducto values (6003, 'Arreglos');

insert into Productos values (7001, 6001, 5001, 'Tulipanes', 50.00, 20);
insert into Productos values (7002, 6001, 5001, 'Girasoles', 30.00, 20);
insert into Productos values (7004, 6001, 5001, 'Ramo de rosas', 300.00, 2);
insert into Productos values (7005, 6001, 5003, 'Gerberas', 20.00,30);

insert into Envios values (6001, 3001, 'Recoger en tienda', 'Entregado');
insert into Envios values (6002, 3002, 'Envío urgente', 'Entregado');
insert into Envios values (6003, 3003, 'Recoger en tienda', 'Pendiente');

insert into Ventas values (8001, 1001, 4001, '2024-01-27', 180.00);
insert into Ventas values (8002, 1006, 4002, '2024-02-19', 600.00);
insert into Ventas values (8003, 1001, 4001, '2024-02-14', 180.00);
insert into Ventas values (8004, 1002, 4003, '2024-03-01', 250.00);
insert into Ventas values (8005, 1003, 4002, '2024-03-15', 350.00);
insert into Ventas values (8006, 1004, 4001, '2024-04-05', 120.00);

insert into DetallesVenta values (9001, 8001, 7001, 3, 180.00); 
insert into DetallesVenta values (9002, 8002, 7004, 1, 300.00); 
insert into DetallesVenta values (9003, 8003, 7001, 3, 180.00);
insert into DetallesVenta values (9004, 8004, 7002, 5, 150.00);
insert into DetallesVenta values (9005, 8005, 7002, 7, 350.00);
insert into DetallesVenta values (9006, 8006, 7001, 6, 120.00);

Create Role Dueña;
grant select, insert, update, delete on Cliente to Dueña;
grant select, insert, update, delete on Pedidos to Dueña;
grant select, insert, update, delete on Empleados to Dueña;
grant select, insert, update, delete on DetallesVenta to Dueña;
grant select, insert, update, delete on Proveedores to Dueña;
grant select, insert, update, delete on CategoriaProducto to Dueña;
grant select, insert, update, delete on Productos to Dueña;
grant select, insert, update, delete on Envios to Dueña;
grant select, insert, update, delete on MetodoPago to Dueña;
grant select, insert, update, delete on Ventas to Dueña;

create role Cliente;
grant select on Venta to Cliente;

create role Empleado;
grant select, insert, update on Ventas to Empleado;
grant select, insert, update on DetallesVenta to Empleado;
grant select, insert, update on Envios to Empleado;
grant select, insert on Cliente to Empleado;
grant select, insert, update on Pedidos to Empleado;

DELIMITER //
create procedure EliminarEmpleados(
    in p_id_empleado int
)
begin
    delete from Empleados where Id_empleado = p_id_empleado;
end //
DELIMITER ;

call EliminarEmpleados(2006); 

drop view ProveedorFloresElCorral;

create view ProductosFloresElCorral as
select Id_Producto, Descripción, Precio, Stock
from Productos 
join Proveedores on Proveedores.Id_Proveedor = Proveedores.Id_Proveedor
where Proveedores.Nombre = 'Flores el Corral';

create view NombreClientesdeVentasMayora100 as
select Cliente.Id_cliente, Cliente.Nombre, Cliente.Apellido, SUM(Ventas.Total) as TOTAL
from Cliente 
join Ventas  on Cliente.Id_cliente = Ventas.Id_cliente
group by Cliente.Id_cliente, Cliente.Nombre, Cliente.Apellido
having SUM(	Ventas.Total) > 100;






