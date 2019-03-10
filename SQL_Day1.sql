Create database batch10db
use batch10db

Create table tbl_employees
(
EmployeeID int,
EmployeeName varchar(100),
EmployeeCity varchar(100),
EmployeeSalary int,
EmployeeDOJ datetime
)

select * from tbl_employees;

insert into tbl_employees values(1001,'John','BGL',30000,'12/21/2018')
insert into tbl_employees values(1002,'Smith','TPT',45000,'05/14/2017')
insert into tbl_employees values(1003,'Ram','CTR',35000,'07/04/2016')
insert into tbl_employees values(1004,'Sam','CTR',50000,'02/21/2019')
insert into tbl_employees values(1005,'Sai','TPT',60000,'11/12/2015')
insert into tbl_employees values(1006,'San','CTR',null,'12/17/2017')

insert into tbl_employees(EmployeeID,EmployeeName,EmployeeDOJ)
values(1007,'KMM','06/12/2014')

select * from tbl_employees
where EmployeeCity='TPT'

select * from tbl_employees
where EmployeeSalary>30000
 
 select * from tbl_employees
 where EmployeeCity='TPT' and EmployeeSalary>30000 

 select * from tbl_employees
 where EmployeeCity='TPT' or EmployeeSalary>30000 

 --Projection
 select EmployeeID,EmployeeName from tbl_employees

 update tbl_employees set EmployeeSalary=EmployeeSalary+10000 
 where EmployeeID=1001

 update tbl_employees set EmployeeSalary=45000, EmployeeCity='BGL'
 where EmployeeID=1006

 delete tbl_employees where EmployeeID=1007

 truncate table tbl_employee

 drop table tbl_employees

sp_rename 'tbl_employees','tbl_employee'



 sp_help tbl_employees

 alter table tbl_employees 
 add EmployeeDept varchar(100)

 alter table tbl_employees 
 drop column EmployeeDept

 alter table tbl_employees
 alter column EmployeeName varchar(200)

 select * from tbl_employees
 where EmployeeID in(1001,1005,1003)

 select * from tbl_employees
 where EmployeeCity in('TPT','BGL')

 select * from tbl_employees
 
 select * from tbl_employees
 where EmployeeSalary is null;

 select * from tbl_employees
 where EmployeeSalary between 35000 and 50000;

 select * from tbl_employees
 order by EmployeeSalary desc

 select * from tbl_employees
 order by EmployeeSalary asc

 select * from tbl_employees
 order by EmployeeDOJ desc

 select * from tbl_employees
 order by EmployeeSalary desc,EmployeeDOJ asc

 select top 1 * from tbl_employees
 order by EmployeeSalary desc

 select top 1 with ties * from tbl_employees
 order by EmployeeSalary desc

 select EmployeeID,EmployeeName,len(EmployeeName) as LN
 from tbl_Employees

 select EmployeeID,EmployeeName,substring(EmployeeName,1,2)
 from tbl_Employees

 select EmployeeID,EmployeeName,lower(EmployeeName)
 from tbl_Employees

 select EmployeeName,upper(EmployeeName)
 from tbl_employees

 select EmployeeName,left(EmployeeName,2)
 from tbl_employees

 select EmployeeName,right(EmployeeName,2)
 from tbl_employees

 select EmployeeName,ISNUMERIC(EmployeeSalary)
 from tbl_employees

 select ceiling(25.20)

 select FLOOR(26.99)

 select ROUND(253.2595,3)

 select EmployeeName,ISNULL(EmployeeSalary,0)
 from tbl_employees

 select * from 
 tbl_employees 
 order by len(EmployeeName) desc

 select sum(EmployeeSalary)
 from tbl_employees

 select avg(EmployeeSalary)
 from tbl_employees

 select max(EmployeeSalary)
 from tbl_employees

 select min(EmployeeSalary)
 from tbl_employees

 select COUNT(*)
 from tbl_employees


 insert into tbl_employees values(1009,'Davis','Chennai',40000,getdate())

 select * from tbl_employees

 select dateadd(mm,10,GETDATE())

 select EmployeeID,EmployeeName,datediff(yy,EmployeeDOJ,getDate())
 from tbl_employees

 select EmployeeID,EmployeeName,datediff(yy,EmployeeDOJ,getDate())
 from tbl_employees
 order by datediff(yy,EmployeeDOJ,getDate()) desc

 select EmployeeID,DATEPART(mm,EmployeeDOJ) as Months from tbl_employees

 select EmployeeID,datename(mm,EmployeeDOJ) from tbl_employees

 select datename(dw,'12/17/1996')

 select * 
 from tbl_employees
 where datediff(mm,EmployeeDOJ,GETDATE())=0;

 select EmployeeCity,Count(*)
 from tbl_employees
 group by EmployeeCity

 select EmployeeCity,sum(EmployeeSalary)
 from tbl_employees
 group by EmployeeCity

 select EmployeeCity,count(*)
 from tbl_employees
 where EmployeeSalary>40000
 group by EmployeeCity
 having count(*)>1



create table tbl_accounts(AccointID int identity(1000,1),CustomerName varchar(100),AccountBalance int)

insert into tbl_accounts values('San',20000)
insert into tbl_accounts values('Sai',25000)
insert into tbl_accounts values('Manoj',30000)
insert into tbl_accounts values('Siva',22000)

select @@IDENTITY

--1. Create a Database named "Emp_DB"
create database Emp_DB
use Emp_DB


