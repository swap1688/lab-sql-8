# Lab | SQL Queries 8
USE sakila;
#1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

SELECT title, length, DENSE_RANK() OVER (ORDER BY length DESC) as 'rank'
FROM film
WHERE length > 0;

#2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.  
SELECT title, length ,rating, RANK() OVER(PARTITION BY length ORDER BY rating) as 'rank'
FROM film;

#3. How many films are there for each of the categories in the category table? 
-- **Hint**: Use appropriate join between the tables "category" and "film_category".
SELECT distinct(c.category_id),c.name as 'category_name', count(f.film_id) as 'count_of_films'
FROM category as c
INNER JOIN film_category as f
ON c.category_id = f.category_id
GROUP BY c.category_id;


#4. Which actor has appeared in the most films? 
-- **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.first_name,a.last_name,count(f.film_id) as 'count'
FROM actor as a
INNER JOIN film_actor as f
ON a.actor_id = f.actor_id
GROUP BY a.actor_id
ORDER BY count(a.actor_id) DESC
LIMIT 1;

SELECT CONCAT(first_name," ", last_name) as full_name, COUNT(film_id) as film_starring -- decided to join first and last names to create just one column. makes things simpler, I think :)
FROM actor as a
INNER JOIN film_actor as f
USING (actor_id)
GROUP BY full_name
ORDER BY film_starring DESC
LIMIT 1;

SELECT *
FROM actor
WHERE first_name = 'SUSAN';

#5. Which is the most active customer (the customer that has rented the most number of films)? 
-- **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.
SELECT c.customer_id,c.first_name,c.last_name, count(r.rental_id) as 'rental_count' 
FROM rental as r
INNER JOIN customer as c
ON r.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY rental_count DESC
LIMIT 1;


-- **Bonus**: Which is the most rented film? (The answer is Bucket Brotherhood).

#This query might require using more than one join statement. Give it a try. We will talk about queries with multiple join statements later in the lessons.

-- **Hint**: You can use join between three tables - "Film", "Inventory", and "Rental" and count the *rental ids* for each film.
