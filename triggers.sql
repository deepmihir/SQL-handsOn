CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

Insert into tblEmployee values (1,'John', 5000, 'Male', 3)
Insert into tblEmployee values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmployee values (3,'Pam', 6000, 'Female', 1)


select * from tblEmployee
select * from tblEmployeeAudit
CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)

alter trigger trg_employeeAudit
on tblEmployee
for insert
as
begin
	declare @id int
	select @id=Id from inserted
	insert into tblEmployeeAudit
	values('New Employee with Id='+ CAST(@id as nvarchar(5))+ ' is added at '+ CAST(GETDATE() as nvarchar(20)))
end

Insert into tblEmployee values (8,'Manthan', 300, 'Male', 3)