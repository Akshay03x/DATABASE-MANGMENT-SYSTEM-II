select * from department2
select * from Designation2
select * from person2

sp_rename 'department', 'department2';
sp_rename 'designation','designation2';
sp_rename 'person','person2';

--1
Create Procedure PR_Insert_Person
@FirstName			varchar(100),
@Lastname			varchar(100),
@Salary				decimal(8,2),
@JoiningDate		datetime,
@DepartmentID		int,
@DesignationId		int
As
Begin
	INSERT INTO PERSON2(
	
	FirstName,		
	Lastname,		
	Salary	,		
	JoiningDate	,
	DepartmentID,
	DesignationId	
	)
	VALUES
	(@FirstName,		
	 @Lastname,	
	 @Salary,			
	 @JoiningDate,	
	 @DepartmentID,
	 @DesignationId
	 )
END

--2

CREATE PROC PR_INSERT_DEPARTMENT
@DEPARTMENTID		INT,
@DEPARTMENTNAME		VARCHAR(100)
AS
BEGIN
	INSERT INTO department2
	VALUES(@DEPARTMENTID,@DEPARTMENTNAME);
END

--3 
CREATE PROC PR_INSERT_DESIGNATION
@DESIGNATIONID		INT,
@DESIGNATIONNAME	VARCHAR(100)
AS BEGIN
	INSERT INTO Designation2
	VALUES(@DESIGNATIONID,	
		   @DESIGNATIONNAME);
END

--4 
CREATE PROC PR_UPDATE_PERSON
@WORKERID			INT,
@FirstName			varchar(100),
@Lastname			varchar(100),
@Salary				decimal(8,2),
@JoiningDate		datetime,
@DepartmentID		int,
@DesignationId		int
As
Begin
	UPDATE PERSON2
	SET FIRSTNAME = @FirstName,		
		LASTNAME = @Lastname,	
		SALARY = @Salary,			
		JOININGDATE = @JoiningDate,	
		DEPARTMENTID = @DepartmentID,
		DESIGNATIONID = @DesignationId
	WHERE
		WORKERID = @WORKERID;
	
	
END


--5 
CREATE PROC PR_UPDATE_DEPARTMENT
@DEPARTMENTID   INT,
@DEPARTMENTNAME VARCHAR(100)
AS BEGIN
	UPDATE Department2
	SET 
		DepartmentName = @DEPARTMENTNAME
	WHERE 
		DEPARTMENTID = @DEPARTMENTID
END


--6 
CREATE PROC PR_UPDATE_DESIGNATION
@DESIGNATIONID   INT,
@DESIGNATIONNAME VARCHAR(100)
AS BEGIN 
	UPDATE Designation2
		SET DESIGNATIONNAME = @DESIGNATIONNAME;
END



--7 
CREATE PROC PR_DELETE_PERSON
@WORKERID INT
AS BEGIN
	DELETE FROM Person2
		WHERE WorkerID = @WORKERID
END

--8
CREATE PROC PR_DELETE_DEPARTMENT
@DEPARTMENTID INT
AS BEGIN
	DELETE FROM Department2
		WHERE DepartmentID = @DEPARTMENTID

END

--9 

CREATE PROC PR_DELETE_DESIGNATION
@DESIGNATIONID INT
AS BEGIN 
	DELETE FROM Designation2
		WHERE DesignationID = @DESIGNATIONID
END


--All tables SelectAll (If foreign key is available than do write join and take columns on select list)

CREATE PROC PR_SELECT_ALL
AS 
	SELECT WORKERID, FIRSTNAME, LASTNAME, SALARY, JOININGDATE, P.DepartmentID, DEPARTMENTNAME, P.DESIGNATIONID, DESIGNATIONNAME 
	FROM PERSON2 P INNER JOIN Department2 DP 
	ON P.DepartmentID  = DP.DepartmentID
	INNER JOIN Designation2 DS
	ON P.DesignationID = DS.DesignationID;



CREATE PROC PR_SELECT_DEPARTMENT
AS SELECT * FROM Department2;


CREATE PROC PR_SELECT_DESIGNATION
AS SELECT * FROM Designation2;


--All tables SelectPK

CREATE PROC PR_SELECT_PERSON_BY_PK
@WORKERID INT
AS
	SELECT * FROM PERSON2
		WHERE WORKERID=@WORKERID;


CREATE PROC PR_SELECT_DEPARTMENT_BY_PK
@DEPARTMENTID INT
AS 
	SELECT * FROM DEPARTMENT2;


CREATE PROC PR_SELECT_DESIGNATION_BY_PK
@DESIGNATIONID INT
AS 
	SELECT * FROM DESIGNATION2	
		WHERE DESIGNATIONID = @DESIGNATIONID;


--Create Procedure that takes Department Name & Designation Name as Input and Returns a 
--table with Worker�s First Name, Salary, Joining Date & Department Name

CREATE PROC PR_TABLE_PERSON
@DEPARTMENTNAME   VARCHAR(100),
@DESIGNATIONNAME  VARCHAR(100)
AS 
	
	SELECT  FIRSTNAME, LASTNAME, SALARY, JOININGDATE,  DEPARTMENTNAME
	FROM PERSON2 P INNER JOIN Department2 DP 
	ON P.DepartmentID  = DP.DepartmentID
	INNER JOIN Designation2 DS
	ON P.DesignationID = DS.DesignationID

	WHERE DEPARTMENTNAME = @DEPARTMENTNAME AND DESIGNATIONNAME = @DESIGNATIONNAME;

-- Create Procedure that takes FirstName as an input parameter and displays� all the details of 
--the worker with their department & designation name

CREATE PROC PR_FIRSTNAME_DETAILS
@FIRSTNAME VARCHAR(100)
AS 
	SELECT WORKERID, FIRSTNAME, LASTNAME, SALARY, JOININGDATE,  DEPARTMENTNAME, DesignationName
	FROM PERSON2 P INNER JOIN Department2 DP 
	ON P.DepartmentID  = DP.DepartmentID
	INNER JOIN Designation2 DS
	ON P.DesignationID = DS.DesignationID

	WHERE FIRSTNAME = @FIRSTNAME;



EXEC PR_FIRSTNAME_DETAILS BHOOMI

-- Create Procedure which displays department wise maximum, minimum & total salaries.

CREATE PROC PR_SELECT_MAX_MIN_TOTAL_SALARY_BY_DEPARTMENTNAME
AS 
	SELECT DepartmentNAME, MAX(SALARY) AS 'MAX_SAL', MIN(SALARY) AS 'MIN_SAL', SUM(SALARY) AS 'TOTAL_SAL' FROM PERSON2 P INNER JOIN Department2 DP
	ON P.DepartmentID  = DP.DepartmentID
	GROUP BY DepartmentName;


--Create Views


--1 . Create a view that display first 100 workers details.

Create View View_Top100
As
	Select top 100 * from person2;

select * from View_Top100


--2 Create a view that displays designation wise maximum, minimum & total salaries.

create View View_Min_Max_Total_Salary_By_Designation
As
	SELECT DesignationName, MAX(SALARY) AS 'MAX_SAL', MIN(SALARY) AS 'MIN_SAL', SUM(SALARY) AS 'TOTAL_SAL' FROM Person2 P INNER JOIN designation2 DG
	ON P.DesignationID = DG.DesignationID
	GROUP BY DG.DesignationName;

SELECT * FROM View_Min_Max_Total_Salary_By_Designation;

--3 Create a view that displays Worker�s first name with their salaries & joining date, it also displays
--  duration column which is difference of joining date with respect to current date.

CREATE VIEW VIEW_FIRSTNAME_SALARY_JOININGDATE_DURATION
AS
	SELECT FIRSTNAME, SALARY, JOININGDATE, DATEDIFF(YEAR,JoiningDate,GETDATE()) AS 'DURATION' FROM Person2;

SELECT * FROM VIEW_FIRSTNAME_SALARY_JOININGDATE_DURATION;


--4 Create a view which shows department & designation wise total number of workers.

CREATE VIEW VIEW_TOTAL_WORKER_BY_DEPARTMENT_DESIGNATION
AS
	SELECT DESIGNATIONNAME,DEPARTMENTNAME,COUNT(WORKERID) AS 'TOTAL_WORKER'
	FROM PERSON2 P INNER JOIN Department2 DP 
	ON P.DepartmentID  = DP.DepartmentID
	INNER JOIN Designation2 DS
	ON P.DesignationID = DS.DesignationID
	GROUP BY DS.DESIGNATIONNAME, DP.DEPARTMENTNAME;

SELECT * FROM VIEW_TOTAL_WORKER_BY_DEPARTMENT_DESIGNATION;


--5 Create a view that displays worker names who don�t have either in any department or designation.

CREATE VIEW VIEW_WORKER_WITHOUT_DEPARTMENT_OR_DESIGNATION
AS 
	SELECT FIRSTNAME FROM Person2 
	WHERE DepartmentId IS NULL OR DesignationID IS NULL;

SELECT * FROM VIEW_WORKER_WITHOUT_DEPARTMENT_OR_DESIGNATION;






--Create Function

--1 Create a table valued function which accepts DepartmentID as a parameter & returns a worker
--  table based on DepartmentID.

CREATE FUNCTION FUN_SELECT_BY_DEPARTMENTID(@DEPARTMENTID INT)
RETURNS TABLE
AS
	RETURN (SELECT * FROM Person2 WHERE DepartmentId = @DEPARTMENTID);

select * from dbo.FUN_SELECT_BY_DEPARTMENTID(1);


--2 Create a table valued function which returns a table with unique city names from worker table.

alter FUNCTION FUN_UNIQUE_CITY_FROM_WORKER()
RETURNS TABLE
AS 
	RETURN (SELECT DISTINCT CITY FROM worker)


--3 Create a scalar valued function which accepts two parameters start date & end date, and
--  returns a date difference in days

CREATE FUNCTION FUN_DIFFERENCE_IN_DAYS(@StartDate datetime, @EndDate datetime)
RETURNS INT
AS 
BEGIN
	RETURN (DATEDIFF(DAY,'@STARTDATE','@ENDDATE'));
END

--4,5  Create a scalar valued function which accepts two parameters year in integer & month in
--   integer and returns total days in passed month & year.


CREATE FUNCTION FUN_TOTAL_DAYS_BY_MONTH_AND_YEAR(@MONTH INT, @YEAR INT)
RETURNS INT
AS
BEGIN
		DECLARE @Date DATE = CAST(
                            CAST(@Year AS CHAR(4)) 
                            + RIGHT('0' + CAST(@Month AS VARCHAR(2)), 2)
                            + '01' AS DATE);

        RETURN DATEDIFF(DAY,  
							DATEADD(MONTH, DATEDIFF(MONTH, 0, @Date), 0),
																			DATEADD(MONTH, DATEDIFF(MONTH, 0, @Date) + 1, 0));

END

 select DBO.FUN_TOTAL_DAYS_BY_MONTH_AND_YEAR(7,2022)
 
 
 ------------------------------------PPT Query s----------------------------------------------------------------
select * from student
insert into student values(110,'mahesh','cc',5,5.5)
delete from student
where rno=109
update student set cpi=10
where rno=101
select * from msg
select * from mag2

---------------1-----------------------
create trigger tr_insert
on student
for update
as
begin

	declare @rno int,@name varchar(100),@branch varchar(50),@semester int ,@cpi decimal(4,2);
	select @rno=rno,@name=name,@branch=branch,@semester=semester,@cpi=cpi from inserted
	insert into msg values(@rno,@name,@branch,@semester,@cpi);
end

-------------------2-----------------------
alter trigger tr_insert_2
on student
for insert
as begin
	declare @name varchar(100);
	select @name =name from inserted
	insert into mag2 values(concat('inserted student name =',@name));
end

--------------------------3--------------------------------
alter trigger tr_delete_3
on student
for delete
as begin
	declare @rno int;
	select @rno=rno from deleted
	insert into mag2 values(concat('delete  student roll no is =',@rno));
end
------------------------------4------------------------------------
select * from marks
insert into marks values(10,10,10)

create trigger tr_result
on marks
for insert 
as 
begin 
declare @sub1 decimal(8,2),@sub3 decimal(8,2) ,@sub2 decimal(8,2),@total decimal(8,2) ;
select @sub1=sub1 ,@sub2=sub2,@sub3=sub3 from inserted
set @total=@sub1+@sub2+@sub3;
insert into total values(@total);
end

select * from total
