CREATE TABLE customers
(
    cust_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100),
    signup_date DATE
);

INSERT INTO customers VALUES
(101, 'Anand Jha', 'Bangalore', '2024-01-10'),
(102, 'Priya Sharma', 'Mumbai', '2024-02-11'),
(103, 'Rahul Verma', 'Delhi', '2024-03-02'),
(104, 'Sneha Iyer', 'Chennai', '2024-03-05'),
(105, 'Arjun Rao', 'Hyderabad', '2024-04-01');


select * from customers


CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(5001, 101, '2025-01-01', 1200),
(5002, 102, '2025-01-03', 4500),
(5003, 101, '2025-01-05', 3000),
(5004, 106, '2025-01-06', 900),
(5005, 103, '2025-01-07', 7000);


CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100)
);

INSERT INTO products VALUES
(1, 'iPhone 15', 'Mobile'),
(2, 'AirPods', 'Accessories'),
(3, 'Dell Laptop', 'Laptop'),
(4, 'Keyboard', 'Accessories'),
(5, 'Monitor', 'Electronics');

CREATE TABLE order_items
(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items VALUES
(1, 5001, 1, 1),
(2, 5001, 2, 2),
(3, 5002, 3, 1),
(4, 5003, 5, 1),
(5, 5005, 1, 1);

select * from customers
select * from orders
select * from products


--display customer name with there order id's

SELECT C.cust_id,C.customer_name,O.order_id FROM customers c INNER JOIN ORDERS O ON C.cust_id = O.cust_id

---FIND ALL CUSTOMERS WHO PLACED ORDERS ABOVE 3000

SELECT C.cust_id,C.customer_name,O.order_id,O.amount FROM customers c INNER JOIN ORDERS O ON C.cust_id = O.cust_id WHERE O.amount > 3000

SELECT C.cust_id,C.customer_name,O.order_id FROM customers c LEFT JOIN ORDERS O ON C.cust_id = O.cust_id WHERE O.order_id IS NULL

---Find total order amount per customer
SELECT 
C.customer_name,
SUM(O.amount) AS total_amount 
FROM customers c 
INNER JOIN 
ORDERS O 
ON C.cust_id = O.cust_id
GROUP BY C.customer_name

----Count total orders placed by each customer

SELECT 
C.customer_name,
COUNT(O.order_id) AS total_ORDERS
FROM customers c 
INNER JOIN 
ORDERS O 
ON C.cust_id = O.cust_id
GROUP BY C.customer_name

USE [JOIN_PRACTICE]

SELECT * FROM [dbo].[employees_india]
UNION ALL
SELECT * FROM [dbo].[employees_usa]