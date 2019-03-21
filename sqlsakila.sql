-- Use database
USE sakila;
-- Display the first and last names of all actors from the table actor
SELECT first_name,last_name from actor;
-- Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT CONCAT(first_name,' ', last_name) as Actor_Name from actor;
-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe."
SELECT * FROM actor where first_name ="Joe";
--  Find all actors whose last name contain the letters GEN
SELECT * FROM actor where last_name like '%GEN';
-- Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, 
SELECT * FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name;
-- Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
SELECT * FROM country WHERE country IN('Afghanistan','Bangladesh','China');
-- create a column in the table actor named description and use the data type BLOB 
ALTER TABLE actor ADD description BLOB;
-- Delete the description column.
ALTER TABLE actor DROP description;