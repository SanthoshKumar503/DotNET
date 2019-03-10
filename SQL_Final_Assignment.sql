--Create MyBankDB
create database MyBankDB

use MyBankDB

--1. tbl_Employees with Auto Gen EmployeeID
create table tbl_Employees
(
EmployeeID int identity(100,1) primary key, 
EmployeeName varchar(100) not null, 
EmployeeCity varchar(100) not null, 
EmployeeDesignation varchar(100) not null, 
EmployeeDOB date not null, 
EmployeeDOJ date not null, 
EmployeeSalary int not null check(employeesalary>0)
)

insert into tbl_Employees values('Santhosh','Bangalore','Manager','12/17/1996','07/16/2015',150000)
insert into tbl_Employees values('Mustaq','Chennai','General Manager','10/10/1997','07/16/2015',100000)
insert into tbl_Employees values('Sai','Chennai','General Manager','02/12/1995','08/10/2014',100000)
insert into tbl_Employees values('Vivek','Bangalore','Associate Manager','11/12/1997','01/10/2015',100000)
insert into tbl_Employees values('Ramu','Bangalore','Cashier','11/12/1997','01/10/2015',80000)
insert into tbl_Employees values('Nani','Bangalore','Cashier','05/25/1996','01/10/2018',80000)
insert into tbl_Employees values('Vihana','Pune','Cashier','05/03/1999','03/03/2019',50000)

select * from tbl_Employees

--2. tbl_Customers with Auto gen CustomerID
create table tbl_Customers
(
CustomerID int identity(1000,1) primary key, 
CustomerName varchar(100) not null, 
CustomerCity varchar(100) not null, 
CustomerAddress varchar(100) not null, 
CustomerMobileNo varchar(100) unique not null, 
PAN varchar(100) unique not null, 
CustomerPassword varchar(100) not null, 
CustomerEmailID varchar(100) unique not null , 
ApprovedBy int foreign key references tbl_Employees(EmployeeID)
)

alter table tbl_Customers alter column CustomerMobileNo varchar(100) not null;

alter table tbl_customers drop constraint CK__tbl_Custo__Custo__3D5E1FD2

 select * from tbl_customers
 sp_help tbl_Customers


insert into tbl_Customers values('John','Bangalore','Marathahalli','9658612345','JOHN123','2658','john@g.com',100)
insert into tbl_Customers values('Cena','Chennai','Tnagar','8858612345','CENA123','8657','cena@g.com',102)
insert into tbl_Customers values('Peter','Bangalore','BTM','7858612345','PTER123','8624','petr@g.com',100)
insert into tbl_Customers values('Alen','Bangalore','JP Nagar','9858612345','ALEN123','8024','alen@g.com',100)
insert into tbl_Customers values('Rosy','Pune','pune','7358612345','ROSY123','1124','rosy@g.com',101)
insert into tbl_Customers values('Romen','Chennai','Tnagar','8652365987','ROME123','8520','rome@g.com',102)
insert into tbl_Customers values('Lucy','Chennai','Tnagar','8882365987','LUCY123','1020','lucy@g.com',106)
insert into tbl_Customers values('Lyon','Bangalore','Silk board','8859825987','LYON123','1010','lyon@g.com',107)
insert into tbl_Customers values('Kane','Tirupati','Auto nagar','7788365987','KANE123','1000','kane@g.com',100)
insert into tbl_Customers values('Will','Tirupati','Auto nagar','9988365987','WILL123','1000','will@g.com',102)



select * from tbl_Customers

--3. tbl_AccountInfo with auto gen AccountID
create table tbl_AccountInfo
(
AccountID int identity(10000,1) primary key,
CustomerID int foreign key references tbl_Customers(CustomerID),
AccountType varchar(100) check(accounttype in('Savings','Current')) not null,
AccountBalance int check(AccountBalance>0),
AccountOpenDate date not null, 
AccountStatus varchar(100) check(AccountStatus in('Open','Closed','Blocked'))
) 

insert into tbl_AccountInfo values(1006,'Savings',50000,'12/28/2018','Open')
insert into tbl_AccountInfo values(1006,'Current',10000,'02/28/2019','Open')
insert into tbl_AccountInfo values(1010,'Savings',75000,'03/03/2019','Open')
insert into tbl_AccountInfo values(1007,'Savings',25000,'02/28/2019','Open')
insert into tbl_AccountInfo values(1007,'Current',25000,'02/28/2019','Open')
insert into tbl_AccountInfo values(1009,'Savings',5000,'02/28/2015','Closed')
insert into tbl_AccountInfo values(1010,'Savings',75000,'03/03/2019','Open')
insert into tbl_AccountInfo values(1011,'Current',15000,'03/03/2019','Open')
insert into tbl_AccountInfo values(1014,'Savings',10,'03/03/2016','Blocked')
insert into tbl_AccountInfo values(1015,'Current',100,'01/03/2018','Closed')

select * from tbl_AccountInfo


--4. tbl_TransactionInfo with Auto gen TransactionID
create table tbl_TransactionInfo
(
TransactionID int identity(100000,1) primary key,
AccountID int foreign key references tbl_AccountInfo(AccountID) not null,
TransactionType varchar(100) check(TransactionType in('Debit','Credit')) not null, 
Amount int check(Amount>0) not null,
TransactionDate date not null
)

insert into tbl_TransactionInfo values(10000,'Debit',5000,'12/12/2018')
insert into tbl_TransactionInfo values(10000,'Debit',10000,'01/12/2019')
insert into tbl_TransactionInfo values(10000,'Credit',5000,'12/12/2018')
insert into tbl_TransactionInfo values(10002,'Debit',8000,'12/12/2017')
insert into tbl_TransactionInfo values(10000,'Debit',1000,'01/12/2016')
insert into tbl_TransactionInfo values(10002,'Credit',2000,'12/12/2019')
insert into tbl_TransactionInfo values(10005,'Debit',3000,'10/12/2016')
insert into tbl_TransactionInfo values(10008,'Debit',10000,'01/07/2016')
insert into tbl_TransactionInfo values(10004,'Credit',20000,'12/12/2018')

select * from tbl_TransactionInfo

--1. Latest 5 transactions of an account (Enter Account ID as an Input).
   -- Use a Stored Procedure
alter proc p_latest_transan(@id int)
as
begin
select top 2 * from tbl_TransactionInfo where AccountID=@id
order by TransactionDate desc
end

declare @cid int=10000
exec p_latest_transan @cid


--2. Transaction between two dates of an account (Enter Account ID as an Input)
   -- Use a Stored Procedure

alter proc p_transacton_between(@id int,@date1 date,@date2 date)
as
begin
select * from tbl_TransactionInfo where AccountID=@id and TransactionDate between @date1 and @date2
end

declare @cid int=10000, @d1 date='12/12/2017',@d2 date='03/04/2019'
exec p_transacton_between @cid,@d1,@d2


--3. List of Accounts of a Customer (Enter Customer ID as an input)
   -- Use a Stored Procedure

alter proc p_customers_list(@id int)
as
begin
select * from tbl_AccountInfo
where CustomerID =@id
end

declare @cid int = 1006
exec p_customers_list @cid

--4. List of customers(CustomerID,CustomerName,CustomerAddress,CustomerMobileNo, AccountID , AccountBalance).
   -- Use a Stored Procedure

create proc p_cust_account_info
as
begin
select c.CustomerID,c.CustomerName,c.CustomerAddress,c.CustomerMobileNo,a.AccountID ,a.AccountBalance
from tbl_Customers c join tbl_AccountInfo a
on c.CustomerID=a.CustomerID
end

exec p_cust_account_info


--5. List of accounts with transactions (AccountID , AccountBalance , TransID , Amount, TransationType).
   -- Use a Stored Procedure

create proc p_accinfo_traninfo
as
begin
select a.AccountID , a.AccountBalance , t.TransactionID , t.Amount, t.TransactionType
from tbl_AccountInfo a join tbl_TransactionInfo t
on a.AccountID=t.AccountID
end

exec p_accinfo_traninfo

--6. List of customers with accounts and transations (CustomerID,CustomerName,CustomerAddress,CustomerMobileNo, AccountID ,
-- AccountBalance,TransationID , Amount, TransationType)
-- Use a Stored Procedure

create proc p_cust_acc_tran_info
as
begin
select c.CustomerID,c.CustomerName,c.CustomerAddress,c.CustomerMobileNo, a.AccountID ,a.AccountBalance,
t.TransactionID , t.Amount, t.TransactionType
from tbl_Customers c join tbl_AccountInfo a
on c.CustomerID=a.CustomerID
join tbl_TransactionInfo t
on a.AccountID=t.AccountID
end

exec p_cust_acc_tran_info


--7. List of Customers who have accounts
   -- Use a Stored Procedure

create proc p_customers_who_account
as
begin
select * from tbl_Customers
where CustomerID in(select CustomerID from tbl_AccountInfo)
end

exec p_customers_who_account


--8. List of Customer who have no account.
   -- Use a Stored Procedure

create proc p_customers_not_account
as
begin
select * from tbl_Customers
where CustomerID not in(select CustomerID from tbl_AccountInfo)
end

exec p_customers_not_account


--9. List of Account which has transaction.
   -- Use a Stored Procedure
create proc p_has_trans_acc
as
begin
select * from tbl_AccountInfo 
where AccountID in(select AccountID from tbl_TransactionInfo)
end

exec p_has_trans_acc


--10. List of Account which has no transaction
   -- Use a Stored Procedure

create proc p_no_trans_acc
as
begin
select * from tbl_AccountInfo 
where AccountID not in(select AccountID from tbl_TransactionInfo)
end

exec p_no_trans_acc


--11. Create two views named v_account_saving and v_account_current
--savings

create view v_account_saving
as
select * from tbl_AccountInfo where AccountType='Savings'

select * from v_account_saving

--current
create view v_account_current
as
select * from tbl_AccountInfo where AccountType='Current'

select * from v_account_current


--12. Create a procedure for getting accountbalance using output parameter  by passing accountid as input parameter.
alter proc p_get_acc_bal(@id int,@bal int output)
as
begin
select @bal=AccountBalance from tbl_AccountInfo where AccountID=@id
end

declare @cid int=10000,@abal int
exec p_get_acc_bal @cid,@abal output
select @abal



--13. Create a trigger for updating the account balance as per the type transaction.

alter trigger trg_upadte_bal
on tbl_TransactionInfo
for insert
as
begin
declare @id int,@balance int,@type varchar(100)
select @id=AccountID,@balance=Amount,@type=TransactionType from inserted
if(@type='Credit')
begin
update tbl_AccountInfo set AccountBalance=AccountBalance+@balance where AccountID=@id
end
if(@type='Debit')
begin
update tbl_AccountInfo set AccountBalance=AccountBalance-@balance where AccountID=@id
end
end


select * from tbl_AccountInfo
select * from tbl_TransactionInfo

insert into tbl_TransactionInfo values(10000,'Debit',10000,'03/04/2019')
insert into tbl_TransactionInfo values(10000,'Credit',10000,'03/04/2019')

--14. Find the employee details who is getting maximum salary.
select top 1 with ties * from tbl_Employees
order by EmployeeSalary desc

--15. Find the employee details who is getting second maximum salary.
select top 1 with ties * from tbl_Employees
where EmployeeID in(select top 2 EmployeeID from tbl_Employees order by EmployeeSalary desc)
order by EmployeeSalary asc

--16. Find the account details which has maximum balanace.
select top 1 with ties * from tbl_AccountInfo
order by AccountBalance desc

--17. Find the account details which has second maximum balance.
select top 1 * from tbl_AccountInfo
where AccountID in(select top 2 AccountID from tbl_AccountInfo order by AccountBalance desc)
order by AccountBalance asc

select * from tbl_AccountInfo

--18. Create a List of (EmployeeID , EmployeeName , CustomerID , CustomerName , AccountID , AccountBalance)- Use Join
select e.EmployeeID , e.EmployeeName , c.CustomerID , c.CustomerName , a.AccountID , a.AccountBalance
from tbl_Employees e join tbl_Customers c
on e.EmployeeID=c.ApprovedBy 
join tbl_AccountInfo a
on c.CustomerID=a.CustomerID

--19. Create a List of (EmployeeDept , NoOfEmployees)
select EmployeeDesignation,count(*)
from tbl_Employees
group by EmployeeDesignation

--20. Create a List of (AccountNo , NoOfTransations)
select AccountID,count(*)
from tbl_TransactionInfo
group by AccountID