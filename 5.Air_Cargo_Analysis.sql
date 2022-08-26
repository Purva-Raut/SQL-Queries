/*Write a query to display all the passengers (customers) who have travelled in routes 01 to 25. 
Take data  from the passengers_on_flights table.*/

SELECT DISTINCT(p.customer_id), CONCAT(c.first_name,' ',c.last_name) AS passenger
FROM passengers_on_flights p
LEFT JOIN customers c
ON p.customer_id=c.customer_id
WHERE p.route_id BETWEEN 01 AND 25;

/*Write a query to identify the number of passengers and total revenue in business class 
from the ticket_details table.*/

SELECT COUNT(customer_id) AS num_passengers_BC, SUM(price_per_ticket) AS total_revenue_BC
FROM ticket_details
WHERE lower(class_id)='bussiness';

/*Below query gives passenger count and total revenuew for all the classes*/
SELECT COUNT(customer_id) AS num_passengers, SUM(price_per_ticket) AS total_revenue, class_id
FROM ticket_details
GROUP BY class_id;

/*Write a query to display the full name of the customer by extracting the first name and last name
from the customer table.*/

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customers;

/*Write a query to extract the customers who have registered and booked a ticket.
Use data from the customer and ticket_details tables.*/
SELECT DISTINCT(t.customer_id), CONCAT(c.first_name,' ',c.last_name) as passenger_name
FROM ticket_details t
INNER JOIN customers c
ON t.customer_id= c.customer_id
WHERE t.no_of_tickets>=1
ORDER BY t.customer_id ;

/*Write a query to identify the customer’s first name and last name based on their customer ID 
and brand (Emirates) from the ticket_details table.*/

SELECT DISTINCT(t.customer_id),c.first_name,c.last_name,t.brand
FROM ticket_details t
INNER JOIN customers c
ON t.customer_id= c.customer_id
WHERE lower(t.brand)='emirates';

/*Write a query to identify the count of customers who have travelled by Economy Plus class using Group By and 
Having clause on the passengers_on_flights table.*/
SELECT COUNT(DISTINCT customer_id) as Num_Passengers,class_id
FROM passengers_on_flights
GROUP BY class_id
HAVING class_id='Economy Plus';

/*Write a query to identify whether the revenue has crossed 10000 using ticket_details table.*/
SELECT SUM(no_of_tickets*Price_per_ticket)AS total_revenue,
CASE
WHEN SUM(no_of_tickets*Price_per_ticket) >10000 THEN 'YES'
WHEN SUM(no_of_tickets*Price_per_ticket) <=10000 THEN 'NO'
END as exceeds_10000
FROM ticket_details;

/*Write a query to find the maximum ticket price for each class in the ticket_details table.*/
SELECT class_id, MAX(Price_per_ticket) AS max_price
FROM ticket_details
GROUP BY class_id
ORDER BY max_price DESC;

/* Same result can be obtained by using Distinct and Windows function*/
SELECT DISTINCT(class_id), MAX(Price_per_ticket) OVER (PARTITION BY class_id) AS max_price
FROM ticket_details
ORDER BY max_price DESC;

/*Write a query to calculate the total price of all tickets booked by a customer across different 
aircraft IDs using rollup function.*/

SELECT customer_id, COALESCE(aircraft_id,'All_aircrafts'),SUM(no_of_tickets* Price_per_ticket)
FROM ticket_details
GROUP BY ROLLUP (customer_id, aircraft_id)
ORDER BY customer_id;

/*The ROLLUP is an extension of the GROUP BY clause. The ROLLUP option allows you to include extra rows that 
represent the subtotals, which are commonly referred to as super-aggregate rows, along with the grand total row. 
By using the ROLLUP option, you can use a single query to generate multiple grouping sets.
To make the output more readable, you can use the COALESCE() function to substitute the NULL value*/
