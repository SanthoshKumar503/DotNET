--creating OnlineFoodOrderingDB database
create database OnlineFoodOrderingDB
use OnlineFoodOrderingDB

--1. Create a Table called Restaurants
create table tbl_restaurants(
RestaurantID int identity(100,1) primary key,
RestaurantName varchar(100) not null,
RestaurantAddress Varchar(100) not null, 
RestaurantCity Varchar(100) not null, 
ContactNo varchar(100) not null
)
insert into tbl_restaurants values('Empire Restaurant','Marathahalli','Bangalore','9848736475')
insert into tbl_restaurants values('Kritunga Restaurant','BTM','Bangalore','8848736475')
insert into tbl_restaurants values('Andhra spice','Kukatpalli','Hyderabad','7848736475')
insert into tbl_restaurants values('Shanmukha Restaurant','Indira nagar','Bangalore','9948736475')
insert into tbl_restaurants values('A2B Restaurant','T Nagar','Chennai','7778736475')
insert into tbl_restaurants values('F2 Restaurant','Marathahalli','Bangalore','9848096475')

select * from tbl_restaurants

--2. Create a Table called RMenuItems
create table tbl_RMenuItems(
MenuID int identity(1000,1) primary key,
RestID int foreign key references tbl_restaurants(RestaurantID) not null, 
MenuName varchar(100) not null, 
MenuType varchar(100) not null, 
MenuCategory varchar(100) not null, 
MenuPrice int not null check(menuprice>0)
)

insert into tbl_RMenuItems values(100,'Biriyani','Buffet Menu','non veg',300)
insert into tbl_RMenuItems values(100,'Veg Biriyani','Buffet Menu','veg',200)
insert into tbl_RMenuItems values(101,'Hydrabad Biriyani','Buffet Menu','non veg',250)
insert into tbl_RMenuItems values(101,'Mogaloy Biriyani','Buffet Menu','non veg',350)
insert into tbl_RMenuItems values(101,'Special Biriyani','Buffet Menu','non veg',450)
insert into tbl_RMenuItems values(102,'Meals','Buffet Menu','non veg',150)
insert into tbl_RMenuItems values(102,'Sweets','Dessert Menu','non veg',100)
insert into tbl_RMenuItems values(102,'Ice cream','Buffet Menu','non veg',150)
insert into tbl_RMenuItems values(102,'Sambar Rice','Buffet Menu','non veg',250)
insert into tbl_RMenuItems values(102,'Gobi','Dessert Menu','non veg',150)
insert into tbl_RMenuItems values(104,'Meals','Buffet Menu','non veg',300)
insert into tbl_RMenuItems values(104,'Ice cream','Dessert Menu','non veg',250)




--3. Create a Table called Customers
create table tbl_customers(CustomerID varchar(100) primary key, 
CustomerName varchar(100) not null, 
CustomerCity varchar(100) not null, 
CustomerDOB date not null, 
CustomerGender varchar(100) check(CustomerGender in('male','female')) not null, 
CustomerPassword varchar(100) not null check(CustomerPassword>4)
)
insert into tbl_customers values('gsk@g.com','Santhosh','Bangalore','12/17/1996','male','1234')
insert into tbl_customers values('kum@g.com','Kumar','Bangalore','10/11/1995','male','1233')
insert into tbl_customers values('mus@g.com','Mustaq','Bangalore','10/11/1995','male','4233')
insert into tbl_customers values('tar@g.com','Tarun','Chennai','06/12/1996','male','4433')
insert into tbl_customers values('vih@g.com','Vihana','Bangalore','06/05/2000','female','9533')
insert into tbl_customers values('sup@g.com','Suprabha','Chennai','12/12/1995','female','1244')
insert into tbl_customers values('sai@g.com','Sai','Hyderabad','09/09/1995','male','8233')
insert into tbl_customers values('siv@g.com','Siva','Bangalore','04/11/1995','male','1293')


--4. Create a table called Orders
create table tbl_orders(
OrderID int identity(10000,1) primary key, 
CustomerID varchar(100) foreign key references tbl_customers(CustomerID), 
OrderDate date not null, 
DeliveryAddress varchar(100) not null, 
OrderStatus varchar(100) check(OrderStatus in('ordered','not ordered')) not null
)
insert into tbl_orders values('gsk@g.com','02/12/2019','Bangalore','ordered')
insert into tbl_orders values('gsk@g.com','02/12/2019','Bangalore','ordered')
insert into tbl_orders values('mus@g.com','02/18/2019','Bangalore','ordered')
insert into tbl_orders values('mus@g.com','02/22/2019','Bangalore','not ordered')
insert into tbl_orders values('vih@g.com','02/22/2019','Bangalore','ordered')
insert into tbl_orders values('vih@g.com','02/24/2019','Bangalore','ordered')
insert into tbl_orders values('gsk@g.com','02/25/2019','Bangalore','ordered')
insert into tbl_orders values('gsk@g.com','02/25/2019','Bangalore','not ordered')
insert into tbl_orders values('sai@g.com','02/26/2019','Chennai','ordered')
insert into tbl_orders values('gsk@g.com','02/26/2019','Hyderabad','not ordered')
insert into tbl_orders values('siv@g.com','02/28/2019','Chennai','ordered')
insert into tbl_orders values('vih@g.com','02/28/2019','Bangalore','ordered')
insert into tbl_orders values('gsk@g.com','03/02/2019','Bangalore','ordered')

--5. Create a table called OrderMenus
create table tbl_ordermenus(
OrderID int foreign key references tbl_orders(OrderID) not null, 
MenuID int foreign key references tbl_RMenuItems(MenuID) not null, 
MenuQty int check(MenuQty>0) not null, 
MenuPrice int check(MenuPrice>0) not null
primary key(OrderID,MenuID)
)

insert into tbl_ordermenus values(10000,1001,2,500)
insert into tbl_ordermenus values(10000,1002,3,500)
insert into tbl_ordermenus values(10001,1001,2,500)
insert into tbl_ordermenus values(10001,1004,5,1500)
insert into tbl_ordermenus values(10005,1003,2,500)
insert into tbl_ordermenus values(10007,1005,1,150)
insert into tbl_ordermenus values(10002,1001,2,500)
insert into tbl_ordermenus values(10003,1005,4,500)


--1. Show the list of Restaurant of specific city
select * from tbl_restaurants
where RestaurantCity='Bangalore'

--2. Show the list of all Restaurants along with menus (RestaurantID , RestaurantName ,MenuID , MenuName , MenuPrice)
select r.RestaurantID,r.RestaurantName,m.MenuID,m.MenuName,m.MenuPrice
from tbl_restaurants r left join tbl_RMenuItems m
on r.RestaurantID=m.RestID

--3. Show the list of  Restaurants along with menus (RestaurantID , RestaurantName ,
--MenuID , MenuName , MenuPrice) of specific city
select r.RestaurantID,r.RestaurantName,m.MenuID,m.MenuName,MenuPrice
from tbl_restaurants r join tbl_RMenuItems m
on r.RestaurantID=m.RestID

--4. Show the list of Orders of a specific customer (based on customerid)
select * from tbl_orders
where tbl_orders.CustomerID='gsk@g.com'

--5. Show the list of orders along with ordermenus (OrderID , CustomerID , OrderDate , MenuID , MenuQty , MenuPrice)
select o.OrderID,o.CustomerID,o.OrderDate,m.MenuID,m.MenuQty,m.MenuPrice
from tbl_orders o join tbl_ordermenus m
on o.OrderID=m.OrderID

--6. Show the list of latest 5 orders of a specific customer (based on CustomerID)
select top 5 *
from tbl_orders
where CustomerID='gsk@g.com'
order by OrderDate desc

--7. Show the list of menus in price ascending order.
select * from tbl_RMenuItems
order by tbl_RMenuItems.MenuPrice asc

--8. Show the list of cities along with number of restaurants
select RestaurantCity,count(*)
from tbl_restaurants
group by RestaurantCity

--9. Show the list of customers who never placed any order.
select * from tbl_customers
where CustomerID not in(select CustomerID from tbl_orders)

--10. Show the menuitem details which has highest menuprice.(First)
select * from tbl_RMenuItems
where MenuPrice in(select max(MenuPrice) from tbl_RMenuItems)
--or
select top 1 with ties * from tbl_RMenuItems
order by MenuPrice desc 

--11. Show the menuitem details which has second highest menuprice.(Second)
select top 1 with ties * from tbl_RMenuItems
where MenuPrice in(select top 2 MenuPrice from tbl_RMenuItems order by MenuPrice desc)
order by MenuPrice asc
