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
-- Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
SELECT s.first_name, s.last_name, a.address
FROM staff s
INNER JOIN address a ON
s.address_id=a.address_id;
--  Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment
SELECT s.first_name, s.last_name, p.amount, p.payment_date
FROM payment p
INNER JOIN staff s ON
s.staff_id=p.staff_id
WHERE p.payment_date BETWEEN '2005/08/01' AND '2005/08/31';
-- **List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT f.title, fa.actor_id
FROM film f
INNER JOIN film_actor fa ON
f.film_id=fa.film_id;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT f.title, count(i.inventory_id)
FROM film f
INNER JOIN inventory i ON
f.film_id=i.film_id WHERE f.title ="Hunchback Impossible"
-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name
SELECT c.first_name, c.last_name, sum(p.amount)
FROM payment p
INNER JOIN customer c ON
c.customer_id=p.customer_id 
GROUP BY c.first_name,c.last_name  ORDER BY c.last_name asc;
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
-- Use subqueries to display all actors who appear in the film Alone Trip
-- You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information
SELECT c.first_name, c.last_name, c.email, co.country
FROM customer c 
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city ci ON ci.city_id = a.city_id
INNER JOIN country co ON ci.country_id = co.country_id
WHERE co.country = "Canada";
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films
SELECT f.title
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category ca ON ca.category_id = fc.category_id
WHERE ca.name = "Family";
-- Display the most frequently rented movies in descending order.
SELECT f.title
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY i.inventory_id DESC
-- Write a query to display how much business, in dollars, each store brought in.
SELECT sum(p.amount)
FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN store s ON s.store_id = i.store_id
GROUP BY s.store_id;
-- Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, c.city,co.country
FROM store s
INNER JOIN address a ON a.address_id = s.address_id
INNER JOIN city c ON a.city_id = c.city_id
INNER JOIN country co ON c.country_id = co.country_id
-- List the top five genres in gross revenue in descending order.
SELECT sum(p.amount), ca.name
FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film_category fc ON fc.film_id = i.film_id
INNER JOIN category ca ON fc.category_id = ca.category_id
GROUP BY ca.name ORDER BY sum(p.amount) DESC;
-- Use the solution from the problem above to create a view.
CREATE VIEW genresByRevDesc AS
SELECT sum(p.amount), ca.name
FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film_category fc ON fc.film_id = i.film_id
INNER JOIN category ca ON fc.category_id = ca.category_id
GROUP BY ca.name ORDER BY sum(p.amount) DESC;
-- How would you display the view
SELECT * FROM genresByRevDesc;
-- Drop the view
DROP VIEW genresByRevDesc;

