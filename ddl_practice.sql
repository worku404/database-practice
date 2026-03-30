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
DROP TABLE IF EXISTS Users;

# Create the database if it does not exist and swith to it.
# This is good practice for setting up your environment.

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

#SECTION 2: TABLE CREATION

# Purpose : define the structure of our core entities.
# each table includes column definition with datatypes and column lever constraints




# Table : Users
# Stores information about customers and administrators

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


# TABLE : Categories 
# Organizes products into different groups (e.g electornic, food)

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
);



# TABLE: Products
# detail information about items available for sale

