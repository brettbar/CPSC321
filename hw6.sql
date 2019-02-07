-- Brett Barinaga
-- CPSC 321
-- 10/20/2018
-- HW6

/*
1. Find the total number of films by category ordered from most to least. Give the name of each
category along with the number of corresponding films.
*/
	SELECT c.name, COUNT(*) AS Num_Films
	FROM film_category fc, category c 
	WHERE fc.category_id = c.category_id
	GROUP BY fc.category_id 
	ORDER BY COUNT(*) DESC;
/*
2. Find the number of films acted in by each actor ordered from highest number of films to
lowest. For each actor, give their first and last name and the number of films they acted in.
*/
	SELECT a.first_name, a.last_name, COUNT(*) AS Num_Films
	FROM film_actor fa JOIN actor a USING(actor_id)
	GROUP BY fa.actor_id
	ORDER BY COUNT(*) DESC;
/*
3. For each ‘PG’ rated films that costs 2.99 to rent find the number of times it has been rented.
The result should be sorted from most rented to least rented. For each film, give the film
title and the corresponding number of rentals.
*/

	SELECT f.title, COUNT(*) AS Num_Rentals
	FROM film f JOIN inventory i JOIN rental r JOIN payment p 
		ON f.film_id = i.film_id AND p.rental_id = r.rental_id AND r.inventory_id = i.inventory_id 
	WHERE f.rating = 'PG' AND p.amount = 2.99
	GROUP BY f.title 
	ORDER BY COUNT(*) DESC;

/*
4. Find all first and last names of customers that have rented at least six ‘R’ rated films costing
0.99 each to rent. For each customer give the number of such films they’ve rented.
*/
	SELECT c.first_name, c.last_name, COUNT(*) AS Num_Rentals 
	FROM film f JOIN customer c JOIN payment p JOIN rental r JOIN inventory i
		ON f.film_id = i.film_id AND r.inventory_id = i.inventory_id AND p.rental_id = r.rental_id 
		AND c.customer_id = r.customer_id
	WHERE p.amount = 0.99 AND f.rating = 'R' 
	GROUP BY c.customer_id;
/*
5. Find the total sales (of payments) for each film category sorted from highest total payments
to least. Give the name of each category and the total payments.
*/
	SELECT c.name, COUNT(*) AS Total_Payments
	FROM film_category fc JOIN inventory i JOIN payment p JOIN rental r JOIN category c
		ON fc.film_id = i.film_id AND i.inventory_id = r.inventory_id AND p.rental_id = r.rental_id 
		AND c.category_id = fc.category_id
	GROUP BY c.category_id
	ORDER BY COUNT(*) DESC;
/*
6. Find the film category (or categories if there is a tie) with the most number of ‘R’ rated films.
Your query cannot use limit. Return the category name and the corresponding number of R
rated films.
*/
	SELECT c.name, COUNT(*) AS Num_Films
	FROM film_category fc, film f, category c 
	WHERE fc.film_id = f.film_id AND 
		  c.category_id = fc.category_id AND
		  f.rating = 'R'
	GROUP BY c.category_id 
	ORDER BY COUNT(*) DESC;  
/*
7. Find the ’G’ rated film (or films if there is a tie) that have been rented the most number of
times. You cannot use limit and your query must return only the film(s) rented the most
number of times (not the second, third, etc). Return the film id, title, and the number of
times the film has been rented.
*/

	SELECT f.film_id, f.title, COUNT(*)
	FROM inventory i JOIN rental r JOIN film f ON r.inventory_id = i.inventory_id
		AND i.film_id = f.film_id 
	WHERE f.rating = 'G'
	GROUP BY f.film_id 
	HAVING COUNT(*) >= ALL (SELECT COUNT(*)
							FROM inventory i1 JOIN rental r1 JOIN film f1 ON r1.inventory_id = i1.inventory_id
								AND i1.film_id = f1.film_id 
							WHERE f1.rating = 'G'
							GROUP BY f1.film_id
							);
/*
8. Find the store (or stores if there is a tie) that have the most rentals. You cannot use limit and
your query must return only the store(s) that have the most rentals (not the second most,
third most, etc). Return the store id and the number of store rentals.
*/
	SELECT s.store_id, COUNT(*)
	FROM store s JOIN rental r JOIN inventory i ON 
		 s.store_id = i.store_id AND
		 r.inventory_id = i.inventory_id
	GROUP BY s.store_id 
	HAVING COUNT(*) >= ALL (SELECT COUNT(*)
								FROM store s1 JOIN rental r1 JOIN inventory i1 ON 
								 s1.store_id = i1.store_id AND
								 r1.inventory_id = i1.inventory_id
								 GROUP BY s1.store_id
							);

/*
9. For each staff member, find the movies they rented for 0.99 and the total number of times
that they were rented to customers by the staff member. Return the first and last name of
each staff member, the title of each movie, and the number of times each movie was rented
by the staff member. The results should be ordered by staff member last name followed by
first name. For each staff member, the movies that they have rented should be ordered from
most rented to least rented.
*/
	SELECT sf.first_name, sf.last_name, f.title, COUNT(*)
	FROM staff sf JOIN rental r JOIN inventory i JOIN film f JOIN payment p ON 
		 sf.store_id = i.store_id AND 
		 r.inventory_id = i.inventory_id AND
		 i.film_id = f.film_id AND 
		 p.rental_id = r.rental_id 
	WHERE p.amount = 0.99
	GROUP BY f.title, sf.staff_id
	ORDER BY sf.last_name, sf.first_name, COUNT(*) DESC;


/*
10. Come up with your own “interesting” query over the database schema. Your query should
involve group by, having, and (necessary) subqueries. Give your query, the query result, and
explain in plain English what the purpose of the query is.
*/
	SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS Num_Action_Films
	FROM actor a JOIN film_actor fa JOIN film_category fc JOIN category c ON 
		a.actor_id = fa.actor_id AND 
		fa.film_id = fc.film_id AND 
		fc.category_id = c.category_id
	WHERE c.name = 'Action'
	GROUP BY a.actor_id
	HAVING COUNT(*) >= 2
	ORDER BY COUNT(*) DESC;

	/*
		This query finds the actors who have been in at least 2 action films, and states their name
		and how many action films they have been in. It also sorts by actors with most action films to 
		least action films.
	*/



	