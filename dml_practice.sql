-- # E-commerce Database DML Oprations Script

-- #Author: Gold/ Gemini 2.5 flesh boom shakalaka
-- # Date 2026-04-02

-- # Description : this script demonstrates various DML commands 
--     -- SELECT
--     -- INSERT
--     -- UPDATE
--     -- DELETE
-- # for e-commerce database schema. It covers basic operations, filtering, sorting , joins, aggregations,  subqueries and TRANSACTION


-- # Prerequisite: the ddl_practice.sql script must have been excuted successfully to set up the database structure and intial data.ABORT

-- # let's start
-- ############################################################
-- # SECTION 1: INSERT Operations - adding new data
-- # purpose: demonstrate how to add single and multiple rows.ABORT
-- #############################################################

USE ecommerce_db;

-- insert a single new user 
--note: usre_id will be auto generated. created_at/updated_ad will be default

INSERT INTO users(
    username,
    email,
    password_hash,
    first_name,
    last_name,
    is_admin
) VALUES(
    'gold', 
    'goldabcd@gmail.com',
    'securehash_gold_abc',
    'Worku',
    'wondoson',
    TRUE
);

--verify
SELECT * FROM users where username='gold';


--insert mutiple new product using single insert statement
-- using subqueries to get category_id dynamically, making the script robust



INSERT INTO products (
    name,
    description,
    price,
    stock_quantity,
    category_id
) VALUES(
    'mechanical keyboard',
    'high-quality mechanical keyboard for gaming and typing',
    99.99,
    75,
    (SELECT category_id from categories WHERE name='electronics')
);

-- multiple rows

INSERT INTO products (
    name,
    description,
    price,
    stock_quantity,
    category_id
) VALUES 
(
    'shoe',
    'yabede 0 0 nike shoe',
    5000,
    2,
    (SELECT category_id FROM categories WHERE name='clothes')
),
(
    'sql master book',
    'advanced concepts and practical examples',
    55,
    10,
    (SELECT category_id FROM categories WHERE name='books')
),
(
    't-shert',
    'bonda tishert',
    10,
    20,
    (SELECT category_id FROM categories WHERE name='clothes')
);


# verify
SELECT name, price, stock_quantity
FROM products WHERE
name LIKE '%keyboard%' OR description LIKE '_abede%';


#####################################
# INSERT a new address for the newly created user(worku)

#######################
-- outof scope
SELECT * FROM addresses;
DESC addresses;
###########################

INSERT INTO addresses(
 user_id,
 address_line1,
 city,
 state,
 postal_code,
 country,
 is_default
) VALUES(
    (SELECT user_id FROM users WHERE username='gold'),
    'AASTU',
    'AA',
    'ETH',
    '1000',
    'Ethiopia',
    FALSE
)


######## verify
SELECT U.username, A.address_line1, A.city
FROM users U
INNER JOIN addresses A ON U.user_id=A.user_id
WHERE U.username='gold';




#####################3 Basic SELECT with specific COLUMN

SELECT DISTINCT name, price, stock_quantity
FROM products;

####################
# filtering with where clause   
    -- a, productswith price > 100
    -- users who are not adminstrations
    -- orders placed after a specific date
    -- products conataining 'book' in their name 
    -- users whose first name is john or alice
    -- product quantity with reange 20-3000
####################


SELECT name, price,description 
FROM products
WHERE price>100;

SELECT first_name, last_name as fatherName FROM users
WHERE is_admin=TRUE;

SELECT order_id, order_date, total_amount from orders
WHERE order_date > '1999-10-03';

SELECT name, price, description 
FROM products
WHERE name LIKE '%book%';


SELECT first_name as NAME
FROM users
WHERE first_name='worku'   OR first_name='john';

SELECT name, description 
FROM products
WHERE price BETWEEN 20 AND 3000;

