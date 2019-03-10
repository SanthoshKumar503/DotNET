
--Day 1 and Part1+++++++++++++++++Emp_DB-database++++++++Employees-table++++++++++++

--1. Create a Database named "Emp_DB"
create database Emp_DB
use Emp_DB

--2. Create a Table named "Employees"
create table Employees(EmployeeID int identity(1000,1),EmployeeFName varchar(100),
EmployeeLName varchar(100),EmployeeCity varchar(100),EmployeeDOB datetime,
EmployeeSalary int,EmployeeStatus varchar(100),EmployeeDOJ datetime)

--3. Add  columns named EmployeeDept & EmployeeDOJ in the tbl_Employees table
alter table Employees
add EmployeeDept varchar(100)

--4. Insert some records in the Employees table(min 10 rows)
insert into Employees values('Santhosh','Kumar','Chittoor','12/17/1996',35000,'Active','07/16/2015','D01')
insert into Employees values('Siva','siv','Bangalore','11/17/1996',45000,'Active','07/18/2014','D10')
insert into Employees values('Manoj','Kumar','Palamaner','07/02/1996',40000,'Active','10/12/2016','D09')
insert into Employees values('Sai','Nagala','Tirupati','08/22/1995',35000,'Active','07/16/2015','D01')
insert into Employees values('Mega','Dayal','Patna','07/07/1996',50000,'Active','09/16/2017','D02')
insert into Employees values('Prathima','Abburi','Ongole','02/06/1997',25000,'Active','04/17/2018','D03')
insert into Employees values('Supraba','Sup','Udipi','01/02/1995',42000,'Active','04/17/2017','D03')
insert into Employees values('Ram','Nadh','Produtur','03/15/1997',20000,'In Active','05/16/2018','D06')
insert into Employees values('Vinay','Kumar','Kadapa','06/28/1997',55000,'Active','02/28/2019','D01')
insert into Employees values('Vivek','Nani','Nellore','08/28/1997',50000,'In Ative','07/16/2015','D03')

--5. Create a List of employees from 'Bangalore' City
select * from Employees
where EmployeeCity='Bangalore'

--6. Create a List of employees whose salary is between 25000 and 50000
select * from Employees
where EmployeeSalary between 25000 and 50000

--7. Create a List of employees (EmployeeFullName , EmployeeID , EmployeeCity)
select EmployeeFName+' '+EmployeeLName as EmployeeFullName, EmployeeID, EmployeeCity
from Employees

--8. Create a List of employees in the employeesalary desc order
select * from Employees
order by EmployeeSalary desc

--9. Create a List of employees in the employeecity asc order
select * from Employees
order by EmployeeCity asc

--10. Create a List of Employees in the ascending order based on the length of their first name.
select * from Employees
order by len(EmployeeFName) asc

--11. Show the employee details who is getting maximum/highest salary
select top 1 with ties * from Employees
order by EmployeeSalary desc

--12. Retrieve the sum of salary.
select sum(EmployeeSalary) as SumOfSalary
from Employees

--13. Retrieve the total number of employees.
select count(*) as NumberOfEmployees
from Employees

--14. Create a List of employees who joined in Current Month.
select * from Employees
where datediff(mm,EmployeeDOJ,GETDATE())=0

--15. Create a List of employees whose experience is more than 3 years.
select * from Employees
where datediff(yy,EmployeeDOJ,GEtdate())>3

--16. Create a List of employee department names with no of employees
select EmployeeDept,count(*)
from Employees
group by EmployeeDept

--17. Create a List of employee cities with count of employees
select EmployeeCity,count(*)
from Employees
group by EmployeeCity

--18. Update some employees city from palamaner to Bangarole
update Employees
set EmployeeCity='Bangalore'
where EmployeeCity='Palamaner'

--19. Create a List of employee department with sum of salary where sum of salary is more than 50000
select EmployeeDept,sum(EmployeeSalary)
from Employees
group by EmployeeDept
having sum(EmployeeSalary)>50000

--20. Change the status of some employee from working to resigned.
update Employees
set EmployeeStatus='Resigned'
where EmployeeDept='D03'

--21. Create a List of Employees who have joined in the current month.
select * from Employees
where datediff(mm,EmployeeDOJ,getdate())=0



select * from Employees




--Part2+++++++++++Students_DB---Database++++++++tbl_Students--Table

--1. Create a Database named "Students_DB"
create database Students_DB
use Students_DB

--2. Create a Table named "tbl_Students"
create table tbl_Students(StudentID int identity(100,1),StudentName varchar(100),StudentCity varchar(100),StudentDept varchar(100),
StudentDOB date,StudentJOD date,StudentStatus varchar(100),Marks_10th int,Marks_12th int)

--3. Insert some records in the tbl_Students table(min 10 rows)
insert into tbl_Students values('Santhosh','Bangalore','CSE','12/17/1996','07/16/2015','Active',90,78)
insert into tbl_Students values('Sai','Tirupati','CSE','08/07/1995','06/21/2014','Active',95,88)
insert into tbl_Students values('Siva','Bangalore','IT','09/05/1995','07/06/2014','Active',75,85)
insert into tbl_Students values('Manoj','Bangalore','CSE','05/21/1994','08/05/2013','In Active',81,89)
insert into tbl_Students values('Supraba','Chennai','IT','02/02/1995','03/01/2019','Active',92,79)
insert into tbl_Students values('Pratima','Hyderabad','CSE','11/03/1996','03/01/2019','Active',75,96)
insert into tbl_Students values('Megha','Chennai','IT','04/23/1997','03/02/2019','Active',70,80)
insert into tbl_Students values('Ram','Hyderabad','CIVIL','08/15/1997','02/22/2018','In Active',95,98)
insert into tbl_Students values('Vinay','Hyderabad','CIVIL','08/15/1997','02/28/2018','Active',92,91)
insert into tbl_Students values('Sandeep','Tirupathi','CSE','07/28/1996','07/16/2015','In Active',90,95)

--4. Create a List of students from 'BGL' City
Select * from tbl_Students
where StudentCity='Bangalore'

--5. Create a List of students whose 12th Marks is between 60 and 80
select * from tbl_Students
where Marks_12th between 60 and 85

--6. Create a List of students (StudentID , StudentName , StudentDOB, STudentStatus)
select StudentID,StudentName,StudentDOB,StudentStatus
from tbl_Students

--7. Create a List of students in the descending order based on the 12th marks and if the marks is same then sort again as per the 10th marks descending order.
select * from tbl_Students
order by Marks_12th desc, Marks_10th desc

--8. Retrieve the total numbers of students.
select count(*) as TotalNumberOfStudents
from tbl_Students

--9. Create a List of students who joined in Current Month.
select * from tbl_Students
where datediff(mm,StudentJOD,getdate())=0

--10. Create a List of students who joined 4 years ago.
select * from tbl_Students
where datediff(yy,StudentJOD,getdate())=4

--11. Create a List of students department names with no of students
select StudentDept,Count(*) as CountOFStudents
from tbl_Students
group by StudentDept

--12. Create a List of student cities with count of students
select StudentCity,Count(*) as CountOFStudents
from tbl_Students
group by StudentCity

--13. Update some students city from Tirupathi to Pune
update tbl_Students
set StudentCity='Pune'
Where StudentCity='Tirupathi'

--14. Create a List of students department with avg of 12th mark where avg of 12th mark is more than 50
select StudentDept,avg(Marks_12th)
from tbl_Students
group by StudentDept
having avg(Marks_12th)>90;

--15. Create a Table tbl_Courses (StudentID , CourseName , Duration ) - Add Some records  
create table tbl_Courses(StudentID int,CourseName varchar(100),Duration int)

insert into tbl_Courses values(1,'DotNet',2)
insert into tbl_Courses values(2,'Csharp',3)
insert into tbl_Courses values(1,'SQL',1)
insert into tbl_Courses values(1,'Java',4)
insert into tbl_Courses values(2,'JavaScript',1)
insert into tbl_Courses values(3,'Python',5)

--16. Create a List of Students (StudentID , NoOfCourses).
select StudentID,count(*) as NoOfCourses
from tbl_Courses
group by StudentID

--17. Change the status of some students from Trainee to completed.
update tbl_Students
set StudentStatus='Active'
where StudentStatus='In Active'

--18. Create a List of Students who have joined in the current month.
select * from tbl_Students
where datediff(mm,StudentJOD,getDate())=0



select * from tbl_Students

select * from tbl_Courses