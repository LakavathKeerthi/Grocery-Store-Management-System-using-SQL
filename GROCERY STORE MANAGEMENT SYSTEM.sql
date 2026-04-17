-- ============================================
-- PROJECT: GROCERY STORE MANAGEMENT SYSTEM
-- ============================================

-- ============================================
-- INTRODUCTION
-- ============================================
-- This project focuses on analyzing a grocery store database using SQL.
-- The dataset consists of customers, products, orders, suppliers, employees,
-- and order details. By applying SQL queries, the project extracts meaningful
-- insights related to customer behavior, product performance, sales trends,
-- supplier contribution, and employee efficiency.
-- The objective is to transform raw transactional data into useful business insights.

-- ============================================
-- OBJECTIVE
-- ============================================
-- 1. To analyze customer purchasing behavior and identify top customers.
-- 2. To evaluate product performance based on sales volume and revenue.
-- 3. To study order trends over time (daily, monthly patterns).
-- 4. To assess supplier contribution to product availability and revenue.
-- 5. To measure employee performance in handling orders and generating sales.
-- 6. To gain insights from order-level details such as pricing and quantity patterns.

-- ============================================
-- DATABASE CREATION
-- ============================================

create database Grocery_store_Management;
use Grocery_store_Management;

-- ============================================
-- SUPPLIER TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS supplier (
    sup_id TINYINT PRIMARY KEY,
    sup_name VARCHAR(255),
    address TEXT);

INSERT INTO supplier (sup_id, sup_name, address) VALUES
(11, 'Aarya Suppliers', 'Hyderabad, Telangana'),
(12, 'Sai Traders', 'Vijayawada, Andhra Pradesh'),
(13, 'Karthik Distributors', 'Chennai, Tamil Nadu'),
(14, 'Lakshmi Wholesale', 'Bangalore, Karnataka'),
(15, 'FreshFarm Supplies', 'Mumbai, Maharashtra');

SELECT * FROM supplier;

-- ============================================
-- CATEGORIES TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS categories (
    cat_id TINYINT PRIMARY KEY,
    cat_name VARCHAR(255));

INSERT INTO categories (cat_id, cat_name) VALUES
(11, 'Grains & Cereals'),
(12, 'Dairy Products'),
(13, 'Personal Care'),
(14, 'Household'),
(15, 'Vegetables & Fruits');

SELECT * FROM categories;

-- ============================================
-- EMPLOYEES TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS employees (
    emp_id TINYINT PRIMARY KEY,
    emp_name VARCHAR(255),
    hire_date DATE);

INSERT INTO employees (emp_id, emp_name, hire_date) VALUES
(11, 'Aditya Singh', '2025-01-15'),
(12, 'Diya Sharma', '2025-03-22'),
(13, 'Aarav Kumar', '2025-06-10'),
(14, 'Priya Verma', '2026-02-18'),
(15, 'Rahul Reddy', '2025-05-09');

SELECT * FROM employees;

-- ============================================
-- CUSTOMERS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS customers (
    cust_id SMALLINT PRIMARY KEY,
    cust_name VARCHAR(255),
    address TEXT);

INSERT INTO customers (cust_id, cust_name, address) VALUES
(101, 'Jyotika', 'Hyderabad, Telangana'),
(102, 'Amit Saxena', 'Delhi, India'),
(103, 'Deepa Shetty', 'Mumbai, Maharashtra'),
(104, 'Rohan Kumar', 'Chennai, Tamil Nadu'),
(105, 'Priya Nair', 'Kochi, Kerala'),
(106, 'Arjun Verma', 'Pune, Maharashtra'),
(107, 'Sneha Reddy', 'Vijayawada, Andhra Pradesh'),
(108, 'Rahul Sharma', 'Bangalore, Karnataka'),
(109, 'Anita Patel', 'Ahmedabad, Gujarat'),
(110, 'Kiran Joshi', 'Jaipur, Rajasthan');

SELECT * FROM customers;

-- ============================================
-- PRODUCTS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS products (
    prod_id TINYINT PRIMARY KEY,
    prod_name VARCHAR(255),
    sup_id TINYINT,
    cat_id TINYINT,
    price DECIMAL(10,2),
    FOREIGN KEY (sup_id) REFERENCES supplier(sup_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id)
        ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO products (prod_id, prod_name, sup_id, cat_id, price) VALUES
(1, 'Basmati Rice', 11, 11, 120.50),
(2, 'Moong Dal', 11, 11, 95.00),
(3, 'Butter', 12, 12, 55.75),
(4, 'Paneer', 12, 12, 220.00),
(5, 'Bath Soap', 13, 13, 35.00),
(6, 'Hand Sanitizer', 13, 13, 150.00),
(7, 'Washing Powder', 14, 14, 85.00),
(8, 'Soya Sauce', 15, 14, 180.00),
(9, 'Instant Noodles', 11, 13, 20.00),
(10, 'Ghee', 12, 12, 450.00),
(11, 'Eggs (12 Pack)', 14, 12, 72.00),
(12, 'Soybean Oil', 15, 11, 140.00);

SELECT * FROM products;

-- ============================================
-- ORDERS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS orders (
    ord_id SMALLINT PRIMARY KEY,
    cust_id SMALLINT,
    emp_id TINYINT,
    order_date DATE,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
        ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO orders (ord_id, cust_id, emp_id, order_date) VALUES
(1, 101, 11, '2026-03-01'),
(2, 102, 12, '2026-03-01'),
(3, 103, 13, '2026-03-02'),
(4, 104, 14, '2026-03-02'),
(5, 105, 15, '2026-03-03'),
(6, 106, 11, '2026-03-03'),
(7, 107, 12, '2026-03-04'),
(8, 108, 13, '2026-03-04'),
(9, 109, 14, '2026-03-05'),
(10, 110, 15, '2026-03-05');

SELECT * FROM orders;

-- ============================================
-- ORDER DETAILS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS order_details (
    ord_detID SMALLINT AUTO_INCREMENT PRIMARY KEY,
    ord_id SMALLINT,
    prod_id TINYINT,
    quantity TINYINT,
    each_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    FOREIGN KEY (ord_id) REFERENCES orders(ord_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (prod_id) REFERENCES products(prod_id)
        ON UPDATE CASCADE ON DELETE CASCADE);

INSERT INTO order_details (ord_id, prod_id, quantity, each_price, total_price) VALUES
(1, 1, 2, 120.50, 241.00),
(1, 9, 3, 20.00, 60.00),
(2, 2, 1, 95.00, 95.00),
(2, 3, 2, 55.75, 111.50),
(3, 4, 1, 220.00, 220.00),
(3, 10, 1, 450.00, 450.00),
(4, 5, 3, 35.00, 105.00),
(5, 6, 1, 150.00, 150.00),
(6, 7, 2, 85.00, 170.00),
(7, 8, 1, 180.00, 180.00),
(8, 11, 2, 72.00, 144.00),
(9, 12, 1, 140.00, 140.00),
(10, 1, 1, 120.50, 120.50),
(10, 4, 2, 220.00, 440.00);

SELECT * FROM order_details;

-- ============================================
-- BASIC CHECKS
-- ============================================

SELECT * FROM categories;
SELECT * FROM employees;

SELECT * FROM customers;

SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM supplier;

DESC supplier;
DESC categories;
DESC employees;
DESC customers;
DESC products;
DESC orders;
DESC order_details;

-- ============================================
-- 1. CUSTOMER INSIGHTS
-- ============================================

-- Q1: Unique customers
SELECT COUNT(DISTINCT cust_id) FROM orders;
-- Insight: Measures active customer base contributing to sales

-- Q2: Customers with highest orders
SELECT c.cust_name, COUNT(o.ord_id) AS total_orders
FROM customers c
JOIN orders o ON c.cust_id = o.cust_id
GROUP BY c.cust_name
ORDER BY total_orders DESC;
-- Insight: Identifies repeat customers indicating strong engagement

-- Q3: Total & average purchase
SELECT c.cust_name,
SUM(od.total_price) AS total_purchase,
AVG(od.total_price) AS avg_purchase
FROM customers c
JOIN orders o ON c.cust_id = o.cust_id
JOIN order_details od ON o.ord_id = od.ord_id
GROUP BY c.cust_name;
-- Insight: Differentiates high-value and low-value customers

-- Q4: Top 5 customers
SELECT c.cust_name,
SUM(od.total_price) AS total_purchase
FROM customers c
JOIN orders o ON c.cust_id = o.cust_id
JOIN order_details od ON o.ord_id = od.ord_id
GROUP BY c.cust_name
ORDER BY total_purchase DESC
LIMIT 5;
-- Insight: Highlights key revenue contributors for targeted strategies

-- ============================================
-- 2. PRODUCT PERFORMANCE
-- ============================================

-- Q1: Products per category
SELECT c.cat_name, COUNT(p.prod_id)
FROM categories c
JOIN products p ON c.cat_id = p.cat_id
GROUP BY c.cat_name;
-- Insight: Evaluates category-wise inventory distribution

-- Q2: Avg price per category
SELECT c.cat_name, AVG(p.price)
FROM categories c
JOIN products p ON c.cat_id = p.cat_id
GROUP BY c.cat_name;
-- Insight: Identifies premium vs budget categories

-- Q3: Highest sales volume
SELECT p.prod_name, SUM(od.quantity)
FROM products p
JOIN order_details od ON p.prod_id = od.prod_id
GROUP BY p.prod_name
ORDER BY SUM(od.quantity) DESC;
-- Insight: Finds most demanded products

-- Q4: Revenue per product
SELECT p.prod_name, SUM(od.total_price)
FROM products p
JOIN order_details od ON p.prod_id = od.prod_id
GROUP BY p.prod_name
ORDER BY SUM(od.total_price) DESC;
-- Insight: Identifies most profitable products

-- Q5: Category & supplier sales
SELECT c.cat_name, s.sup_name,
SUM(od.total_price)
FROM order_details od
JOIN products p ON od.prod_id = p.prod_id
JOIN categories c ON p.cat_id = c.cat_id
JOIN supplier s ON p.sup_id = s.sup_id
GROUP BY c.cat_name, s.sup_name;
-- Insight: Evaluates supplier performance across categories

-- ============================================
-- 3. SALES & ORDER TRENDS
-- ============================================

-- Q1: Total orders
SELECT COUNT(*) FROM orders;
-- Insight: Indicates overall business activity

-- Q2: Avg order value
SELECT AVG(total_price) FROM order_details;
-- Insight: Measures revenue generated per transaction

-- Q3: Orders per date
SELECT order_date, COUNT(*)
FROM orders
GROUP BY order_date;
-- Insight: Identifies peak sales days

-- Q4: Monthly trends
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
COUNT(*)
FROM orders
GROUP BY month;
-- Insight: Reveals growth or seasonal patterns

-- Q5: Weekday trends
SELECT DAYNAME(order_date), COUNT(*)
FROM orders
GROUP BY DAYNAME(order_date);
-- Insight: Shows customer activity variation across days

-- ============================================
-- 4. SUPPLIER CONTRIBUTION
-- ============================================

-- Q1: Total suppliers
SELECT COUNT(*) FROM supplier;
-- Insight: Indicates supplier network size

-- Q2: Supplier with most products
SELECT s.sup_name, COUNT(p.prod_id)
FROM supplier s
JOIN products p ON s.sup_id = p.sup_id
GROUP BY s.sup_name;
-- Insight: Shows suppliers contributing most to inventory

-- Q3: Avg price per supplier
SELECT s.sup_name, AVG(p.price)
FROM supplier s
JOIN products p ON s.sup_id = p.sup_id
GROUP BY s.sup_name;
-- Insight: Helps compare supplier pricing levels

-- Q4: Revenue per supplier
SELECT s.sup_name, SUM(od.total_price)
FROM supplier s
JOIN products p ON s.sup_id = p.sup_id
JOIN order_details od ON p.prod_id = od.prod_id
GROUP BY s.sup_name;
-- Insight: Identifies top-performing suppliers

-- ============================================
-- 5. EMPLOYEE PERFORMANCE
-- ============================================

-- Q1: Employees processing orders
SELECT COUNT(DISTINCT emp_id) FROM orders;
-- Insight: Shows workforce involvement

-- Q2: Most active employees
SELECT e.emp_name, COUNT(o.ord_id)
FROM employees e
JOIN orders o ON e.emp_id = o.emp_id
GROUP BY e.emp_name;
-- Insight: Identifies employees handling highest workload

-- Q3: Total sales per employee
SELECT e.emp_name, SUM(od.total_price)
FROM employees e
JOIN orders o ON e.emp_id = o.emp_id
JOIN order_details od ON o.ord_id = od.ord_id
GROUP BY e.emp_name;
-- Insight: Measures individual contribution to revenue

-- Q4: Avg order value per employee
SELECT e.emp_name,
SUM(od.total_price)/COUNT(o.ord_id)
FROM employees e
JOIN orders o ON e.emp_id = o.emp_id
JOIN order_details od ON o.ord_id = od.ord_id
GROUP BY e.emp_name;
-- Insight: Evaluates efficiency in handling transactions

-- ============================================
-- 6. ORDER DETAILS DEEP DIVE
-- ============================================

-- Q1: Quantity vs total price
SELECT quantity, each_price, total_price,
(quantity * each_price)
FROM order_details;
-- Insight: Validates pricing consistency

-- Q2: Avg quantity per product
SELECT p.prod_name, AVG(od.quantity)
FROM products p
JOIN order_details od ON p.prod_id = od.prod_id
GROUP BY p.prod_name;
-- Insight: Helps understand purchase patterns

-- Q3: Price variation
SELECT p.prod_name,
MIN(price), MAX(price), AVG(price)
FROM products p
GROUP BY p.prod_name;
-- Insight: Identifies pricing consistency and variation

-- ============================================
-- CHALLENGES FACED
-- ============================================
-- 1. Understanding relationships between multiple tables and applying correct JOIN operations.
-- 2. Maintaining data consistency using primary keys and foreign key constraints.
-- 3. Handling aggregations (SUM, AVG, COUNT) across multiple joined tables.
-- 4. Converting and working with date values for time-based analysis.
-- 5. Ensuring accurate calculation of total price and validating data consistency.
-- 6. Structuring queries to extract meaningful business insights rather than just raw data.

-- ============================================
-- CONCLUSION
-- ============================================
-- The project successfully demonstrates how SQL can be used to analyze
-- structured data and generate valuable business insights. Key findings include:
-- identification of high-value customers, best-selling and high-revenue products,
-- and performance evaluation of employees and suppliers.
-- The analysis also highlights sales patterns and trends over time.
-- Overall, this project strengthens skills in SQL querying, data analysis,
-- and database management, making it highly useful for real-world applications.