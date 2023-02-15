create table account
(
	id int identity primary key,
	Name nvarchar(20),
	Balance int
	)

insert into account values ('Mark',1000)
insert into account values ('Merry',1000)

select * from account

--transaction demostration

begin try
	begin transaction 
		update account set Balance = Balance - 100 where id =1
		update account set Balance = Balance + 100 where id ='e'
	commit transaction
	print 'Transaction commited'
end try

begin catch
	rollback transaction
	print 'Transaction rollback'
end catch
