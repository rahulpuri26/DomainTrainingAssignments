-- CREATE PROC uspFindProducts(@modelyear as int)
-- AS
-- BEGIN
-- Select * from production.products;



-- uspFindProductsbyRange 
-- @maxPrice=12000;
-- @minPrice=5000


-- CREATE PROC uspFindProductsByName
-- (@minPrice as decimal =2000, @maxPrice decimal,@name as varchar(max))
-- AS
-- BEGIN
-- select * from production.products where list_price>=@minPrice AND
-- list_price<=@maxProce



-- create PROCEDURE uspFindProductCountByModelYear
-- (@modelyear int,
-- @productCount int OUTPUT)
-- AS
-- BEGIN
-- select Product_name, list_Price
-- from production.products
-- WHERE
-- model_year = @@ROWCOUNT
-- END

-- DECLARE @count int;
-- EXEC uspFindProductCountByModelYear @modelyear = 2016 , @productCount = @count OUT;



-- ALTER PROC usp_GetCustomerData 
-- (@customerId int)
-- AS
-- BEGIN
-- EXEC usp_GetAllCustomers;
-- EXEC usp_GetCustomers @customerId;
-- END

-- exec usp_GetCustomerData 

-- CREATE PROCEDURE uspFindProductCountByModelYear
-- (
--     @modelyear INT,
--     @productCount INT OUTPUT
-- )
-- AS
-- BEGIN
--     SELECT 
--         product_name, 
--         list_price
--     FROM 
--         production.products
--     WHERE 
--         model_year = @modelyear;

--     -- Set the output parameter to the number of products found
--     SET @productCount = @@ROWCOUNT;
-- END;


-- CREATE PROCEDURE uspGetCustomersByProduct
-- (
--     @ProductID INT
-- )
-- AS
-- BEGIN
--     SELECT 
--         c.customer_id, 
--         CONCAT(c.first_name, ' ', c.last_name) AS CustomerName, 
--         o.order_date AS PurchaseDate
--     FROM 
--         sales.customers c
--     INNER JOIN 
--         sales.orders o ON c.customer_id = o.customer_id
--     INNER JOIN 
--         sales.order_items oi ON o.order_id = oi.order_id
--     WHERE 
--         oi.product_id = @ProductID;
-- END;


-- SELECT * 
-- FROM sales.order_items 
-- WHERE product_id = @ProductID;
-- drop PROCEDURE uspGetCustomersByProduct




-- Table Valued Function
-- inline table valued function --> contains single select statement

-- create function GetEmployeeByID(@empID int)
-- returns table
-- as 
-- return (Select * from dbo.Employee where EmployeeID = @empID)

-- select * from GetEmployeeByID(4)

-- create function GetEmployees()
-- returns table
-- as 
-- return (Select * from dbo.Employee)

-- select * from GetEmployees()
-- update GetEmployees() set EmployeeDOB = '2003-05-19' where EmployeeID = 4
-- -- multi statement table valued func -- cannot update cause it is selecting data from temp table
-- create function GetEmployeewithTheirDepartments()
-- returns @TempTable table
-- (EmployeeID int, EmployeeName varchar(max), DepartmentID int, DepartmentName varchar(max))
-- as
-- begin
-- 	insert into @TempTable 
-- 	select e.EmployeeID,e.EmployeeName,e.DepartmentID,d.DepartmentName
-- 	from dbo.Employee e
-- 	join
-- 	dbo.Department d
-- 	on e.DepartmentID = d.DepartmentID
-- 	return 
-- end

-- select * from GetEmployeewithTheirDepartments()


-------------------------/////////////////////////////////////////////------------------------------------------


--------------CLASSROOM----------ASSIGNMENTS--------------------------

--Assignment 1 Classroom
CREATE PROCEDURE uspGetCustomersByProduct
(
    @ProductID INT
)
AS
BEGIN
    SELECT 
        c.customer_id, 
        CONCAT(c.first_name, ' ', c.last_name) AS [Customer Name], 
        o.order_date AS [Purchase Date]
    FROM 
        sales.customers c
    INNER JOIN 
        sales.orders o ON c.customer_id = o.customer_id
    INNER JOIN 
        sales.order_items oi ON o.order_id = oi.order_id
    WHERE 
        oi.product_id = @ProductID;
END;


EXEC uspGetCustomersByProduct @ProductID = 4;
 -------------------------/////////////////////////////////////////////------------------------------------------

------ Assignment number 2 classroom
CREATE TABLE Department (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
);


INSERT INTO Department (ID, Name) VALUES (1, 'HR');
INSERT INTO Department (ID, Name) VALUES (2, 'IT');
INSERT INTO Department (ID, Name) VALUES (3, 'Finance');


CREATE TABLE Employee (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    DOB DATE,
    DeptId INT,
    FOREIGN KEY (DeptId) REFERENCES Department(ID)
);


INSERT INTO Employee (ID, Name, Gender, DOB, DeptId) 
VALUES 
(1, 'Mukta', 'Female', '1990-05-12', 1),
(2, 'Suresh', 'Male', '1985-08-23', 2),
(3, 'Vanshika', 'Female', '1992-03-15', 2),
(4, 'Naman', 'Male', '1988-11-09', 3);


----a) Create a procedure to update the Employee details in the Employee table based on the Employee id.
GO
CREATE PROCEDURE uspUpdateEmployeeDetails
(
    @empId INT,
    @newName VARCHAR(100),
    @newGender VARCHAR(10),
    @newDOB DATE,
    @newDeptId INT
)
AS
BEGIN
    UPDATE Employee
    SET 
        Name = @newName, 
        Gender = @newGender, 
        DOB = @newDOB, 
        DeptId = @newDeptId
    WHERE 
        ID = @empId;
END;
GO

EXEC uspUpdateEmployeeDetails 1, 'Mukti', 'Female', '1990-05-12', 1;
 GO


 --b) Create a Procedure to get the employee information bypassing the employee gender and department id from the Employee table

 CREATE PROCEDURE uspGetEmployeeByGenderAndDept
(
    @empGender VARCHAR(10),
    @empDeptId INT
)
AS
BEGIN
    SELECT 
        ID AS [Employee ID],
        Name AS [Employee Name],
        Gender,
        DOB AS [Date of Birth],
        DeptId AS [Department ID]
    FROM 
        Employee
    WHERE 
        Gender = @empGender 
        AND DeptId = @empDeptId;
END;
GO

EXEC uspGetEmployeeByGenderAndDept 'Female', 2;

GO

select * from employee
GO
-- c) Create a Procedure to get the Count of Employee based on Gender(input)

CREATE PROCEDURE uspGetEmployeeCountByGender
(
    @empGender VARCHAR(10)
)
AS
BEGIN
    SELECT 
        COUNT(*) AS EmployeeCount
    FROM 
        Employee
    WHERE 
        Gender = @empGender;
END;
GO
-- Execute the procedure
EXEC uspGetEmployeeCountByGender 'Male';
GO
 -------------------------/////////////////////////////////////////////------------------------------------------

--Assignment 3 Classroom

--a) Create a user Defined function to calculate the TotalPrice based on productid and Quantity Products Table


CREATE FUNCTION dbo.CalculateTotalPriceTable
(
    @ProductID INT,
    @Quantity INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT product_id,
           product_name,
           list_price,
           (@Quantity * list_price) AS [Total Price]
    FROM production.products
    WHERE product_id = @ProductID
);
go 

SELECT * FROM dbo.CalculateTotalPriceTable(3, 5);
 GO


--b) create a function that returns all orders for a specific customer, including details such as OrderID, OrderDate, and the total amount of each order.
CREATE FUNCTION dbo.GetCustomerOrders
(
    @CustomerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        o.order_id AS OrderID,
        o.order_date AS OrderDate,
        SUM(od.quantity * od.list_price) AS TotalAmount
    FROM 
        sales.orders o
    INNER JOIN 
        sales.order_items od ON o.order_id = od.order_id
    WHERE 
        o.customer_id = @CustomerID
    GROUP BY 
        o.order_id, o.order_date
);
GO

SELECT * 
FROM dbo.GetCustomerOrders(5);
GO

--c) create a Multistatement table valued function that calculates the total sales for each product, considering quantity and price.
CREATE FUNCTION dbo.CalculateTotalSalesForEachProduct()
RETURNS @ProductSales TABLE
(
    ProductID INT,
    ProductName NVARCHAR(255),
    TotalSales DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @ProductSales (ProductID, ProductName, TotalSales)
    SELECT 
        p.product_id AS ProductID,
        p.product_name AS ProductName,
        SUM(oi.quantity * oi.list_price) AS TotalSales
    FROM 
        production.products p
    INNER JOIN 
        sales.order_items oi ON p.product_id = oi.product_id
    GROUP BY 
        p.product_id, p.product_name;
    RETURN;
END;
GO

SELECT * 
FROM dbo.CalculateTotalSalesForEachProduct();
GO

--d) create a  multi-statement table-valued function that lists all customers along with the total amount they have spent on orders.
CREATE FUNCTION dbo.GetCustomerTotalSpending()
RETURNS @CustomerSpending TABLE
(
    CustomerID INT,
    CustomerName NVARCHAR(255),
    TotalSpent DECIMAL(18, 2)
)
AS
BEGIN
    INSERT INTO @CustomerSpending (CustomerID, CustomerName, TotalSpent)
    SELECT 
        c.customer_id AS CustomerID,
        c.first_name + ' ' + c.last_name AS CustomerName,
        SUM(oi.quantity * oi.list_price) AS TotalSpent
    FROM 
        sales.customers c
    LEFT JOIN 
        sales.orders o ON c.customer_id = o.customer_id
    LEFT JOIN 
        sales.order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.customer_id, c.first_name, c.last_name;
    RETURN;
END;
GO

SELECT * 
FROM dbo.GetCustomerTotalSpending();
