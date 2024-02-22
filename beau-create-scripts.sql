CREATE SCHEMA beau;

USE beau;

CREATE TABLE brands (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
description VARCHAR(510) DEFAULT NULL
);

CREATE TABLE products (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
brand_id INT NOT NULL,
category_id INT NOT NULL,
subcategory_id INT NOT NULL,
price FLOAT NOT NULL,
size FLOAT NOT NULL,
measure_type VARCHAR(255) NOT NULL,
description VARCHAR(510) DEFAULT NULL,
new BOOL NOT NULL,
limited_edition BOOL NOT NULL,
online_only BOOL NOT NULL,
out_of_stock BOOL NOT NULL,
loves INT
);

CREATE TABLE category (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL
);

CREATE TABLE subcategory (
id INT PRIMARY KEY AUTO_INCREMENT,
category_id INT NOT NULL,
name VARCHAR(255) NOT NULL
);

CREATE TABLE customers (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(255) NOT NULL,
country VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
created_at TIMESTAMP NOT NULL,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE loved_products (
id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
product_id INT NOT NULL
);

CREATE TABLE customer_details (
id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT NOT NULL,
skin_type VARCHAR(255),
skin_concern VARCHAR(255),
hair_type VARCHAR(255),
hair_concern VARCHAR(255)
);

CREATE TABLE shopping_history (
id INT PRIMARY KEY AUTO_INCREMENT,
date TIMESTAMP NOT NULL,
customer_id INT NOT NULL,
total_spent FLOAT NOT NULL,
channel_id INT NOT NULL,
store_id INT
);

CREATE TABLE shopping_details (
id INT PRIMARY KEY AUTO_INCREMENT,
shopping_history_id INT NOT NULL,
product_id INT NOT NULL
);

CREATE TABLE channel (
id INT PRIMARY KEY AUTO_INCREMENT,
channel_type VARCHAR(255) NOT NULL
);

CREATE TABLE stores (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL, 
city VARCHAR(255) NOT NULL, 
zip_code INT NOT NULL,
state VARCHAR(255) NOT NULL,
phone_number INT NOT NULL
);

ALTER TABLE products
ADD CONSTRAINT fk_products_brands
FOREIGN KEY (brand_id) REFERENCES brands (id)
;

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (category_id) REFERENCES category (id)
;

ALTER TABLE products
ADD CONSTRAINT fk_products_subcategory
FOREIGN KEY (subcategory_id) REFERENCES subcategory (id)
;

ALTER TABLE subcategory
ADD CONSTRAINT fk_subcategory_category
FOREIGN KEY (category_id) REFERENCES category (id)
;

ALTER TABLE loved_products
ADD CONSTRAINT fk_loved_products_customers
FOREIGN KEY (customer_id) REFERENCES customers (id)
;

ALTER TABLE loved_products
ADD CONSTRAINT fk_loved_products_products
FOREIGN KEY (product_id) REFERENCES products (id)
;

ALTER TABLE customer_details
ADD CONSTRAINT fk_customer_details_customers
FOREIGN KEY (customer_id) REFERENCES customers (id)
;

ALTER TABLE shopping_history
ADD CONSTRAINT fk_shopping_history_customers
FOREIGN KEY (customer_id) REFERENCES customers (id)
;

ALTER TABLE shopping_history
ADD CONSTRAINT fk_shopping_history_channel
FOREIGN KEY (channel_id) REFERENCES channel (id)
;

ALTER TABLE shopping_history
ADD CONSTRAINT fk_shopping_history_stores
FOREIGN KEY (store_id) REFERENCES stores (id)
;

ALTER TABLE shopping_details
ADD CONSTRAINT fk_shopping_details_shopping_history
FOREIGN KEY (shopping_history_id) REFERENCES shopping_history (id)
;

ALTER TABLE shopping_details
ADD CONSTRAINT fk_shopping_details_products
FOREIGN KEY (product_id) REFERENCES products (id)
;
