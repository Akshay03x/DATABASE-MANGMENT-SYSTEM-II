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
select sum (salary),departmentname from person
inner join department
on department.departmentid=person.departmentid
where sum(salary)>100000;


4. Retrieve person name, salary & department name who belongs to Jamnagar city.
5. Find all persons who does not belongs to any department.
6. Find department wise person counts.
