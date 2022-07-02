select * from person
select * from department

--1. Find all persons with their department name & code.
select personname,departmentname ,departmentcode from person
inner join department
on department.departmentid=person.departmentid;



--2. Give department wise maximum & minimum salary with department name.
select max(salary),min (salary),DepartmentName from person
inner join department 
on  department.departmentid=person.departmentid
group by departmentname



--3. Find all departments whose total salary is exceeding 100000.
select DepartmentCode from department d
inner join person p
on p.DepartmentID=d.DepartmentID
group by d.DepartmentCode
having sum(salary)>100000;


--4. Retrieve person name, salary & department name who belongs to Jamnagar city.
select personname, salary,departmentname from person p
inner join department d
on p.DepartmentID=d.DepartmentID
where city like 'jamnagar'




--5. Find all persons who does not belongs to any department.
select personname from person
where departmentid is null




--6. Find department wise person counts.
select count(personname),d.DepartmentCode from person p
inner join department d
ON d.DepartmentID=p.DepartmentID
group by d.DepartmentCode



--7. Find average salary of person who belongs to Ahmedabad city.
select avg(salary) from person
where city='Ahmedabad'
group by city




--8. Produce Output Like: <PersonName> earns <Salary> from department <DepartmentName> monthly. (In single column)
select concat(personname,' earns ',salary,' from department ',departmentname,' monthly ') from person p
inner join department d
on d.DepartmentID=p.DepartmentID


--9. List all departments who have no persons.
select departmentname from department d
inner join person p
on d.DepartmentID=p.DepartmentId
where p.departmentid =null




--10. Find city & department wise total, average & maximum salaries.
select city,sum(salary) sum,avg(salary) avrage,max(salary) max from person
group by City

select departmentcode,sum(salary) sum,avg(salary) avrage,max(salary) max from person p
inner join department d
on d.DepartmentID=p.DepartmentId
group by d.DepartmentCode


--11. Display Unique city names.
select distinct(city) from person


--12. List out department names in which more than two persons.
select DepartmentCode,count(personname) from department d
inner join person p
on d.DepartmentID=p.DepartmentId
group by d.departmentcode
having count(personname)>2


--13. Combine person name’s first three characters with city name’s last three characters in single column.
select concat(left(personname,3),right(city,3)) from person



--14. Give 10% increment in Computer department employee’s salary.
select personname,departmentcode,(salary+salary*0.1) from department d
inner join person p
on d.DepartmentID=p.DepartmentId
where DepartmentCode='ce'




--15. Display all the person name’s who’s joining dates difference with current date is more than 365 days.
select DATEDIFF(day,JoiningDate,getdate()), personname from person 
where DATEDIFF(day,JoiningDate,getdate()) >=365
