CREATE DATABASE OnlineStore;
USE OnlineStore;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    category VARCHAR(100),
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    user_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'UPI', 'Net Banking') NOT NULL,
    payment_status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    transaction_id VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
INSERT INTO Users (name, email, password, phone, address) VALUES
('Bhavana', 'bhavana@gmail.com', 'password123', '1234567890', '123 Main St'),
('Lokesh', 'lokesh@gmail.com', 'password456', '0987654321', '456 Oak St');
INSERT INTO Products (name, description, price, stock_quantity, category, image_url) VALUES
('Laptop', 'High performance laptop', 1200.00, 10, 'Electronics', 'laptop.jpg'),
('Smartphone', 'Latest model smartphone', 800.00, 20, 'Electronics', 'smartphone.jpg');
INSERT INTO Orders (user_id, total_price, status) VALUES
(1, 2000.00, 'Pending'),
(2, 800.00, 'Shipped');
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 800.00),
(2, 2, 1, 800.00);
INSERT INTO Payments (order_id, user_id, amount, payment_method, payment_status, transaction_id) VALUES
(1, 1, 2000.00, 'Credit Card', 'Completed', 'TXN123456'),
(2, 2, 800.00, 'PayPal', 'Completed', 'TXN654321');
SELECT Orders.order_id, Users.name AS customer_name, Orders.total_price, Orders.status 
FROM Orders 
JOIN Users ON Orders.user_id = Users.user_id;
SELECT OrderItems.order_id, Products.name AS product_name, OrderItems.quantity, OrderItems.price 
FROM OrderItems 
JOIN Products ON OrderItems.product_id = Products.product_id 
WHERE OrderItems.order_id = 1;
SELECT Payments.payment_id, Payments.order_id, Users.name AS customer_name, Payments.amount, Payments.payment_method, Payments.payment_status, Payments.transaction_id 
FROM Payments 
JOIN Users ON Payments.user_id = Users.user_id;
SELECT product_id, name, description, price, stock_quantity, category FROM Products;






