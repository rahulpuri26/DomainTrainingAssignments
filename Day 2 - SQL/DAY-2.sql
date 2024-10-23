CREATE TABLE customers
(customer_id int primary key,
name varchar(100),
active bit )

CREATE TABLE ORDERS
(
    order_id int primary key,
    customer_id int foreign key REFERENCES Customers(customer_id),
    order_status varchar(100)
)

insert into customers values 
(1,'Sunaina',1),
(2,'Naman',2);

insert into orders values 
(101,1,'Pending'),
(102,2,'Pending')

--TRANSACTION A 

BEGIN TRANSACTION 
UPDATE customers SET name = 'Sakshi'
WHERE customer_id = 1

WAITFOR DELAY '00:00:05';
UPDATE orders SET order_status = 'Processed'
WHERE order_id = 101

COMMIT TRANSACTION

--TRANSACTION B

BEGIN TRANSACTION
UPDATE orders  SET order_status='Shipped'
WHERE order_id=101

WAITFOR DELAY '00:00:05';
UPDATE customers SET name = 'Stuti'
WHERE customer_id = 1



----------------------------------------DAY2 ASSIGNMENTS--------------------------------------------------------------------------------

--7)Create a trigger to updates the Stock (quantity) table whenever new order placed in orders tables
go
create trigger trgUpdateOnNewOrder
on sales.order_items
after insert
as
begin
	declare @store_id int, @product_id int, @quantity int;
    select	@store_id = o.store_id,
			@product_id = i.product_id,
			@quantity = i.quantity
    from inserted i
    inner join sales.orders o
        on i.order_id = o.order_id;

    update production.stocks
    set quantity = quantity - @quantity
    where store_id = @store_id and product_id = @product_id;
end

select * from production.stocks
select * from sales.order_items

insert into sales.orders(customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
values(49,4,'2024-10-23','2024-11-04','2024-10-25',1,5)



--8) Create a trigger to that prevents deletion of a customer if they have existing orders.
GO
CREATE TRIGGER trg_PreventCustomerDeletion
ON sales.customers
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @CustomerID INT;

    SELECT @CustomerID = customer_id FROM deleted;

    IF EXISTS (SELECT 1 FROM sales.orders WHERE customer_id = @CustomerID)
    BEGIN

        RAISERROR('Cannot delete customer with existing orders.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM sales.customers WHERE customer_id = @CustomerID; 
    END
END;

DELETE FROM sales.customers WHERE customer_id = 1; 




--9) Create Employee,Employee_Audit  insert some test data 
--b) Create a Trigger that logs changes to the Employee Table into an Employee_Audit Table

CREATE TABLE Employee3 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Salary DECIMAL(10, 2),
    Department VARCHAR(50)
);

CREATE TABLE Employee_Audit (
    AuditID INT IDENTITY PRIMARY KEY,
    EmployeeID INT,
    OldName VARCHAR(100),
    NewName VARCHAR(100),
    OldSalary DECIMAL(10, 2),
    NewSalary DECIMAL(10, 2),
    OldDepartment VARCHAR(50),
    NewDepartment VARCHAR(50),
    ChangeDate DATETIME DEFAULT GETDATE()
);

INSERT INTO Employee3 (EmployeeID, Name, Salary, Department) 
VALUES 
(1, 'Rakesh Sharma', 60000.00, 'HR'),
(2, 'Sundar Vakani', 55000.00, 'IT'),
(3, 'Gurjit Singh', 50000.00, 'Finance');

go 
CREATE TRIGGER trg_LogEmployeeChanges
ON Employee3
FOR UPDATE
AS
BEGIN
    INSERT INTO Employee_Audit (EmployeeID, OldName, NewName, OldSalary, NewSalary, OldDepartment, NewDepartment)
    SELECT 
        i.EmployeeID,
        d.Name AS OldName,
        i.Name AS NewName,
        d.Salary AS OldSalary,
        i.Salary AS NewSalary,
        d.Department AS OldDepartment,
        i.Department AS NewDepartment
    FROM 
        inserted i
    JOIN 
        deleted d ON i.EmployeeID = d.EmployeeID;
END;

UPDATE Employee3
SET Salary = 62000.00, Department = 'Management' 
WHERE EmployeeID = 1; 

SELECT * FROM Employee_Audit;


--10) create Room Table with below columns
-- RoomID,RoomType,Availability
-- create Bookins Table with below columns
-- BookingID,RoomID,CustomerName,CheckInDate,CheckInDate
 
-- Insert some test data with both  the tables
-- Ensure both the tables are having Entity relationship
-- Write a transaction that books a room for a customer, ensuring the room is marked as unavailable


CREATE TABLE Room (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    RoomType VARCHAR(50),
    Availability BIT  
);

CREATE TABLE Bookings (
    BookingID INT IDENTITY PRIMARY KEY,
    RoomID INT,
    CustomerName VARCHAR(100),
    CheckInDate DATE,
    CheckOutDate DATE,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

INSERT INTO Room (RoomType, Availability)
VALUES 
('Single', 1),  
('Double', 1),  
('Suite', 0);   

BEGIN TRANSACTION;

DECLARE @RoomID INT = 1; 
DECLARE @CustomerName VARCHAR(100) = 'Ram Kapoor'; 
DECLARE @CheckInDate DATE = '2024-10-25'; 
DECLARE @CheckOutDate DATE = '2024-10-30'; 


IF EXISTS (SELECT * FROM Room WHERE RoomID = @RoomID AND Availability = 1)
BEGIN
    INSERT INTO Bookings (RoomID, CustomerName, CheckInDate, CheckOutDate)
    VALUES (@RoomID, @CustomerName, @CheckInDate, @CheckOutDate);
    UPDATE Room
    SET Availability = 0
    WHERE RoomID = @RoomID;

    COMMIT TRANSACTION;
    PRINT 'Room booked successfully.';
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Room is not available for booking.';
END

