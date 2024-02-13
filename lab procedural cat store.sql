DROP SCHEMA IF EXISTS sp_cat_lab;
CREATE SCHEMA sp_cat_lab;
USE sp_cat_lab;

CREATE TABLE customers (
    id INT AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    PRIMARY KEY (id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT,
    customer_id INT,
    product_name VARCHAR(100),
    quantity INT,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

INSERT INTO customers (first_name, last_name, email)
VALUES
('Whiskers', 'McMeow', 'whiskers.mcmeow@catmail.com'),
('Fluffy', 'Purrington', 'fluffy.purrington@catmail.com'),
('Mittens', 'Clawson', 'mittens.clawson@catmail.com'),
('Shadow', 'Hissster', 'shadow.hissster@catmail.com'),
('Luna', 'Tailsworth', 'luna.tailsworth@catmail.com');

INSERT INTO orders (customer_id, product_name, quantity)
VALUES
(1, 'Catnip Toy', 2),
(1, 'Scratching Post', 1),
(1, 'Fish-shaped Food Bowl', 1),
(2, 'Catnip Toy', 3),
(2, 'Soft Bed', 1),
(2, 'Mouse Plush', 3),
(3, 'Mouse Plush', 4),
(3, 'Cat Collar with Bell', 1),
(3, 'Tuna Treats Pack', 2),
(4, 'Laser Pointer Toy', 1),
(4, 'Soft Bed', 2),
(4, 'Kitty Litter Scooper', 1),
(5, 'Sisal Ball', 3),
(5, 'Mouse Plush', 2),
(5, 'Catnip Pouch', 2);

DELIMITER $$
CREATE PROCEDURE get_customer_orders(IN c_id INT)
BEGIN
	SELECT * from orders WHERE orders.customer_id = c_id;
END$$
DELIMITER ;

CALL get_customer_orders("5");

select * from orders;
DELIMITER $$
CREATE PROCEDURE add_new_order(IN c_id INT, IN prod_name varchar(100), IN quant INT)
BEGIN
	INSERT INTO orders(customer_id, product_name, quantity) VALUE
    (c_id, prod_name, quant);
END$$
DELIMITER ;

call add_new_order(5, "lasagna", "10");

DELIMITER $$
CREATE PROCEDURE update_order_quantity(IN order_id INT, IN new_quant INT)
BEGIN
	UPDATE orders SET quantity = new_quant WHERE id = order_id;
END$$
DELIMITER ;

call update_order_quantity("16", "1");

DELIMITER $$
CREATE PROCEDURE delete_order(IN order_id INT)
BEGIN
	DELETE from orders WHERE orders.id = order_id;
END$$
DELIMITER ;

call delete_order("16");

DELIMITER $$
DROP PROCEDURE IF EXISTS find_customers_by_product;
CREATE PROCEDURE find_customers_by_product(IN prod_name VARCHAR(100))
BEGIN
	SELECT 
		c.*,
        o.quantity
    from customers c 
    JOIN orders o ON o.customer_id = c.id where o.product_name = prod_name;
END$$
DELIMITER ;


call find_customers_by_product("Mouse Plush");