-- ################################################################3###
-- #E-Ccommers Database Schema Setup Script

-- #Author Worku Wondoson / Gemini 2.5 flesh api

-- # Description : This scriipt sets up th efoundational tables and 
-- #constraints for a simpliefied e-commerce and constraints for 
-- #a simplified e-commerce platform . It includes DDL commands for creating tables, defining columns with approprate datatypes, 
-- #and implementing crutial constraints.
-- # like primary key , not null, unique and foreign key.


-- # SECTION 1: DATABASE SETUP AND CLEANUP

-- # Purpose To ensure a clean slate before creating new tables
-- # userful for development environments or re-deployments

-- # Drop tables in reverse  order of foreign key dependencies to avoid errors.
-- # If EXISTS prevent errors if th table doesn't exist yet.

DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;

# Create the database if it does not exist and swith to it.
# This is good practice for setting up your environment.

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;


-- ############################################################
-- #SECTION 2: TABLE CREATION

-- # Purpose : define the structure of our core entities.
-- # each table includes column definition with datatypes and column lever constraints




-- # Table : Users
-- # Stores information about customers and administrators

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(200) NOT NULL UNIQUE,
    password_hash VARCHAR(200) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- # TABLE : Categories 
-- # Organizes products into different groups (e.g electornic, food)

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT
);



-- # TABLE: Products
-- # detail information about items available for sale

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


# Table : Addresses
# Store physical addresses for users (shipping, billing).
# A user can have multiple addresses


CREATE TABLE Addresses(
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    
    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    is_default BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);



-- # Table : Orders
-- # Represents a customer's purchase.

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    
    status VARCHAR(10) DEFAULT 'pending',
    shipping_address_id INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- # Table : Order_items
-- # Juction table linking Orders and Products, detailing each item in an order.


CREATE TABLE Order_Items(
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10, 2) NOT NULL,

    UNIQUE (order_id, product_id)
);


##########################################################

# SECTION 3: 
# Pursose: Establish relationships between tables , ensureing referential integrity.
# Addign them here after all tables are created 

ALTER TABLE products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (category_id) REFERENCES categories(category_id)
ON DELETE RESTRICT 
ON UPDATE CASCADE;

-- Add foreign key to addresses table referencing  users
ALTER TABLE addresses
ADD CONSTRAINT fk_address_user
FOREIGN KEY (user_id) REFERENCES users(user_id)
ON DELETE CASCADE ON UPDATE CASCADE;

-- add foreign key to orders table referencing users
ALTER TABLE Orders
ADD CONSTRAINT fk_order_user
FOREIGN KEY (user_id) REFERENCES users(user_id)
ON DELETE CASCADE ON UPDATE CASCADE;


-- aDD FOREIGN KEY TO ORDERS TALE REFERENCING SHIPPING ADDRESS
ALTER TABLE orders
ADD CONSTRAINT fk_order_shipping_address
FOREIGN KEY (shipping_address_id) REFERENCES addresses(address_id)
ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE order_items
ADD CONSTRAINT fk_order_item_order
FOREIGN KEY (order_id) REFERENCES orders(order_id)
ON DELETE CASCADE ON UPDATE CASCADE;



ALTER TABLE order_items
ADD CONSTRAINT fk_order_item_product
FOREIGN KEY (product_id) REFERENCES products(product_id)
ON DELETE RESTRICT ON UPDATE CASCADE;


