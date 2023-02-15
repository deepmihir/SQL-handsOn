--List all tables in a sql server database using a query
select * from sysobjects where xtype ='U'
select * from sys.tables
select * from INFORMATION_SCHEMA.TABLES


--merge query in sql
Create table StudentSource
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')

select * from StudentSource
select * from StudentTarget


merge Studenttarget as T
using StudentSource as S
on T.ID = S.ID
when matched then
	update set T.Name= S.Name
when not matched by target then 
	INSERT (ID, NAME) VALUES(S.ID, S.NAME);



