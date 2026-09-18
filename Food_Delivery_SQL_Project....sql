CREATE DATABASE
food_delivery_analysis;
USE food_delivery_analysis;
CREATE TABLE Customers (
Customer_ID INT PRIMARY KEY,
Customer_Name VARCHAR(100),
Age INT,
Gender VARCHAR(20),
City VARCHAR(50),
Customer_Segment VARCHAR(50),
Signup_Date date
);
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Order_Date DATE,
    Restaurant VARCHAR(100),
    Cuisine VARCHAR(50),
    Order_Type VARCHAR(30),
    Payment_Mode VARCHAR(20),
    Order_Status VARCHAR(20),
    Order_Amount DECIMAL(10,2),
    Delivery_Distance_KM DECIMAL(5,1),
    Rating DECIMAL(2,1),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
SELECT 
COUNT(*) AS total_orders,
SUM(Order_Amount) AS total_revenue,
AVG (Order_Amount) AS average_order_value FROM Orders;
SELECT
    Order_Status,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue,
    AVG(Order_Amount) AS average_order_value
FROM Orders
GROUP BY Order_Status
ORDER BY total_revenue DESC;
SELECT
    c.City,
    COUNT(o.Order_ID) AS total_orders,
    SUM(o.Order_Amount) AS total_revenue,
    AVG(o.Order_Amount) AS average_order_value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.City
ORDER BY total_revenue DESC;
SELECT
    Restaurant,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue,
    AVG(Rating) AS average_rating
FROM Orders
GROUP BY Restaurant
ORDER BY total_revenue DESC
LIMIT 5;
SELECT
    Cuisine,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue,
    AVG(Rating) AS average_rating
FROM Orders
GROUP BY Cuisine
ORDER BY total_orders DESC;
SELECT
    Payment_Mode,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue,
    AVG(Order_Amount) AS average_order_value
FROM Orders
GROUP BY Payment_Mode
ORDER BY total_orders DESC;
SELECT
    c.Customer_Segment,
    COUNT(o.Order_ID) AS total_orders,
    SUM(o.Order_Amount) AS total_revenue,
    AVG(o.Order_Amount) AS average_order_value
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_Segment
ORDER BY total_revenue DESC;
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue
FROM Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY order_month;
SELECT
    CASE
        WHEN Delivery_Distance_KM < 5 THEN '0-5 KM'
        WHEN Delivery_Distance_KM < 10 THEN '5-10 KM'
        ELSE '10+ KM'
    END AS distance_band,
    COUNT(*) AS total_orders,
    AVG(Rating) AS average_rating
FROM Orders
GROUP BY distance_band
ORDER BY total_orders DESC;
SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    COUNT(o.Order_ID) AS total_orders,
    SUM(o.Order_Amount) AS total_spend
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.City
ORDER BY total_spend DESC
LIMIT 10;
SELECT
    COUNT(*) AS total_orders,
    SUM(Order_Status = 'Cancelled') AS cancelled_orders,
    ROUND(
        100 * SUM(Order_Status = 'Cancelled') / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM Orders;
SELECT
    COUNT(*) AS duplicate_order_ids
FROM (
    SELECT Order_ID
    FROM Orders
    GROUP BY Order_ID
    HAVING COUNT(*) > 1
) AS duplicates;
SELECT
    SUM(Customer_ID IS NULL) AS null_customer_id,
    SUM(Order_Date IS NULL) AS null_order_date,
    SUM(Restaurant IS NULL) AS null_restaurant,
    SUM(Order_Amount IS NULL) AS null_order_amount,
    SUM(Rating IS NULL) AS null_rating
FROM Orders;
SELECT
    Order_ID,
    Customer_ID,
    Restaurant,
    Cuisine,
    Order_Amount,
    Order_Date
FROM Orders
ORDER BY Order_Amount DESC
LIMIT 10;
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS total_orders,
    SUM(o.Order_Amount) AS total_spend
FROM Customers c
JOIN Orders o
    ON c.Customer_ID = o.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
HAVING COUNT(o.Order_ID) > 5
ORDER BY total_orders DESC;
SELECT
    Order_Type,
    COUNT(*) AS total_orders,
    SUM(Order_Amount) AS total_revenue,
    AVG(Order_Amount) AS average_order_value
FROM Orders
GROUP BY Order_Type
ORDER BY total_revenue DESC;