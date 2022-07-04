SELECT * FROM MST_STATE
SELECT * FROM MST_CITY

--PR_MST_CITY_SELECTALL
 CREATE PROC PR_MST_CITY_SELECTALL
 AS
 BEGIN
 SELECT C.CITYID,C.CITYNAME,C.PINCODE,C.CITYREMARKS,S.STATENAME
 FROM MST_CITY C
 INNER JOIN MST_STATE S
 ON C.STATEID=S.STATEID
 END

 EXEC PR_MST_CITY_SELECTALL

 --2  pr_mst_city_insert
 create proc  pr_mst_city_insert
@city_id		int ,
@cityname		varchar(250),
@pincode		varchar(6),
@STATEID		int,
@cityremarks	varchar(500)

as 
begin 

insert into mst_city
values ( @city_id,	
		 @cityname,	
		 @pincode,
			@STATEID,
			@cityremarks);
end

exec pr_mst_city_insert 5,ak,36,2,hj

--3  pr_mst_city_upadte
create proc pr_mst_city_upadte
@cityid		int ,
@cityname		varchar(250),
@pincode		varchar(6),
@STATEID		int,
@cityremarks	varchar(500)
AS
BEGIN

UPDATE MST_CITY SET	
cityname=@cityname	,
pincode=@pincode	,
STATEID=@STATEID,	
cityremarks=@cityremarks
WHERE CITYID=@CITYID

END

EXEC pr_mst_city_upadte 5,JAYPUR,360003,2,GOODD

--4PR_MST_CITY_DELETE

CREATE PROC PR_MST_CITY_DELETE
 @CITYID INT
 AS
  BEGIN 
  DELETE FROM MST_CITY
  WHERE CITYID=@CITYID
  END

  EXEC PR_MST_CITY_DELETE 5
 

 --5 PR_MST_CITY_SELECTBYPK
 CREATE PROC PR_MST_CITY_SELECTBYPK
 @CITYID INT
 AS
 BEGIN
 SELECT * FROM MST_CITY
 WHERE CITYID=@CITYID
 END 
 
 EXEC PR_MST_CITY_SELECTBYPK

 --6 PR_MST_CITY_SELECT BY PINCODESTARTWITH360
 CREATE PROC PR_MST_CITY_SELECT_BY_PINCODESTARTWITH360
 AS
 BEGIN
 SELECT 8 FROM MST_CITY
 WHERE PINCODE LIKE '360%'
 END

 EXEC PR_MST_CITY_SELECT_BY_PINCODESTARTWITH360

 --7 PR_MST_CITY_SELECT_BY_CITYNAME_PINCODE
 CREATE PROC PR_MST_CITY_SELECT_BY_CITYNAME_PINCODE
 @CITYNAME VARCHAR(250),
 @PINCODE VARCHAR(6)
 AS
 BEGIN
 SELECT * FROM MST_CITY
 WHERE CITYNAME=@CITYNAME
	AND 
	PINCODE =@PINCODE
	END

	EXEC PR_MST_CITY_SELECT_BY_CITYNAME_PINCODE ajmer,350001

--8 PR_MST_CITY__SELECT_BY_STATEID
CREATE PROC PR_MST_CITY__SELECT_BY_STATEID
@CITYREMARKS VARCHAR(500)
AS
BEGIN
SELECT * FROM MST_CITY
WHERE CITYREMARKS=@CITYREMARKS
END

EXEC PR_MST_CITY__SELECT_BY_STATEID good

--9 PR_MST_CITY_SELECT_BY_STATE ID

CREATE PROC PR_MST_CITY_SELECT_BY_STATE_ID
@STATEid INT
AS
BEGIN
SELECT * FROM MST_CITY
WHERE STATEid=@STATEid

END
exec PR_MST_CITY_SELECT_BY_STATE_ID 2

-- 10 pr_mst_city_selectby_cityid_stateid
create proc pr_mst_city_selectby_cityid_stateid
@cityid int,
@stateid int
as
begin
select * from mst_city
where stateid=@stateid
	and
	cityid=@cityid


	end

	exec pr_mst_city_selectby_cityid_stateid 1,2