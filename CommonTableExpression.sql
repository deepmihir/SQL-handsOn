CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Gender nvarchar(10),
  DepartmentId int
)

CREATE TABLE tblDepartment
(
 DeptId int Primary Key,
 DeptName nvarchar(20)
)

Insert into tblDepartment values (1,'IT')
Insert into tblDepartment values (2,'Payroll')
Insert into tblDepartment values (3,'HR')
Insert into tblDepartment values (4,'Admin')


Insert into tblEmployee values (1,'John', 'Male', 3)
Insert into tblEmployee values (2,'Mike', 'Male', 2)
Insert into tblEmployee values (3,'Pam', 'Female', 1)
Insert into tblEmployee values (4,'Todd', 'Male', 4)
Insert into tblEmployee values (5,'Sara', 'Female', 1)
Insert into tblEmployee values (6,'Ben', 'Male', 3)

select * from tblEmployee
select * from tblDepartment

create view vW_EmployeeCount
as
select DeptName, DeptId, COUNT(*) as Total_Employee
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptId,DeptName

select DeptName, Total_Employee from vW_EmployeeCount
where Total_Employee >= 2


select DeptName, DeptId, COUNT(*) as Total_Employee
into #tempEmployeeCount
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptId,DeptName

select DeptName, Total_Employee from #tempEmployeeCount where Total_Employee >=2
drop table #tempEmployeeCount

declare @tbl_Employeecount table(DeptName nvarchar(10), DeptId int, Total_Employee int)
insert @tbl_Employeecount
select DeptName, DeptId, COUNT(*) as Total_Employee
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptId,DeptName

select DeptName, Total_Employee from @tbl_Employeecount where Total_Employee >=2


--using derived table
select DeptName, Total_Employee from
(
	select DeptName, DeptId, COUNT(*) as Total_Employee
	from tblEmployee
	join tblDepartment
	on tblEmployee.DepartmentId = tblDepartment.DeptId
	group by DeptId,DeptName
)
as EmployeeCount
where Total_Employee >=2	

--Common table expression
with cte_EmployeeCount
as
(
	 select DeptName, DeptId, COUNT(*) as Total_Employee
	from tblEmployee
	join tblDepartment
	on tblEmployee.DepartmentId = tblDepartment.DeptId
	group by DeptId,DeptName
)

select DeptName, Total_Employee from cte_EmployeeCount where Total_Employee >=2


with cte_Employee_payroll_IT(DeptName, Total_Employee)
as
(
	select DeptName, count(*) as Total_Employee
	from tblEmployee
	join tblDepartment
	on tblEmployee.DepartmentId= tblDepartment.DeptId
	where DeptName IN ('Payroll','IT')
	group by DeptName
	
),
cte_Employee_HR_Admin(DeptName, Total_Employee)
as
(
	select DeptName,COUNT(*) as Total_Employee
	from tblEmployee
	join tblDepartment
	on tblEmployee.DepartmentId= tblDepartment.DeptId
	where DeptName in ('HR','Admin')
	group by DeptName
	
)

select * from cte_Employee_payroll_IT
UNION
select * from cte_Employee_HR_Admin

--Recursive CTE

Create Table tblEmployee1
(
  EmployeeId int Primary key,
  Name nvarchar(20),
  ManagerId int
)

Insert into tblEmployee1 values (1, 'Tom', 2)
Insert into tblEmployee1 values (2, 'Josh', null)
Insert into tblEmployee1 values (3, 'Mike', 2)
Insert into tblEmployee1 values (4, 'John', 3)
Insert into tblEmployee1 values (5, 'Pam', 1)
Insert into tblEmployee1 values (6, 'Mary', 3)
Insert into tblEmployee1 values (7, 'James', 1)
Insert into tblEmployee1 values (8, 'Sam', 5)
Insert into tblEmployee1 values (9, 'Simon', 1)

select * from tblEmployee1

--simple to achieve is self join
select Employee.Name as Employee_Name, ISNULL(Manager.Name, 'Boss') as manager_name
from tblEmployee1 Employee
left join tblEmployee1 Manager
on Manager.ManagerId= Employee.EmployeeId 

--Implementing this using Recursive CTE
with EmployeesCTE(EmployeeId,Name,ManagerId, [Level])
as
(
	select EmployeeId,Name,ManagerId,1
	from tblEmployee1
	where ManagerId IS NULL

	UNION ALL
	Select tblEmployee1.EmployeeId, tblEmployee1.Name, tblEmployee1.ManagerId, EmployeesCTE.[Level]+1
	from tblEmployee1
	join EmployeesCTE
	on  tblEmployee1.ManagerId = EmployeesCTE.EmployeeId
)

select emp.Name as Employee_Name, ISNULL(mang.Name, 'Boss') as manager_name
from EmployeesCTE emp
left join EmployeesCTE mang
on mang.ManagerId= emp.EmployeeId 