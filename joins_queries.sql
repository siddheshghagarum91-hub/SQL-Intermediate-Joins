CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers (customer_name, city) VALUES
('Rahul', 'Mumbai'),
('Amit', 'Delhi'),
('Priya', 'Pune'),
('Neha', 'Mumbai'),
('Rohan', 'Chennai');

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books');

INSERT INTO products (product_name, price, category_id) VALUES
('Laptop', 50000, 1),
('Mobile', 20000, 1),
('T-shirt', 500, 2),
('Novel', 300, 3);


INSERT INTO orders (customer_id, product_id, order_date, quantity) VALUES
(1,1,'2024-01-01',1),
(2,2,'2024-01-05',2),
(1,3,'2024-01-07',3),
(3,4,'2024-01-10',1);



SELECT 
c.customer_name,
c.city,
o.order_id,
o.order_date
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;



SELECT 
c.customer_name,
o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


SELECT 
p.product_name,
SUM(o.quantity * p.price) AS total_revenue
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name;


SELECT 
cat.category_name,
SUM(o.quantity * p.price) AS revenue
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
INNER JOIN categories cat
ON p.category_id = cat.category_id
GROUP BY cat.category_name;


SELECT 
c.customer_name,
o.order_date,
p.product_name
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
WHERE c.city = 'Mumbai'
AND o.order_date BETWEEN '2024-01-01' AND '2024-01-31';

COPY (
SELECT 
c.customer_name,
c.city,
o.order_id,
o.order_date,
p.product_name,
p.price,
(o.quantity * p.price) AS total_amount,
cat.category_name
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
INNER JOIN categories cat
ON p.category_id = cat.category_id
)
TO 'C:/Users/Public/joined_output.csv'
CSV HEADER;


