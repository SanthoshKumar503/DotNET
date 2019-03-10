create database b10_ado_customer
use b10_ado_customer

create table tbl_cutomers
(
CustomerID int identity(1000,1) primary key,
CustomerName varchar(100) not null,
CustomerPassword varchar(100) not null,
CustomerCity varchar(100) not null,
CustomerMobileNo varchar(100) unique not null,
CustomerEmailID varchar(100) unique not null
)


alter proc p_addcustomer(@name varchar(100),@psw varchar(100),@city varchar(100),@mobileno varchar(100),@email varchar(100))
as
begin
insert into tbl_cutomers values(@name,@psw,@city,@mobileno,@email)
return @@identity
end


create proc p_findcustomer(@id int)
as
begin
select * from tbl_cutomers where CustomerID=@id
end


create proc p_searchcustomer(@key varchar(100))
as
begin
select * from tbl_cutomers where CustomerID like @key or CustomerName like '%'+@key+'%' or CustomerCity like '%'+@key+'%'
end


create proc p_updatecustomer(@id int,@name varchar(100),@psw varchar(100),@city varchar(100),@mobileno varchar(100),@email varchar(100))
as
begin
update tbl_cutomers set CustomerName=@name,CustomerPassword=@psw,CustomerCity=@city,CustomerMobileNo=@mobileno,CustomerEmailID=@email
where CustomerID=@id
return @@rowcount
end


create proc p_deletecustomer(@id int)
as
begin
delete tbl_cutomers where CustomerID=@id
return @@rowcount
end


create proc p_logincustomer(@id int,@psw varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_cutomers where CustomerID=@id and CustomerPassword=@psw
return @count
end



create proc p_getname(@id int)
as
begin
select CustomerName from tbl_cutomers where CustomerID=@id
end


create proc p_getcustomersids
as
begin
select CustomerID from tbl_cutomers
end
