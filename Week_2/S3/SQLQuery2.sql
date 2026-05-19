-- =========================================
-- DATABASE TABLES FOR E-COMMERCE ER MODEL
-- SQL SERVER CREATE TABLE SCRIPTS
-- =========================================


-- =========================================
-- 1. CATEGORY TABLE
-- =========================================

CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL,
    Description VARCHAR(500),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);


-- =========================================
-- 2. CUSTOMER TABLE
-- =========================================

CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(500),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(20),
    CreatedAt DATETIME DEFAULT GETDATE()
);


-- =========================================
-- 3. PRODUCT TABLE
-- =========================================

CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description VARCHAR(1000),
    Price DECIMAL(10,2) NOT NULL,
    StockQty INT NOT NULL,
    CategoryID INT NOT NULL,
    Brand VARCHAR(100),
    SKU VARCHAR(100) UNIQUE,
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Product_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Category(CategoryID)
);


-- =========================================
-- 4. ORDER TABLE
-- =========================================

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(50) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    ShippingAddress VARCHAR(500),
    PaymentStatus VARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Orders_Customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
);


-- =========================================
-- 5. ORDERITEM TABLE
-- =========================================

CREATE TABLE OrderItem (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(10,2) DEFAULT 0,
    SubTotal DECIMAL(10,2) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_OrderItem_Order
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItem_Product
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);


-- =========================================
-- 6. PAYMENT TABLE
-- =========================================

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT UNIQUE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    TransactionID VARCHAR(255) UNIQUE,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentStatus VARCHAR(50),

    CONSTRAINT FK_Payment_Order
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);


-- =========================================
-- 7. REVIEW TABLE (BONUS CHALLENGE)
-- =========================================

CREATE TABLE Review (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment VARCHAR(1000),
    ReviewDate DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Review_Customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID),

    CONSTRAINT FK_Review_Product
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);


-- =========================================
-- OPTIONAL: INSERT SAMPLE DATA
-- =========================================

-- CATEGORY

INSERT INTO Category (CategoryName, Description)
VALUES 
('Electronics', 'Electronic Devices'),
('Fashion', 'Clothing and Apparel'),
('Books', 'Educational and Story Books');


-- CUSTOMER

INSERT INTO Customer (
    FirstName,
    LastName,
    Email,
    Phone,
    Address,
    City,
    State,
    ZipCode
)
VALUES
('Anand', 'Jha', 'anand@gmail.com', '9876543210', 'MG Road', 'Bangalore', 'Karnataka', '560001'),
('Prachi', 'Kabra', 'prachi@gmail.com', '9876543211', 'BTM Layout', 'Bangalore', 'Karnataka', '560076');


-- PRODUCT

INSERT INTO Product (
    ProductName,
    Description,
    Price,
    StockQty,
    CategoryID,
    Brand,
    SKU
)
VALUES
('iPhone 15', 'Apple Mobile Phone', 85000, 20, 1, 'Apple', 'APL-IP15'),
('Nike Shoes', 'Running Shoes', 5500, 50, 2, 'Nike', 'NK-RUN01');


-- ORDERS

INSERT INTO Orders (
    CustomerID,
    OrderStatus,
    TotalAmount,
    ShippingAddress,
    PaymentStatus
)
VALUES
(1, 'Delivered', 85000, 'MG Road Bangalore', 'Paid'),
(2, 'Pending', 5500, 'BTM Layout Bangalore', 'Pending');


-- ORDERITEM

INSERT INTO OrderItem (
    OrderID,
    ProductID,
    Quantity,
    UnitPrice,
    Discount,
    SubTotal
)
VALUES
(1, 1, 1, 85000, 0, 85000),
(2, 2, 1, 5500, 0, 5500);


-- PAYMENT

INSERT INTO Payment (
    OrderID,
    PaymentMethod,
    Amount,
    TransactionID,
    PaymentStatus
)
VALUES
(1, 'UPI', 85000, 'TXN12345', 'Success');


-- REVIEW

INSERT INTO Review (
    CustomerID,
    ProductID,
    Rating,
    Comment
)
VALUES
(1, 1, 5, 'Excellent product'),
(2, 2, 4, 'Very comfortable shoes');



-- =========================================
-- VERIFY DATA
-- =========================================

SELECT * FROM Category;
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderItem;
SELECT * FROM Payment;
SELECT * FROM Review;