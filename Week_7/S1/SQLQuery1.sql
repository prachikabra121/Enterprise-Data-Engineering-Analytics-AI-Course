CREATE TABLE Employees
(
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

INSERT INTO Employees
VALUES
(1,'Alice','Engineering',90000,'2020-01-15'),
(2,'Bob','Engineering',85000,'2019-03-10'),
(3,'Carol','Engineering',92000,'2021-07-01'),
(4,'Dave','Marketing',70000,'2018-06-20'),
(5,'Eve','Marketing',75000,'2020-11-05'),
(6,'Frank','Marketing',68000,'2022-02-14'),
(7,'Grace','HR',60000,'2017-09-30'),
(8,'Hank','HR',62000,'2019-12-01');

select * from Employees;

select avg(salary),Department as avg_sal from Employees group by Department;

select * from Employees where Salary > (select avg(Salary) from Employees);

select *,Avg(salary) over(partition by department) as deptAvg from Employees;

select EmpName,salary,ROW_NUMBER() OVER(order By salary desc) as rownum from Employees;
select EmpName,salary,ROW_NUMBER() OVER(partition by department order By salary desc) as rownum from Employees;


---top 1 employee department wise based on the salary
WITH TOP_Emp 
AS
(select EmpName,salary,ROW_NUMBER() OVER(partition by department order By salary desc) as rownum from Employees)
SELECT * from TOP_Emp where rownum=1;

UPDATE Employees
SET Salary = 90000
WHERE EmpName='Carol';

select EmpName,salary,RANK() OVER(partition by department order By salary desc) as rownum from Employees;
select EmpName,salary,ROW_NUMBER() OVER(partition by department order By salary desc) as rownum from Employees;
select EmpName,salary,DENSE_RANK() OVER(partition by department order By salary desc) as rownum from Employees;

select EmpName,salary,Ntile(5) OVER(order By salary desc) as rownum from Employees;


SELECT Empname, department, salary, hiredate, 
       SUM(salary) OVER ( 
         PARTITION BY department 
         ORDER BY hiredate 
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
       ) AS running_total 
FROM employees 
ORDER BY department, hiredate; 


SELECT Empname, department, salary, hiredate, 
       SUM(salary) OVER ( 
         PARTITION BY department 
         ORDER BY hiredate 
         ---ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
       ) AS running_total 
FROM employees 
ORDER BY department, hiredate;


SELECT EMPname, department, salary, 
LAG(salary, 1, 0) OVER (PARTITION BY department ORDER BY salary) AS 
prev_salary, 
salary - LAG(salary, 1, 0) OVER (PARTITION BY department ORDER BY salary) AS 
salary_diff 
FROM employees;

SELECT EMPname, department, salary, 
LEAD(salary, 1, 0) OVER (PARTITION BY department ORDER BY salary) AS 
prev_salary, 
salary - LEAD(salary, 1, 0) OVER (PARTITION BY department ORDER BY salary) AS 
salary_diff 
FROM employees;