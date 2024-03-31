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
rating FLOAT, -- CREAR TRIGGER QUE ACTUALICE EL PROMEDIO EN BASE A LA CANTIDAD DE REVIEWS EN DICHA TABLA --
loves INT -- CREAR TRIGGER QUE SUME LA CANTIDAD DE LOVES EN BASE A LA CANTIDAD DE FAVES DE TABLA LOVED_PRODUCTS --
);

CREATE TABLE categorys (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL
);

CREATE TABLE subcategorys (
id INT PRIMARY KEY AUTO_INCREMENT,
category_id INT NOT NULL,
name VARCHAR(255) NOT NULL
);

CREATE TABLE users (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
password VARCHAR(255) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(255) NOT NULL,
country VARCHAR(255) NOT NULL,
skin_type VARCHAR(20) CHECK (skin_type IN ('Oily', 'Combination', 'Normal', 'Dry')),
hair_type VARCHAR(20) CHECK (hair_type IN ('Straight', 'Wavy', 'Curly', 'Coily')),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE user_addresses (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
address_line_1 VARCHAR(255) NOT NULL,
address_line_2 VARCHAR(255),
zip_code VARCHAR(20) NOT NULL,
city VARCHAR(100) NOT NULL,
state VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE user_payments (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
payment_type VARCHAR(20) NOT NULL CHECK (payment_type IN ('Debit', 'Credit')),
card_issuer VARCHAR(20) NOT NULL CHECK (card_issuer IN ('Visa', 'Mastercard','American Express')),
card_number VARCHAR(20) NOT NULL CHECK (card_number REGEXP '^[0-9]{16}$'),
expiry_date DATE NOT NULL, -- CREAR TRIGGER QUE IMPIDA REGISTRAR UNA FECHA ANTERIOR A LA ACTUAL // revisar SQL File 5*
cardholder_name VARCHAR(100) NOT NULL,
cardholder_id_number VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE loved_products (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
product_id INT NOT NULL,
faved BOOL NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE reviews (
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT NOT NULL,
user_id INT NOT NULL,
rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
review VARCHAR(510),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_preferences (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
skin_concern VARCHAR(50) CHECK (skin_concern IN ('Acne & Blemishes', 'Anti-Aging', 'Dark Spots', 'Pores', 'Dryness', 'Fine Lines & Wrinkles', 'Dullness')),
hair_concern VARCHAR(50) CHECK (hair_concern IN ('Repair', 'Nourish', 'Anti-frizz', 'Volume & Texture', 'Color Care', 'Curl Enhancing'))
);

CREATE TABLE promotions (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
description VARCHAR(510),
discount FLOAT NOT NULL, -- CREAR UN TRIGGER QUE APLIQUE AUTOMATICAMENTE EL DESCUENTO SI LA FECHA DE LA COMPRA SE ENCUENTRA DENTRO DEL PERIODO DE VIGENCIA DE LA PROMOCIÓN
start_date DATE NOT NULL,
end_date DATE NOT NULL
);

CREATE TABLE transactions (
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT NOT NULL,
total FLOAT NOT NULL,
transaction_channel VARCHAR(20) NOT NULL CHECK (transaction_channel IN ('Online', 'Store')),
transaction_status VARCHAR(50) NOT NULL CHECK (transaction_status IN ('Pending', 'In Process', 'Completed', 'Refunded', 'Cancelled')),
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE order_details (
id INT PRIMARY KEY AUTO_INCREMENT,
transaction_id INT NOT NULL,
product_id INT NOT NULL
);

CREATE TABLE channel_store (
id INT PRIMARY KEY AUTO_INCREMENT,
transaction_id INT NOT NULL,
store_id INT NOT NULL,
payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('Cash', 'Debit', 'Credit'))
);

CREATE TABLE channel_online (
id INT PRIMARY KEY AUTO_INCREMENT,
transaction_id INT NOT NULL,
user_payment_id INT NOT NULL,
user_address_id INT NOT NULL
);

CREATE TABLE stores (
id INT PRIMARY KEY AUTO_INCREMENT,
store_name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL, 
city VARCHAR(255) NOT NULL, 
zip_code INT NOT NULL,
state VARCHAR(255) NOT NULL,
phone_number INT NOT NULL
);

CREATE TABLE stock (
id INT PRIMARY KEY AUTO_INCREMENT,
product_id INT NOT NULL,
store_id INT NOT NULL,
quantity INT NOT NULL, -- CREAR TRIGGER QUE BAJE STOCK CADA VEZ QUE SE GENERA UN REGISTRO EN TABLA TRANSACTIONS // CREAR STORED PROCEDURE QUE PERMITA AUMENTAR EL STOCK DE UN PRODUCTO
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE products
ADD CONSTRAINT fk_products_brands
FOREIGN KEY (brand_id) REFERENCES brands (id)
;

ALTER TABLE products
ADD CONSTRAINT fk_products_category
FOREIGN KEY (category_id) REFERENCES categorys (id)
;

ALTER TABLE products
ADD CONSTRAINT fk_products_subcategory
FOREIGN KEY (subcategory_id) REFERENCES subcategorys (id)
;

ALTER TABLE subcategorys
ADD CONSTRAINT fk_subcategory_category
FOREIGN KEY (category_id) REFERENCES categorys (id)
;

ALTER TABLE user_addresses
ADD CONSTRAINT fk_user_addresses_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE user_payments
ADD CONSTRAINT fk_user_payments_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE loved_products
ADD CONSTRAINT fk_loved_products_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE loved_products
ADD CONSTRAINT fk_loved_products_product_id
FOREIGN KEY (product_id) REFERENCES products (id)
;

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product_id
FOREIGN KEY (product_id) REFERENCES products (id)
;

ALTER TABLE user_preferences
ADD CONSTRAINT fk_user_preferences_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_user_id
FOREIGN KEY (user_id) REFERENCES users (id)
;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_transaction_id
FOREIGN KEY (transaction_id) REFERENCES transactions (id)
;

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_product_id
FOREIGN KEY (product_id) REFERENCES products (id)
;

ALTER TABLE channel_store
ADD CONSTRAINT fk_channel_store_transaction_id
FOREIGN KEY (transaction_id) REFERENCES transactions (id)
;

ALTER TABLE channel_store
ADD CONSTRAINT fk_channel_store_store_id
FOREIGN KEY (store_id) REFERENCES stores (id)
;

ALTER TABLE channel_online
ADD CONSTRAINT fk_channel_online_transaction_id
FOREIGN KEY (transaction_id) REFERENCES transactions (id)
;

ALTER TABLE channel_online
ADD CONSTRAINT fk_channel_online_user_payment_id
FOREIGN KEY (user_payment_id) REFERENCES user_payments (id)
;

ALTER TABLE channel_online
ADD CONSTRAINT fk_channel_online_user_address_id
FOREIGN KEY (user_address_id) REFERENCES user_addresses (id)
;

ALTER TABLE stock
ADD CONSTRAINT fk_stock_product_id
FOREIGN KEY (product_id) REFERENCES products (id)
;

ALTER TABLE stock
ADD CONSTRAINT fk_stock_store_id
FOREIGN KEY (store_id) REFERENCES stores (id)
;
