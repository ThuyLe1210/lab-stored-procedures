use sakila;
-- 1. In the previous lab we wrote a query to find first name, last name, and emails of all the customers who rented Action movies. 
-- Convert the query into a simple stored procedure. 
DELIMITER //
create procedure action_movies_customers() 
begin
select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end //
DELIMITER ;
call action_movies_customers();

-- 2. Update the stored procedure in a such manner that it can take a string argument for the category name and return the results 
-- for all customers that rented movie of that category/genre
DELIMITER //
create procedure customers_info(in param varchar(25)) 
begin
select first_name, last_name, email, name
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = param
  group by first_name, last_name, email;
end //
DELIMITER ;
call customers_info("Animation");

-- 3. Write a query to check the number of movies released in each movie category

DELIMITER //
create procedure number_of_movies(in param int) 
begin
select count(film_id) as no_of_films, name
 from film 
  join film_category using (film_id)
  join category using (category_id)
  group by category_id
  having count(film_id)> param;
end //
DELIMITER ;

call number_of_movies(50);
