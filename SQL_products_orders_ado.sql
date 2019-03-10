create database b10_ado_Orders
use b10_ado_Orders

create table tbl_products
(
ProductID int identity(100,1) primary key,
ProductName varchar(100) not null,
ProductPrice int not null
)

create table tbl_orders
(
OrderID int identity(1000,1) primary key,
CustomerEmailID varchar(100)not null,
ProductID int foreign key references tbl_products(ProductID) not null,
ProductPrice int not null,
ProductQty int not null,
OrderDate date not null
)

--products
create proc p_AddProduct(@name varchar(100),@price int)
as
begin
insert into tbl_products values(@name,@price)
return @@identity
end

create proc p_FindProductIDs
as
begin
select ProductID from tbl_products
end

create proc p_FindProductPrice(@pid int)
as
begin
select ProductPrice from tbl_products where ProductID=@pid
end


--orders
alter proc p_AddOrder(@email varchar(100),@pid int,@pprice int,@qty int)
as
begin
insert into tbl_orders values(@email,@pid,@pprice,@qty,GETDATE())
return @@identity
end

create proc p_ShowOrders(@email varchar(100))
as
begin
select o.OrderID,o.CustomerEmailID,o.OrderDate,p.ProductID,p.ProductName,p.ProductPrice,o.ProductQty
from tbl_orders o join tbl_products p
on o.ProductID=p.ProductID
where o.CustomerEmailID=@email
end



