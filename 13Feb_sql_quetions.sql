use w3schools
--Question -1

select * from 
employees
where notes
like '%[^(A-Z)]BA%'


--Question -2
select FirstName,LastName, COUNT([No. of orders]) as Order_processed,SUM([Total amount]) as Amount
FROM
(select emp.FirstName, emp.LastName,ord.OrderID,COUNT(OrderID) as [No. of orders]
from employees emp
join orders ord
on emp.EmployeeID =ord.EmployeeID
GROUP by ord.OrderID,emp.FirstName, emp.LastName,OrderID)
AS EMPO
join
(select OrderID, Quantity*Price as [Total amount]
from order_details
join products
on products.ProductID=order_details.ProductID
)
as ORD
on 
EMPO.OrderID=ORD.OrderID
group by FirstName,LastName

--Question -3

select emp.FirstName,emp.LastName FROM
employees emp
JOIN orders ord
on emp.EmployeeID =ord.EmployeeID
where ord.OrderDate >= '1996-07-08'


--Question -4

select distinct CustomerName
from customers cust
JOIN orders ord
on cust.CustomerID = ord.CustomerID
join order_details ordd
on ord.OrderID = ordd.OrderID
join products prd
on ordd.ProductID = prd.ProductID
where ProductName = 'Tofu'
ORDER by CustomerName DESC

--Question -5

select SupplierName
from suppliers
WHERE City LIKE 'S%' and Country LIKE '[^S]%'

--Question -6
select FirstName, LastName
from employees
where BirthDate between '1953-01-01' and '1960-01-01'


-- --Question -7
select shipperName, SUM((ordd.Quantity*prd.Price)) as [Total amount], COUNT(ord.OrderID) as [No of Order_processed]
from products prd
join order_details ordd
on prd.ProductID = ordd.ProductID
JOIN orders ord
on ord.OrderID = ordd.OrderID
join shippers ship
on ship.ShipperID = ord.ShipperID
GROUP by ship.ShipperName

--Question -8
select CustomerName
from customers cust 
left join orders ord
on  cust.CustomerID = ord.CustomerID
where ord.OrderID IS NULL

--Question -9
select CustomerName, COUNT(ord.OrderID) as Orders
from customers cust 
left join orders ord
on  cust.CustomerID = ord.CustomerID
group BY CustomerName
HAVING COUNT(ord.OrderID) >= 5


--Question -10

select CustomerName, SUM((ordd.Quantity*prd.Price))/COUNT(ord.OrderID) as [Average order]
from customers cust
join orders ord
on cust.CustomerID = ord.CustomerID
join order_details ordd
on ord.OrderID = ordd.OrderID
join products prd
on ordd.ProductID = prd.ProductID
GROUP by CustomerName
having SUM((ordd.Quantity*prd.Price))/COUNT(ord.OrderID) >=1000












