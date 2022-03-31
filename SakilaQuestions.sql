USE sakila;

-- 1) List all actors.
SELECT first_name, last_name FROM actor;

-- 2) Find the surname of the actor with the forename 'John'.
SELECT last_name FROM actor WHERE first_name = "John";

-- 3) Find all actors with surname 'Neeson'.
SELECT first_name, last_name FROM actor WHERE last_name = "Neeson";

-- 4) Find all actors with ID numbers divisible by 10.
SELECT first_name, last_name FROM actor WHERE actor_id LIKE "%0";

-- 5) What is the description of the movie with an ID of 100?
SELECT title, description FROM film WHERE film_id = 100;

-- 6) Find every R-rated movie.
SELECT title, rating FROM film WHERE rating = "R";

-- 7) Find every non-R-rated movie.
SELECT title, rating FROM film WHERE rating != "R";

-- 8) Find the ten shortest movies.
SELECT title, release_year, length FROM film 
ORDER BY length ASC LIMIT 10;

-- 9) Find the movies with the longest runtime, without using LIMIT.
SELECT title, release_year, length FROM film 
ORDER BY length DESC;

-- 10) Find all movies that have deleted scenes.
SELECT title, description, special_features FROM film WHERE special_features LIKE "%Deleted Scenes%";

-- 11) Using HAVING, reverse-alphabetically list the last names that are not repeated.
SELECT last_name FROM actor 
GROUP BY last_name HAVING COUNT(last_name) = 1;

-- 12) Using HAVING, list the last names that appear more than once, from highest to lowest frequency.
SELECT last_name, COUNT(last_name) AS nm_count FROM actor 
GROUP BY last_name HAVING COUNT(last_name) > 1
ORDER BY nm_count DESC;

-- 13) Which actor has appeared in the most films?
SELECT first_name, last_name, COUNT(actor_id) AS film_count FROM actors_in_films
GROUP BY actor_id
ORDER BY film_count DESC LIMIT 1;

-- 14) When is 'Academy Dinosaur' due?
SELECT title, release_year FROM film WHERE title = 'Academy Dinosaur';

-- 15) What is the average runtime of all films?
SELECT ROUND(AVG(length)) FROM film;

-- 16) List the average runtime for every film category.
SELECT category, AVG(length) AS avg_length FROM film_list
GROUP BY category
ORDER BY avg_length;

-- 17) List all movies featuring a robot.
SELECT title, description FROM film WHERE description LIKE "%robot%";

-- 18) How many movies were released in 2010?
SELECT COUNT(title) FROM film WHERE release_year = 2010;

-- 19) Find the titles of all the horror movies.
SELECT f.title, c.name FROM film AS f
JOIN film_category AS fc ON fc.film_id = f.film_id
JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name = "Horror";

-- 20) List the full name of the staff member with the ID of 2.
SELECT first_name, last_name FROM staff WHERE staff_id = 2 ;

-- 21) List all the movies that Fred Costner has appeared in. 
CREATE VIEW actors_in_films AS
	SELECT f.title, a.first_name, a.last_name, a.actor_id FROM film AS f
	JOIN film_actor AS fa ON fa.film_id = f.film_id
	JOIN actor AS a ON a.actor_id = fa.actor_id;
    
SELECT title FROM actors_in_films
WHERE first_name = "Fred" AND last_name = "Costner";

-- OR......

SELECT title FROM film_list
WHERE actors LIKE "%Fred Costner%";

-- 22) How many distinct countries are there?
SELECT COUNT(DISTINCT(country)) FROM country;

-- 23) List the name of every language in reverse-alphabetical order.
SELECT language.name FROM language 
ORDER BY language.name DESC;

-- 24) List the full names of every actor whose surname ends with '-son' in alphabetical order by their forename.
SELECT first_name, last_name FROM actor WHERE last_name LIKE "%son"
ORDER BY first_name;

-- 25) Which category contains the most films?
SELECT c.name, COUNT(fc.film_id) AS counter FROM category AS c 
LEFT JOIN film_category AS fc ON fc.category_id = c.category_id
GROUP BY c.category_id, c.name
ORDER BY counter DESC LIMIT 1;