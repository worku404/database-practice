################################################################3###
#E-Ccommers Database Schema Setup Script

#Author Worku Wondoson / Gemini 2.5 flesh api

# Description : This scriipt sets up th efoundational tables and 
#constraints for a simpliefied e-commerce and constraints for 
#a simplified e-commerce platform . It includes DDL commands for creating tables, defining columns with approprate datatypes, 
#and implementing crutial constraints.
# like primary key , not null, unique and foreign key.


# SECTION 1: DATABASE SETUP AND CLEANUP
# Purpose To ensure a clean slate before creating new tables
# userful for development environments or re-deployments

# Drop tables in reverse  order of foreign key dependencies to avoid errors.
# If EXISTS prevent errors if th table doesn't exist yet.

DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Users;

# Create the database if it does not exist and swith to it.
# This is good practice for setting up your environment.

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

