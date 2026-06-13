CREATE TABLE employees (
    emp_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    status VARCHAR(20),
    hire_date DATE
);

INSERT INTO employees VALUES
(1,'Anand','Jha','Engineering',85000,'ACTIVE','2022-01-10'),
(2,'Rahul','Sharma','Sales',65000,'ACTIVE','2021-03-15'),
(3,'Priya','Das','HR',70000,'INACTIVE','2020-05-11');

select * from employees

CREATE VIEW VW_EMP_PUBLIC AS
SELECT emp_id, first_name, last_name, department,hire_date FROM employees WHERE status = 'ACTIVE';

SELECT * FROM [dbo].[VW_EMP_PUBLIC] WHERE department = 'Engineering';
select * from employees

CREATE OR ALTER  VIEW VW_EMP_PUBLIC AS
SELECT emp_id, first_name, last_name, department FROM employees WHERE status = 'ACTIVE';



INSERT INTO employees VALUES
(4,'RAGHAV','Jha','HR',85000,'ACTIVE','2022-01-10'),
(5,'RONAK','Sharma','Sales',65000,'ACTIVE','2021-03-15')


CREATE TABLE customer (
    id INT,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE order_(
    id INT,
    cust_id INT,
    order_date DATE,
    total DECIMAL(10,2)
);

INSERT INTO customer VALUES
(1,'Alice','alice@gmail.com'),
(2,'Bob','bob@gmail.com');

INSERT INTO order_ VALUES
(101,1,'2024-03-15',1200),
(102,2,'2024-03-18',850);

CREATE or Alter VIEW V_HIGH_VALUE_ORDER AS
SELECT c.name,o.id,o.order_date,o.total FROM CUSTOMER C JOIN order_ O ON C.id = O.cust_id
WHERE O.total > 1000;

select * from V_HIGH_VALUE_ORDER


create procedure sp_get_active_employees
as
begin
    SELECT emp_id, first_name, last_name, department FROM employees WHERE status = 'ACTIVE';

end

exec sp_get_active_employees


--employees by the department
create procedure sp_emp_by_dept
    @p_dept varchar(50)
as
begin
  select emp_id, first_name, last_name, department from employees where department = @p_dept

end

EXEC sp_emp_by_dept @p_dept = 'HR'


EXEC sp_emp_by_dept @p_dept = 'ENGINEERING'

-- COUNT EMPLOYEE BY DEPARTMENT
CREATE PROCEDURE SP_COUNT_EMP_BY_DEPT
  @P_DEPT VARCHAR(50),
  @P_COUNT INT OUTPUT
AS
BEGIN
  SELECT @P_COUNT = COUNT(*) FROM employees WHERE department = @P_DEPT
END

DECLARE @TOTAL INT
EXEC SP_COUNT_EMP_BY_DEPT @P_DEPT = 'HR', @P_COUNT = @TOTAL OUTPUT

SELECT @TOTAL AS TotalEmployeesInHR


CREATE PROCEDURE SP_DEMO
AS
BEGIN
SELECT 'HELLO'
END

EXEC SP_DEMO

CREATE PROCEDURE SP_SQ
 @NUM INT,
 @RESULT INT OUTPUT
AS
BEGIN
   SET @RESULT = @NUM * @NUM
END

DECLARE @SQUARE_RESULT INT
EXEC SP_SQ @NUM = 5, @RESULT= @SQUARE_RESULT OUTPUT

SELECT @SQUARE_RESULT AS SquareOf5


CREATE PROCEDURE SP_UPDATE_SALARY
@EMP_ID INT,
@P_RAISE_PERCENT DECIMAL(5,2),
@P_STATUS VARCHAR(20) OUTPUT

AS
BEGIN
  IF EXISTS(SELECT 1 FROM employees WHERE emp_id = @EMP_ID)
  BEGIN
    UPDATE employees
    SET salary = salary + (salary * @P_RAISE_PERCENT / 100)
    WHERE emp_id = @EMP_ID
    SET @P_STATUS = 'Salary Updated'
  END
  ELSE
  BEGIN
    SET @P_STATUS = 'Employee Not Found'
  END
END


DECLARE @STATUS_MSG VARCHAR(20)
EXEC SP_UPDATE_SALARY @EMP_ID = 3, @P_RAISE_PERCENT = 10, @P_STATUS = @STATUS_MSG OUTPUT
SELECT @STATUS_MSG AS UpdateStatus
