create database b10_ado

use b10_ado


create table tbl_employees
(
EmployeeID int identity(1000,1) primary key,
EmployeeName varchar(100) not null,
EmployeePassword varchar(100) not null,
EmployeeCity varchar(100) not null
)


create proc p_addemployee(@name varchar(100),@psw varchar(100),@city varchar(100))
as
begin
insert into tbl_employees values(@name,@psw,@city)
return @@identity
end


create proc p_find(@id int)
as
begin
select * from tbl_employees where EmployeeID=@id
end

create proc p_search(@key varchar(100))
as
begin
select * from tbl_employees where EmployeeID like @key or EmployeeName like '%'+@key+'%' or EmployeeCity like '%'+@key+'%'
end


create proc p_login(@id int,@psw varchar(100))
as
begin
declare @count int
select @count=count(*) from tbl_employees where EmployeeID=@id and EmployeePassword=@psw
return @count
end

--
create proc p_update(@id int,@name varchar(100),@city varchar(100))
as
begin
update tbl_employees set EmployeeName=@name,EmployeeCity=@city where EmployeeID=@id
return @@rowcount
end


create proc p_delete(@id int)
as
begin
delete tbl_employees where EmployeeID=@id
return @@rowcount
end

create proc p_getname(@id int)
as
begin
select EmployeeName from tbl_employees where EmployeeID=@id
end


create proc p_getids
as
begin
select EmployeeID,EmployeeName from tbl_employees
end




select * from tbl_employees