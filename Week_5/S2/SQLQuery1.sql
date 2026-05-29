select * from [dbo].[T_EMPLOYEE] where salary>60000

select 40000>>1

CREATE TABLE Products
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price)
VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Mobile Phone', 'Electronics', 25000),
(3, 'Headphones', 'Accessories', 2000),
(4, 'Smart Watch', 'Electronics', 5000),
(5, 'Office Chair', 'Furniture', 7000),
(6, 'Gaming Keyboard', 'Accessories', 3500),
(7, 'LED TV', 'Electronics', 45000),
(8, 'Bluetooth Speaker', 'Accessories', 4000);


select * from Products


select productname,
price,
price + 100 As increasedPrice,
Price * 1.18 AS PriceWithGST,
price * 0.90 AS DiscountePrice
From Products


select * from T_EMPLOYEE where salary/0


select  * from T_EMPLOYEE  where salary > 60000


select *,Price-Price * 0.1 As Discount from products where category ='Accessories' and ProductName='Headphones'

DROP TABLE Employee
CREATE TABLE Employees
(
    EmployeeID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    City VARCHAR(50)
);

INSERT INTO Employees
(EmployeeID, EmpName, Department, Salary, City)
VALUES
(1, 'Rahul', 'IT', 65000, 'Bangalore'),
(2, 'Priya', 'HR', 45000, 'Mumbai'),
(3, 'Arjun', 'IT', 55000, 'Delhi'),
(4, 'Neha', 'Finance', 70000, 'Mumbai'),
(5, 'Karan', 'IT', 40000, 'Pune'),
(6, 'Sneha', 'HR', 52000, 'Ahmedabad'),
(7, 'Vikas', 'IT', 80000, 'Mumbai'),
(8, 'Riya', 'Sales', 35000, 'Surat')

select * from Employees

SELECT * FROM Employees WHERE SALARY>50000 AND DEPARTMENT ='IT' OR CITY = 'MUMBAI'


select * from Employees
SELECT *
FROM Employees
WHERE Salary > 50000
AND (Department = 'IT'
OR City = 'Mumbai');

select * from Employees WHERE eMPnAME LIKE 'R%'
select * from Employees WHERE eMPnAME LIKE '%A'
select * from Employees WHERE eMPnAME LIKE '%EH%'
select * from Employees WHERE eMPnAME LIKE '[pr]%'

select * from Employees WHERE eMPnAME LIKE '[p-S]%'


select * from Employees WHERE eMPnAME IS NULL
select * from Employees WHERE eMPnAME IS NOT NULL

select CITY from Employees
select DISTINCT(CITY) from Employees

select * from Employees WHERE SALARY BETWEEN 40000 AND 80000

select * from Employees WHERE CITY IN ('DELHI','MUMBAI')












