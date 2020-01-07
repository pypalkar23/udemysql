SHOW DATABASES;

USE practice_db;

CREATE TABLE customers(
	id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

ALTER TABLE customers MODIFY id INT NOT NULL; 

ALTER TABLE customers MODIFY id INT AUTO_INCREMENT;

DESC customers;

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

DROP TABLE orders;

DESC orders;

INSERT INTO customers(first_name, last_name, email)
VALUES ('Boy','George','george@email.com'),
('George','Michael','gm@gmail.com'),
('David','Bowie','david@gmail.com'),
('Blue','Steele','blue@gmail.com'),
('Bette','Davis','bettle@aol.com');

SELECT * FROM customers;

INSERT INTO orders(order_date, amount, customer_id)
VALUES ('2016/02/10',99.99,1),
('2017/11/11',35.50,1),
('2014/12/12',800.67,2),
('2015/01/03',12.50,2),
('1999/04/11',450.25,5);

SELECT * FROM orders;

SELECT * FROM orders,customers;

SELECT * FROM customers, orders WHERE customers.id= orders.customer_id;

SELECT * FROM customers JOIN orders WHERE customers.id = orders.customer_id;

SELECT first_name, last_name, SUM(amount) as total_spent 
FROM customers JOIN orders 
WHERE customers.id= orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

SELECT first_name,
	   last_name,
	    amount
FROM customers
LEFT JOIN orders
	ON customers.id = orders.customer_id;
    
SELECT first_name,
	   last_name,
	   IFNULL(amount,0)
FROM customers
LEFT JOIN orders
	ON customers.id = orders.customer_id;

SELECT first_name,
	   last_name,
       IFNULL(SUM(amount),0) as total_spent
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;


CREATE DATABASE tv_review_app;

USE tv_review_app;

CREATE TABLE reviewers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE series(
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    released_year YEAR(4),
    genre VARCHAR(100)
);

CREATE TABLE reviews(
	id INT PRIMARY KEY AUTO_INCREMENT,
    rating DECIMAL(2,1),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY(series_id) REFERENCES series(id),
    FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);


INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
SELECT * FROM series;
SELECT * FROM reviewers;
SELECT * FROM reviews;

SELECT title,rating FROM series INNER JOIN reviews ON series.id= reviews.series_id;

SELECT title, ROUND(AVG(rating),1) FROM series INNER JOIN reviews ON series.id= reviews.series_id GROUP BY series.id;

SELECT first_name, last_name, rating FROM reviewers JOIN reviews ON reviewers.id = reviews.reviewer_id;

SELECT title FROM series LEFT JOIN reviews ON series.id= reviews.series_id WHERE rating IS NULL;

SELECT genre, AVG(rating) as avg_rating FROM series JOIN reviews ON series.id= reviews.reviewer_id GROUP BY genre;

SELECT  first_name, 
		last_name , 
		COUNT(rating) as COUNT, 
        MIN(rating) as MIN,
        MAX(rating) as MAX 
FROM reviewers JOIN 
		reviews 
ON reviewers.id= reviews.reviewer_id 
GROUP BY reviewers.id;

SELECT  first_name, 
		last_name, 
		COUNT(rating) as COUNT, 
        IFNULL(MIN(rating),0) as MAX,
		IFNULL(MAX(rating),0) as MAX,
        IFNULL(ROUND(AVG(rating),2),0) as AVG,
        CASE 
			WHEN COUNT(rating)<=0 THEN 'INACTIVE'
            ELSE 'ACTIVE'
		END as STATUS
FROM reviewers LEFT JOIN 
		reviews 
ON reviewers.id=reviews.reviewer_id 
GROUP BY reviewers.id;


SELECT  title,
		rating,
        CONCAT_WS(' ',first_name, last_name) as reviewer
FROM series 
JOIN reviews 
	ON series.id= reviews.series_id 
JOIN reviewers 
	ON reviewers.id=reviews.reviewer_id
ORDER BY series.id;






