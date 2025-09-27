-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    user_type ENUM('Farmer', 'Buyer') NOT NULL
);

-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT,
    name VARCHAR(100) NOT NULL,
    category ENUM('Animal', 'Crop', 'Equipment') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    date_added DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (seller_id) REFERENCES Users(user_id)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    buyer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('Pending','Completed','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (buyer_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert Users
INSERT INTO Users (name, email, password, phone, user_type)
VALUES 
('John Doe','john@example.com','pass123','9876543210','Farmer'),
('Mary Smith','mary@example.com','pass456','9876501234','Buyer');

-- Insert Products
INSERT INTO Products (seller_id, name, category, price, quantity)
VALUES
(1, 'Dairy Cow', 'Animal', 30000.00, 5),
(1, 'Wheat Seeds', 'Crop', 1500.00, 100);

-- Insert Orders
INSERT INTO Orders (buyer_id, product_id, quantity, total_price)
VALUES
(2, 1, 1, 30000.00),
(2, 2, 5, 7500.00);

-- Insert Reviews
INSERT INTO Reviews (product_id, user_id, rating, comment)
VALUES
(1, 2, 5, 'Healthy cow, very satisfied'),
(2, 2, 4, 'Good seeds, fast delivery');

-- checking
SELECT p.name AS product, p.category, p.price, u.name AS seller
FROM Products p
JOIN Users u ON p.seller_id = u.user_id;

SELECT o.order_id, u.name AS buyer, p.name AS product, o.quantity, o.total_price
FROM Orders o
JOIN Users u ON o.buyer_id = u.user_id
JOIN Products p ON o.product_id = p.product_id;

