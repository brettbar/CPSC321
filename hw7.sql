-- Brett Barinaga
-- CPSC 321
-- 10/29/2018
-- HW7

/*

============================================================================================
										PART 2
============================================================================================
1. Write an SQL query using subqueries to find the actors/actresses that have not acted in a
‘G’ rated film.
*/
	SELECT a.first_name, a.last_name
	FROM actor a
	WHERE a.actor_id NOT IN (SELECT fa.actor_id 
							 FROM film_actor fa JOIN film f
							 	ON fa.film_id = f.film_id
							 WHERE f.rating = 'G');
/*
2. Write an SQL query to find the film titles that all stores carry (i.e., in all store’s inventories).
Assume there can be any number of stores. Thus, your query must not assume a certain
number of stores. Your query also cannot use COUNT(). (Hint: it isn’t difficult using
subqueries to find stores that don’t have a particular film.)
*/
	SELECT f.title
	FROM film f
	WHERE f.film_id IN (SELECT i.film_id
						FROM inventory i JOIN film f1 USING (film_id)
						WHERE i.store_id IN (SELECT s.store_id
											 FROM store s) );
/*
3. Write an SQL query to find the percentage of ‘G’-rated movies each actor/actress has acted
in. Your query should return the id, first name, and last name of each actor/actress and the
corresponding percentage. Your results should be sort actors/actresses from highest to lowest
corresonding percentage. For this query, you only need to consider actors/actresses that have
acted in at least one ‘G’-rated movie.
*/
	SELECT a.actor_id, a.first_name, a.last_name, (COUNT(*) * 100 / (SELECT COUNT(*) FROM film WHERE film.rating = 'G' )) as Percent
	FROM actor a JOIN film_actor fa USING (actor_id) JOIN film f USING (film_id)
	WHERE f.rating = 'G'
	GROUP BY a.actor_id
	ORDER BY Percent DESC;

/*
4. Write an SQL query using an outer join to find all of the film titles that do not have any
actors
*/
	SELECT f.title
	FROM film f LEFT JOIN film_actor fa ON f.film_id = fa.film_id
	WHERE fa.actor_id IS NULL;

/*
5. Write an SQL query using an outer join to find all of the film titles that are in a store’s
inventory but that have not been rented.
*/
	SELECT DISTINCT f.title 
	FROM film f JOIN inventory i USING (film_id) LEFT JOIN rental r USING (inventory_id)
	WHERE r.rental_id IS NULL;
	

/*
6. Write an SQL query using an outer join to find all of the film titles that are not in any store’s
inventory.
*/
	SELECT DISTINCT f.title  
	FROM film f LEFT JOIN inventory i USING (film_id)
	WHERE i.inventory_id is NULL;

/*
7. Write an SQL query to find the number of actors that acted in each film. Return the
film id and the number of associated actors. Based on your query result, how many films
are there without an actor? Note that there should be more than one such film! Hint:
COUNT(columname) only counts the number of non-NULL values in the values of columname.
*/
	SELECT f.film_id, COUNT(*)
	FROM film_actor fa JOIN actor a USING(actor_id) RIGHT JOIN film f USING(film_id)
	GROUP BY f.film_id
	ORDER BY COUNT(*) DESC;
