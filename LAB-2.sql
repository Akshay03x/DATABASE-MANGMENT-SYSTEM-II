select * from EMPLOYEE_info


--1. Display all the employees whose name starts with “m” and 4 th character is “h”.

select ename from employee_info
where ename like'm__h%'

--2. Find the value of 3 raised to 5. Label the column as output.


	
--3. Write a query to subtract 20 days from the current date.
	select dateadd(day,-20,getdate())


--4. Write a query to display name of employees whose name starts with “j” and contains “n” in their name.
select ename from employee_info
where ename like 'j%'
	and ename like '%n%'

--5. Display 2nd to 9th character of the given string “SQL Programming”.
select substring('SQL Programming',2,9)

--6. Display name of the employees whose city name ends with “ney” &contains six characters.
select ename from employee_info
where city like '%___ney'

--7. Write a query to convert value 15 to string.



--8. Add department column with varchar (20) to Employee table.
alter table employee_info
add department varchar(20)


--9. Set the value of department to Marketing who belongs to London city.
update employee_info set department='marketing'
where city='London'


--10. Display all the employees whose name ends with either “n” or “y”.
select ename from employee_info
where ename like '%n'
	or ename like '%y'


--11. Find smallest integer value that is greater than or equal to 63.1, 63.8 and -63.2.
select CEILING(63.1),CEILING(63.8),CEILING(-63.2)



--12. Display all employees whose joining date is not available.
select ename from employee_info
where joiningdate is null

--13. Display name of the employees in capital letters and city in small letters.
select lower(city),upper(ename) from employee_info


--14. Change the data type of Ename from varchar (30) to char (30).
alter table employee_info
alter column ename char(30)

--15. Display city wise maximum salary.
select city,max(salary) from employee_info
group by city;

--16. Produce output like <Ename> works at <city> and earns <salary> (In single column).



--17. Find total number of employees whose salary is more than 5000.
select count(ename) from employee_info
where salary>5000


--18. Write a query to display first 4 & last 3 characters of all the employees.
	select left('employees',4), right('employees',3)



--19. List the city having total salaries more than 15000 and employees joined after 1st January, 2014.
	select city,sum(salary) from employee_info
	where sum(salary) >15000 
		and	
			joiningdate>2014-01-01
			group by city


--20. Write a query to replace “u” with “oo” in Ename.

select  ename, replace(ename,'u','oo') from employee_info


--21. Display city with average salaries and total number of employees belongs to each city.
select city, avg(salary),count(ename) from employee_info
group by city

--22. Display total salaries paid to female employees.
select sum(salary) from employee_info
where gender='Female'

--23. Display name of the employees and their experience in years.

select ename,datediff(year,joiningdate,getdate()) from employee_info


--24. Remove column department from employee table.
alter table employee_info
drop column department


--25. Update the value of city from syndey to null.
update employee_info set city=null
where city='sydney'

--26. Retrieve all Employee name, Salary & Joining date.
select ename,salary,joiningdate from employee_info

--27. Find out combine length of Ename & Gender.
select len(CONCAT(ename,gender)) from employee_info


--28. Find the difference between highest & lowest salary.
select max(salary)-min(salary) from employee_info

--29. Rename a column from Ename to FirstName.
sp_rename 'employee_info.ename','firstname','column'


--30. Rename a table from Employee to EmpMaster.
sp_rename 'employee_info','empmaster'