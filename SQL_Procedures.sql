use batch10db

select * from tbl_employees

create proc p_employees
as
begin
select * from tbl_employees
end

 exec p_employees

 --alter already created procedure
alter proc p_employees(@city varchar(100))
as
begin
select * from tbl_employees where EmployeeCity=@city
end

 exec p_employees 'BGL'




 select * from tbl_accounts

--add acount
 create proc p_addaccounts(@name varchar(100),@balance int)
 as
 begin
 insert tbl_accounts values(@name,@balance)
 return @@identity
 end

 declare @id int
 exec @id=p_addaccounts 'Cena',25000
 select @id

 --update
 create proc P_updateaccounts(@id int,@amt int)
 as
 begin
  update tbl_accounts set AccountBalance=AccountBalance+@amt
  where AccointID=@id
  return @@rowcount
  end

declare @rcount int
exec @rcount=P_updateaccounts 1001,2323
select @rcount

--delete
 create proc P_deleteaccount(@id int)
 as
 begin
  delete tbl_accounts 
  where AccointID=@id
  return @@rowcount
  end

declare @count int
exec @count=P_deleteaccount 1001
select @count


--multy
 alter proc P_updateaccounts(@id int,@name varchar(100),@amt int)
 as
 begin
 declare @count int=0
update tbl_accounts set CustomerName=@name, AccountBalance=AccountBalance+@amt where AccointID=@id
set @count=@count+@@IDENTITY
--update tbl_accounts set CustomerName=@name, AccountBalance=AccountBalance+@amt where AccointID=@id
 --set @count=@count+@@IDENTITY 
  return @count
  end

  declare @c int
  exec @c=P_updateaccounts 1002,'ABCD',50000
  select @c



--
create proc p_accounts
as 
begin
select * from tbl_accounts
end


exec p_accounts


create proc p_accountdetails(@id int)
as
begin
select * from tbl_accounts where AccointID=@id
end

--call by value
exec p_accountdetails 1002


create proc p_employeename(@id int,@name varchar(100) output)
as
begin
select @name=EmployeeName from tbl_employees where EmployeeID=@id
end

declare @name varchar(100)
exec p_employeename 1001,@name output
select @name



alter proc p_search(@key varchar(100))
as
begin
select * from tbl_employees where EmployeeID like @key or EmployeeName like '%'+@key+'%'
end

select * from tbl_employees


exec p_search 'an'







---Assignment 
--create table
create proc p_createtable
as
begin
create table tbl_Customer(CustomerID int identity(1000,1) primary key,
CustomerName varchar(100) not null,
CustomerCity varchar(100) not null,
CustomerPassword varchar(100) check(CustomerPassword>3) not null,
CustomerMobileNo varchar(100) not null)
end

exec p_createtable

--Insert
create proc p_addcustomer(@name varchar(100),@city varchar(100),@pass varchar(100),@mob varchar(100))
as
begin
insert into tbl_customer values(@name,@city,@pass,@mob)
return @@identity
end

declare @cname varchar(100)='Dummy',@ccity varchar(100)='Hyderabad',
@cpass varchar(100)='2568',@cmob varchar(100)='0000000000'
declare @id int
exec @id=p_addcustomer @cname,@ccity,@cpass,@cmob
select @id


--display
create proc p_showcustomers
as
begin
select * from tbl_customer
end

exec p_showcustomers

--Update(take id,update city)
alter proc p_updatecustomers(@id int,@city varchar(100))
as
begin
update tbl_customer set CustomerCity=@city where CustomerID=@id
return @@rowcount
end

declare @cid int=1003,@ccity varchar(100)='Chennai',@row int
exec @row=p_updatecustomers @cid,@ccity
select @row

--Delete
create proc p_deletecustomer(@id int)
as
begin
delete tbl_customer where CustomerID=@id
return @@rowcount
end

declare @cid int=1008,@row int
exec @row=p_deletecustomer @cid
select @row

--search
alter proc p_searchcustomer(@key varchar(100))
as
begin
select * from tbl_customer where CustomerID like @key or CustomerName like '%'+@key+'%' or 
CustomerMobileNo 
end

declare @ckey varchar(100)='san'
exec p_searchcustomer @ckey

--Read
create proc p_readid(@id int)
as
begin
select * from tbl_customer where CustomerID=@id
end

exec p_readid 1001


--
create proc p_readidcity(@city varchar(100))
as
begin
select * from tbl_customer where CustomerCity=@city
end

exec p_readidcity 'Bangalore'


--read name from table
create proc p_readname(@id int,@name varchar(100) output)
as
begin
select @name=CustomerName from tbl_customer where CustomerID=@id
end

declare @cid int=1000,@cname varchar(100)
exec p_readname @cid,@cname output
select @cname








--functions
create table tbl_students
(
StudentID int identity(1000,1) primary key,
StudentFName varchar(100),
StudentLName varchar(100),
StudentCity varchar(100),
StudentDOB datetime
)

insert into tbl_students values('John','Jo','Chennai','12/12/1998')
insert into tbl_students values('Smith','Sm','Bangalore','06/22/1996')
insert into tbl_students values('San','Sa','Bangalore','12/17/2000')
insert into tbl_students values('Kane','Ko','Chennai','10/12/1978')
insert into tbl_students values('Smile','Sm','Bangalore','04/02/1996')
insert into tbl_students values('Sam','Sm','Bangalore','10/10/2000')

select * from tbl_students
--fullname
create function f_fullName(@fname varchar(100),@lname varchar(100))
returns varchar(200)
as
begin
declare @fullname varchar(500)
set @fullname=@fname+' '+@lname
return @fullname
end

select studentid,dbo.f_fullName(studentfname,studentlname)as FullName FROM tbl_students

--age
create function getAge(@dob datetime)
returns int
as
begin
declare @age int
set @age=datediff(yy,@dob,getdate())
return @age
end

select studentid,studentfname,dbo.getAge(studentdob) from tbl_students


--inline func
create function f_students(@city varchar(100))
returns table
as
return select studentid,studentfname,studentcity from tbl_students
where StudentCity=@city

select * from dbo.f_students('Chennai')


create function f_studentsdata()
returns @tab table(id int,name varchar(100))
as 
begin
insert @tab values(100,'A')
insert @tab values(200,'B')
insert into @tab select StudentID,StudentFName from tbl_students
return
end

select * from dbo.f_studentsdata()



--Triggers
alter trigger trg_insert_student --use create instead of alter
on tbl_students
for insert
as
begin
select 'Trigger Fired';
select * from inserted
select * from deleted
end

insert into tbl_students values('Rosy','Tailor','Bgl','12/12/2002')

select * from tbl_students




create table stock
(
itemid int primary key,
itemqty int
)
insert into stock values(1,100)
insert into stock values(2,100)

select * from stock
select * from tbl_orders

create table tbl_orders
(
OrderID int identity(1000,1) primary key,
ItemID int,
ItemPrice int,
ItemQty int
)

insert tbl_orders values(1,100,10)

alter trigger tgr_stock_update
on tbl_orders
for insert
as
begin
declare @id int,@qty int
select @id=ItemID ,@qty=ItemQty from inserted
update stock set itemqty=itemqty-@qty where itemid=@id
declare @stockqty int
select @stockqty=itemqty from stock where itemid=@id
if(@stockqty<0)
begin
rollback tran
end
end


insert into tbl_orders values(2,200,10)