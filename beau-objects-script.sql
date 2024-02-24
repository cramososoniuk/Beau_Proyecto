-- VISTAS --

CREATE VIEW v_product_info AS
SELECT 
    p.id AS "Product ID",
    p.name AS "Product",
    p.description AS "Description",
    b.name AS "Brand",
    ca.name AS "Category",
    sc.name AS "Subcategory",
    CONCAT(p.size,' ', p.measure_type) AS "Size",
    p.price AS "Price",
	CASE
		WHEN p.out_of_stock = 0 THEN "Yes"
        ELSE "No"
	END AS "In Stock"
FROM products p
JOIN brands b ON p.brand_id = b.id
JOIN category ca ON p.category_id = ca.id
JOIN subcategory sc ON p.subcategory_id = sc.id
ORDER BY p.id ASC;

CREATE VIEW v_in_stock AS
SELECT 
    p.id AS "Product ID",
    p.name AS "Product",
    b.name AS "Brand",
    CONCAT(ca.name,' - ',sc.name) AS "Product Type",
    CONCAT(p.size,' ', p.measure_type) AS "Size",
    p.price AS "Price"
FROM products p
JOIN brands b ON p.brand_id = b.id
JOIN category ca ON p.category_id = ca.id
JOIN subcategory sc ON p.subcategory_id = sc.id
WHERE p.out_of_stock = 0
ORDER BY p.id ASC;

CREATE VIEW v_customer_info AS
SELECT
	c.id AS "Customer ID",
    c.email AS "Email",
    CONCAT(c.first_name,' ', c.last_name) AS "Full Name",
    c.date_of_birth AS "Date of Birth",
    TIMESTAMPDIFF(YEAR,c.date_of_birth,NOW()) AS "Age",
    c.gender AS "Gender",
    c.country AS "Country",
    CONCAT(cd.skin_type,' - ',cd.skin_concern) AS "Skin Info",
    CONCAT(cd.hair_type,' - ',cd.hair_concern) AS "Hair Info"
FROM customers c
JOIN customer_details cd ON cd.customer_id = c.id;

CREATE VIEW v_shopping_historic AS
SELECT
	sh.id AS "Purchase ID",
    DATE(sh.date) AS "Date",
    c.email AS "Email",
    ch.channel_type AS "Channel",
    s.name AS "Store Name",
    sh.total_spent AS "Total Spent",
    GROUP_CONCAT(p.name SEPARATOR ' // ') AS "Purchased Products"
FROM shopping_history sh
JOIN customers c ON sh.customer_id = c.id
JOIN channel ch ON sh.channel_id = ch.id
LEFT JOIN stores s ON sh.store_id = s.id
JOIN shopping_details sd ON sh.id = sd.shopping_history_id
JOIN products p ON p.id = sd.product_id
GROUP BY sh.id
ORDER BY sh.date DESC;

CREATE VIEW v_customer_loved_products AS
SELECT
	p.id AS "Product ID",
    c.email AS "Email",
    CONCAT(b.name,' | ',p.name) AS "Product",
    p.price AS "Price",
    CASE
		WHEN p.out_of_stock = 0 THEN "Yes"
        ELSE "No"
	END AS "In Stock"
FROM loved_products lp
JOIN customers c ON lp.customer_id = c.id
JOIN products p ON lp.product_id = p.id
JOIN brands b ON p.brand_id = b.id
ORDER BY p.id ASC;

-- FUNCIONES --

DELIMITER //
CREATE FUNCTION vip_member(f_customer_email VARCHAR(100)) RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
	DECLARE total FLOAT;
    DECLARE vip VARCHAR(50);
    
    SELECT SUM(total_spent) INTO total
    FROM shopping_history sh
    JOIN customers c ON c.id = sh.customer_id
    WHERE c.email = f_customer_email
    AND DATEDIFF(sh.date, NOW()) < 365;
    
    IF total > 350 THEN
		SET vip = 'VIP';
	ELSE
		SET vip = 'No VIP';
	END IF;
RETURN vip;
END //


DELIMITER //
CREATE FUNCTION income_per_store(f_store_id INT,f_date_from DATE,f_date_to DATE) RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE total FLOAT;

    SELECT SUM(total_spent) INTO total
    FROM shopping_history
    WHERE store_id = f_store_id
    AND date BETWEEN f_date_from AND f_date_to;
    
    RETURN total;
END //


-- STORED PROCEDURES --

DELIMITER //
CREATE PROCEDURE new_purchase_order(
	IN p_customer_id INT,
    IN p_channel_id INT,
    IN p_store_id INT)
BEGIN
	INSERT INTO shopping_history (DATE, customer_id, channel_id, total_spent, store_id)
    VALUES (NOW(), p_customer_id, p_channel_id, 0, p_store_id);
END
//

DELIMITER //
CREATE PROCEDURE new_purchase_details(
	IN p_shopping_history_id INT,
    IN p_product_id INT)
BEGIN
	INSERT INTO shopping_details (shopping_history_id, product_id)
    VALUES (p_shopping_history_id, p_product_id);
END
//


DELIMITER //
CREATE PROCEDURE new_customer(
	IN p_first_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_date_of_birth DATE,
    IN p_gender VARCHAR(255),
    IN p_country VARCHAR(255),
    IN p_email VARCHAR(255),
    IN p_password VARCHAR(255))
BEGIN
	INSERT INTO customers (first_name,last_name,date_of_birth,gender,country,email,password,created_at,updated_at)
    VALUES (p_first_name,p_last_name,p_date_of_birth,p_gender,p_country,p_email,p_password,NOW(),NOW());
END
//


-- TRIGGERS --

DELIMITER //
CREATE TRIGGER update_customers
BEFORE UPDATE ON customers
FOR EACH ROW
SET NEW.updated_at = NOW();
//

DELIMITER //
CREATE TRIGGER check_existent_customer
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
	DECLARE email_exists INT;
    
	SELECT COUNT(*) INTO email_exists
    FROM customers
    WHERE email = NEW.email;
    
    IF email_exists > 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The email is already registered.';
	END IF;
END
//

DELIMITER //
CREATE TRIGGER validate_channel
BEFORE INSERT ON shopping_history
FOR EACH ROW
BEGIN    
    IF NEW.channel_id = 2
    AND NEW.store_id IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Online purchase should have a blank store_id';
	END IF;
END
//


DELIMITER //
CREATE TRIGGER update_total_spent
AFTER INSERT ON shopping_details
FOR EACH ROW
BEGIN
	DECLARE t_total_spent FLOAT;
    
    SELECT price INTO t_total_spent
    FROM products
    WHERE id = NEW.product_id;
    
    UPDATE shopping_history
    SET total_spent = total_spent + t_total_spent
    WHERE id = NEW.shopping_history_id;
END
//
