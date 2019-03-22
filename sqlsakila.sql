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
-- List the last names of actors, as well as how many actors have that last name.
SELECT last_name, count(last_name) FROM actor GROUP BY last_name;
-- List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors.
SELECT last_name, count(last_name) >= 2 FROM actor GROUP BY last_name;
-- The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. Write a query to fix the record.
UPDATE actor SET first_name ="HARPO" WHERE actor_id =172;
-- first name of the actor is currently HARPO, change it to GROUCHO
SET SQL_SAFE_UPDATES = 0;
UPDATE actor a SET first_name ="GROUCHO" WHERE a.first_name ="HARPO";
-- schema of the address table.
SHOW CREATE TABLE address;