USE sql_store;

SELECT 
	last_name, 
    first_name, 
    points, 
    (points * 10) + 100 AS 'discount factor'
FROM customers;
-- WHERE customer_id = 1
-- ORDER BY first_name

SELECT DISTINCT state
FROM customers;

SELECT 
	name, 
	unit_price,
    unit_price*1.1 AS new_price
FROM products;

SELECT *
FROM customers
WHERE points > 3000;

SELECT *
FROM customers
WHERE state = 'VA';

SELECT *
FROM customers
WHERE state <> 'VA';

SELECT *
FROM customers
WHERE birth_date > '1990-01-23';

SELECT *
FROM orders
WHERE order_date > '2018-12-31' AND order_date < '2020-01-01';


SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR 
	(points > 1000 AND state = 'VA');

SELECT *
FROM customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000);

SELECT *
FROM order_items
WHERE order_id = 6 AND (quantity * unit_price > 30);

SELECT *
FROM customers
WHERE state IN ('VA', 'FL', 'GA');


SELECT *
FROM customers
WHERE state NOT IN ('VA', 'FL', 'GA');

SELECT *
FROM products
WHERE quantity_in_stock IN (49,38,72);

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;

SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

SELECT *
FROM customers
WHERE last_name LIKE 'b%';


SELECT *
FROM customers
WHERE last_name LIKE '%b%';


SELECT *
FROM customers
WHERE last_name LIKE '_____y';


SELECT *
FROM customers
WHERE last_name LIKE 'b____y';


SELECT *
FROM customers
WHERE address LIKE '%trail%' OR 
	address LIKE '%avenue%';


SELECT *
FROM customers
WHERE phone LIKE '%9';


SELECT *
FROM customers
WHERE last_name LIKE '%field%';


SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e';
-- WHERE last_name REGEXP '[gim]e';
-- WHERE last_name REGEXP 'field$|mac|rose';
-- WHERE last_name REGEXP '^field|mac|rose';
-- WHERE last_name REGEXP 'field|mac|rose';
-- WHERE last_name REGEXP 'field|mac';
-- WHERE last_name REGEXP 'field$';
-- WHERE last_name REGEXP '^field';
-- WHERE last_name REGEXP 'field';
-- ^ begining $ end | pipeOR [] set [-] ranged set

SELECT *
FROM customers
WHERE first_name IN ('ELKA', 'AMBUR');


SELECT *
FROM customers
WHERE last_name REGEXP 'EY$|ON$';

SELECT *
FROM customers
WHERE last_name REGEXP '^MY|SE';


SELECT *
FROM customers
WHERE last_name REGEXP 'B[RU]';
-- WHERE last_name REGEXP 'BR|BU';
-- WHERE last_name REGEXP 'BR|BU';


SELECT *
FROM customers
WHERE phone IS NULL;


	SELECT *
	FROM customers
	WHERE phone IS NOT NULL;
    
    SELECT *
    FROM orders
    WHERE shipper_id IS NULL;
    
    SELECT *
    FROM customers
    ORDER BY first_name DESC;
    
    SELECT *
    FROM customers
    ORDER BY state ASC, first_name DESC;
    
    SELECT first_name, last_name
    FROM customers
    ORDER BY birth_date;
    
    SELECT first_name, last_name, 10 AS points
    FROM customers
    ORDER BY points, first_name DESC;
    
    SELECT first_name, last_name, 10 AS points
    FROM customers
    ORDER BY 1,2;
    -- avoid using numbers in order by
    
    SELECT *
    FROM order_items
    WHERE order_id = 2
    ORDER BY quantity * unit_price DESC;
    
     
    SELECT *, quantity * unit_price AS total_price
    FROM order_items
    WHERE order_id = 2
    ORDER BY total_price DESC;
    
    SELECT *
    FROM customers
    LIMIT 5;
        
    SELECT *
    FROM customers
    LIMIT 3,3;
    
    SELECT *
    FROM customers
    ORDER BY points DESC
    LIMIT 3;
    
    SELECT order_id, orders.customer_id, first_name, last_name
    FROM orders
    JOIN customers
		ON orders.customer_id = customers.customer_id;
	
    
    SELECT order_id, o.customer_id, first_name, last_name
    FROM orders o
    JOIN customers c
 		ON o.customer_id = c.customer_id;
        
	SELECT order_id, p.product_id, name, quantity, oi.unit_price
    FROM order_items oi
    JOIN products p
		ON oi.product_id = p.product_id;
        
	
	SELECT order_id, p.product_id, name, quantity, oi.unit_price
    FROM order_items oi
    JOIN sql_inventory.products p
		ON oi.product_id = p.product_id;
    
    SELECT 
		order_id,
        order_date,
        first_name,
        last_name,
        name
    FROM orders o
    JOIN order_statuses os ON o.status = os.order_status_id
    JOIN customers c ON o.customer_id = c. customer_id;
    
    USE sql_hr;

SELECT
	e.employee_id,
    e.first_name,
    er.first_name AS manager
FROM employees e
JOIN employees er
	ON e.reports_to = er.employee_id;

USE sql_invoicing;

SELECT
	p.date,
	p.payment_id,
    p.amount,
    c.name AS customer,
    pm.name AS payment_method
FROM payments p 
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
JOIN clients c 
		ON p.client_id = c.client_id;
        
USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;
    
SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id;
    
SELECT
	p.product_id,
    p.name AS product,
    oi.order_id
FROM order_items oi
RIGHT JOIN products p
	ON oi.product_id = p.product_id,

SELECT
	o.order_date,
    o.order_id,
    c.first_name,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id;
    
SELECT
	o.order_date,
    o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id
    USING (customer_id)
LEFT JOIN shippers sh
	-- ON o.shipper_id = sh.shipper_id;
    USING (shipper_id);
    
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	-- ON oi.order_id = oin.order_id
    -- AND oi.product_id = oin.product_id;
	USING (order_id, product_id);

USE sql_invoicing;

SELECT
	p.date,
    c.name AS client,
    p.amount,
    pm.name
FROM payments p
JOIN clients c 
	USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id;

USE sql_store;

SELECT *
FROM orders o
NATURAL JOIN customers c;
-- not recommended as it gives db control

SELECT
	c.first_name,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;
 
SELECT
	c.first_name,
    p.name AS product
FROM customers c, products p;


SELECT
	sh.name AS shipper,
    p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name;


SELECT
	sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY sh.name;

SELECT
	order_id,
    order_date,
    'ACTIVE' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT
	order_id,
    order_date,
    'ARCHIVE' AS status
FROM orders
WHERE order_date < '2019-01-01';

SELECT
	customer_id,
    first_name,
    points,
    'BRONZE' AS type
FROM customers
WHERE points<2000
UNION
SELECT
	customer_id,
    first_name,
    points,
    'SILVER' AS type
FROM customers
-- WHERE points>=2000 AND points<3000
	WHERE points BETWEEN 2000 AND 3000
UNION
SELECT
	customer_id,
    first_name,
    points,
    'GOLD' AS type
FROM customers
WHERE points>3000
ORDER BY first_name;

INSERT INTO customers
VALUES (
	DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    DEFAULT,
    'address',
    'city',
    'CA',
    DEFAULT);

INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
	'Peter',
    'Pan',
    '1991-01-01',
    'address',
    'city',
    'VA');
    
    SELECT *
    FROM customers;

INSERT INTO shippers (name)
VALUES ('Shipper1'),
		('Shipper2'),
        ('Shipper3');

SELECT *
FROM shippers;

SELECT *
FROM products;

INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Apple Pie', 34, 0.80),
		('Lemmon Tart', 12, 1.05),
        ('Blueberry Cheesecake', 5, 1.25);
        
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

SELECT LAST_INSERT_ID();

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 3.35),
		(LAST_INSERT_ID(), 3, 2, 4),
        (LAST_INSERT_ID(), 4, 3, 11.05);

SELECT *
FROM orders o
RIGHT JOIN order_items oi
USING (order_id);

CREATE TABLE orders_archived AS
SELECT *
FROM orders;

INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date > '2015-01-01'

USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT
	i.invoice_id,
    number,
    c.name AS customer,
    invoice_total,
    payment_total,
    invoice_date,
    due_date,
    payment_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_total > 0.00;

UPDATE invoices
SET payment_total = 1, payment_date = '2019-10-01'
WHERE invoice_id = 1;

SELECT *
FROM invoices;


UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE invoice_id = 1;


UPDATE invoices
SET payment_total = .5 * invoice_total, payment_date = due_date
WHERE invoice_id = 3;

UPDATE invoices
SET payment_total = .5 * invoice_total, payment_date = due_date
WHERE client_id = 3;


UPDATE invoices
SET payment_total = .25 * invoice_total, payment_date = due_date
WHERE client_id IN (4,5);

USE sql_store;

UPDATE customers
SET points = points+50
WHERE birth_date < '1990-01-01';

USE sql_invoicing;

UPDATE invoices
SET payment_total = .25 * invoice_total, payment_date = due_date
WHERE client_id = 
			(SELECT client_id
			FROM clients
			WHERE name = 'MyWorks');
            

UPDATE invoices
SET payment_total = .25 * invoice_total, payment_date = due_date
WHERE client_id IN
			(SELECT client_id
			FROM clients
			WHERE state IN ('CA','OR'));            

USE sql_store;

SELECT *
FROM orders;

UPDATE orders
SET comments = 'tasty food'
WHERE customer_id IN
		(SELECT customer_id
        FROM customers
        WHERE points>3000);
        
DELETE FROM invoices_archived
WHERE customer IN
	(SELECT name
    FROM clients
    WHERE name = 'MyWorks');