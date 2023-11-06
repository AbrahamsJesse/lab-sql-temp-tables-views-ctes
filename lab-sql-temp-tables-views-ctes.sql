/*- SELECT, FROM, ORDER BY, LIMIT, WHERE, GROUP BY, and HAVING clauses. DISTINCT, AS keywords.
- Built-in SQL functions such as COUNT, MAX, MIN, AVG, ROUND, DATEDIFF, or DATE_FORMAT.
- JOIN to combine data from multiple tables.
- Subqueries
- Temporary Tables, Views, CTEs*/

/*Temporary tables are physical tables stored in the database that can store intermediate results for a 
specific query or stored procedure. Views and CTEs, on the other hand, are virtual tables that do not 
store data on their own and are derived from one or more tables or views. They can be used to simplify complex 
queries. Views are also used to provide controlled access to data without granting direct access to the underlying tables.*/

/*Through this lab, you will practice how to create and manipulate temporary tables, views, 
and CTEs. By the end of the lab, you will have gained proficiency in using these concepts to simplify 
complex queries and analyze data effectively.*/

 /*Challenge*/

/***Creating a Customer Summary Report*/

/*In this exercise, you will create a customer summary report that summarizes key information about customers in 
the Sakila database, including their rental history and payment details. The report will be generated using a 
combination of views, CTEs, and temporary tables.*/

/*- Step 1: Create a View*/

/*First, create a view that summarizes rental information for each customer. The view should include the customer's 
ID, name, email address, and total number of rentals (rental_count).*/

#views can be updates
#temporary cannot be updated
use sakila;

CREATE VIEW total_rental_customer as(
	select rental.customer_id, concat(customer.first_name, ' ', customer.last_name) as fullname, customer.email, count(*) as rental_count
	from sakila.rental
	inner join customer
	on rental.customer_id = customer.customer_id
	group by customer.email;
select * from total_rental_customer;
#group buy always goes with mathtmatical functions on SELECT

##############TRY
select avg(rental_rate), rating
from sakila.film
group by rating;


/*- Step 2: Create a Temporary Table*/
/*Temporary Table should use the rental summary view created in Step 1 to join with the payment table and calculate 
the total amount paid by each customer.*/

/*CREATE TEMPORRATY TABLE total_rental_customer as (*/

select sum(payment.amount) as total_paid, total_rental_customer.fullname
from total_rental_customer
inner join payment
on total_rental_customer.customer_id = payment.customer_id
group by total_rental_customer.customer_id
order by total_paid DESC;

/*select * from total_rental_customer;*/

/*- Step 3: Create a CTE and the Customer Summary Report*/
/*Create a CTE that joins the rental summary View with the customer payment summary Temporary Table created in Step 2.
 The CTE should include the customer's name, email address, rental count, and total amount paid. */
/*Next, using the CTE, create the query to generate the final customer summary report, which should include: customer 
name, email, rental_count, total_paid and average_payment_per_rental, this last column is a derived column from total_paid 
and rental_count.*/