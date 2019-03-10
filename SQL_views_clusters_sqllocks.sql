
use batch10db



select * from tbl_students


--Copy one table to another with some rows
select StudentID,StudentFName,StudentLName
into tbl_NewStudents from tbl_students


--Copy without data
select * into tbl_NewStudents from tbl_students where 1=2

--Copy all
select * into tbl_NewStudents from tbl_students

select * from tbl_NewStudents
insert into tbl_NewStudents values('Romen','Ro','Pune','03/25/1990')




--copy only data

insert into tbl_NewStudents select studentfname,StudentLName,StudentCity,StudentDOB from tbl_students


--union--club two tables without repetition
select * from tbl_NewStudents
union
select * from tbl_students

--union--club two tables with repetition
select * from tbl_NewStudents
union all
select * from tbl_students

--intersect--common data with in both tables
select * from tbl_NewStudents
intersect
select * from tbl_students



--table1 minus(-) table2 shows remaining data
select * from tbl_NewStudents
except
select * from tbl_students





---views


create table tbl_customers
(
CustomerID int primary key identity(1,1),
CustomerName varchar(100),
CustomerCity varchar(100),
CustomerMobileNo varchar(100)
)

insert into tbl_customers values('John','Bangalore','98766')
insert into tbl_customers values('Smith','Chennai','98766')
insert into tbl_customers values('Sam','Bangalore','90456')
insert into tbl_customers values('Rohan','Bangalore','98766')
insert into tbl_customers values('Cena','Pune','77766')

select * from tbl_customers

--view ex
alter view v_customer_bangalore
with encryption,schemabinding  --for encription --prevent sp_helptext v_customer_bangalore
as
select CustomerID,CustomerName,CustomerCity,CustomerMobileNo from dbo.tbl_customers where CustomerCity='Bangalore' 
--order by CustomerID desc --not use in view
with check option --for preventing wrong insertion city--insert v_customer_bangalore values('Peter','Mumbai','90236')

drop table tbl_customers --error by schemabinding -view is using---Cannot DROP TABLE 'tbl_customers' because it is being referenced by object 'v_customer_bangalore'.

--alter table 

sp_helptext v_customer_bangalore

select * from v_customer_bangalore

insert v_customer_bangalore values('Rosy2','Bangalore','56236')

insert v_customer_bangalore values('Peter','Mumbai','90236')
--update --cando only with in view data only not other than view


create table t1
(
code int,
name varchar(100)
)

insert t1 values(1,'A')
insert t1 values(2,'B')

create table t2
(
code int,
city varchar(100),
)
insert t2 values(1,'BGL')
insert t2 values(2,'Pune')

select * from t1
create view v_join
as
select t1.code,t1.name,t2.city from t1 join t2 on t1.code=t2.code

select * from v_join

insert v_join values(3,'C','BGL')--it can not insert so use trigger


create trigger trg_v_join
on v_join
instead of insert 
as
begin
declare @id int
declare @name varchar(100)
declare @city varchar(100)
select @id=code,@name=name,@city=city from inserted
insert t1 values(@id,@name)
insert t2 values(@id,@city)
end

insert v_join values(3,'C','BGL')

select * from v_join





--Cluster
create table tbl_bills
(
BillNo int identity(1,1),
CustomerName varchar(100),
BillAmount int
)


declare @c int=0;
while(@c<100000)
begin
insert tbl_bills values('John',2000)
set @c=@c+1
end


create clustered index idx--with index
on tbl_bills(billno)

select * from tbl_bills where BillNo=50031



--transactions
begin tran tr1
insert t1 values(1000,'Abcd')
insert t2 values('1000x','chennai')
commit tran--rollback tran

select * from t1
select * from t2





--sql locks
select * from t1
select * from t2


begin tran tr1
insert t1 values(66,'efg')
select * from t1
rollback tran
commit tran