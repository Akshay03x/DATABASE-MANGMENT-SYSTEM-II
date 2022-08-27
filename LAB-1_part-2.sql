--1. CREATE INSERT, UPDATE & DELETE STORED PROCEDURES FOR PERSON TABLE.

CREATE PROC PR_INSERT
			@PERSONID INT ,
			@PERSONNAME VARCHAR (50) ,
			@SALARY DECIMAL (8,2),
			@JOININGDATE DATETIME ,
			@CITY VARCHAR (100) ,
			@AGE INT ,
			@BIRTHDATE DATETIME
AS
BEGIN

INSERT INTO PERSON VALUES
(@PERSONID,@PERSONNAME,@SALARY,@JOININGDATE,@CITY,@AGE,@BIRTHDATE);
END

EXEC PR_INSERT 104,'ABC',1000,'1-1-3','RAJKOT',null,'1-1-3'
---------------------------------------------------------------------------------------
alter PROC PR_UPDATE

			@PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

AS BEGIN 
UPDATE PERSON SET PERSONNAME=@PERSONNAME
	WHERE PERSONID=@PERSONID;

end

exec pr_update 101,'abcd'
------------------------------------------------------------------------------
create proc pr_delete 
		@PERSONID INT 
as begin 
delete from person 
where PERSONID  =@PERSONID 
end 
exec pr_delete 101

--2. CREATE A TRIGGER THAT FIRES ON INSERT, UPDATE AND DELETE OPERATION ON THE PERSON TABLE. FOR THAT, 
--CREATE A NEW TABLE PERSONLOG TO LOG (ENTER) ALL OPERATIONS PERFORMED ON THE PERSON TABLE.

create trigger tr_insert
on person
for insert
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from inserted
insert into person_log values(@personid,@PERSONNAME,'insert',getdate())
end
---------------------------------------------------------------------------------------------
create trigger tr_update
on person
for update
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from inserted
insert into person_log values(@personid,@PERSONNAME,'update',getdate())
end

----------------------------------------------------------------------------------------------------
create trigger tr_delete
on person
for delete 
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from deleted
insert into person_log values(@personid,@PERSONNAME,'delete',getdate())
end

--3. create an instead of trigger that fires on insert, update and delete oPERATION ON THE PERSON
--TABLE. FOR THAT, LOG ALL OPERATION PERFORMED ON THE PERSON TABLE INTO PERSONLOG.

create trigger tr_insert
on person
instead of insert
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from inserted
insert into person_log values(@personid,@PERSONNAME,'insert',getdate())
end
---------------------------------------------------------------------------------------------
create trigger tr_update
on person
instead of update
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from inserted
insert into person_log values(@personid,@PERSONNAME,'update',getdate())
end

----------------------------------------------------------------------------------------------------
create trigger tr_delete
on person
instead of delete 
as begin
	declare @PERSONID INT ,
			@PERSONNAME VARCHAR (50) 

select @PERSONID=PERSONID ,@PERSONNAME=PERSONNAME from deleted
insert into person_log values(@personid,@PERSONNAME,'delete',getdate())
end

--4. CREATE DELETE TRIGGER ON PERSONLOG TABLE, WHEN WE DELETE ANY RECORD OF PERSONLOG TABLE It prints 
--‘Record deleted successfully from PersonLog’.

create trigger tr_prsonlog_delete
on  person_log
for delete 
as begin 
	print 'Record deleted successfully from PersonLog'
end
--5. Create INSERT trigger on person table, which calculates the age and update that age in Person 
--table.
	alter trigger tr_age
	on person 
	for insert
	as 
	begin
		    declare @age int ,@id int 
			select @id=personid from inserted
			select @age = DATEDIFF(year,birthdate,getdate()) from person

			update person set age=@age 
			where personid=@id;
end



select * from person
select * from person_log

delete from person_log
