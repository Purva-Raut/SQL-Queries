/*Task no.1- Rename
Table name- 'product_datasets' to 'product_table'
rename columns-'p_code' to 'product_code'
               'p_name' to 'product_name'
               
Table name-'customer_datsets' to 'customer_table'
rename columns-'c_id' to 'customer_id'
               'c_name' to 'customer_name'
               'c_location' to 'customer_location'
               'c_phoneno' to 'customer_phone_number'
               
Table name-'sales_datasets' to 'sales_table'
rename columns-'order_no' to 'order_number'
                'c_id' to 'customer_id'
               'c_name' to 'customer_name'
                's_code' to 'product_code'
                'p_name' to'product_name'
                'qty' to 'quantity'*/

ALTER TABLE product_datasets RENAME TO product_table;
ALTER TABLE product_table RENAME COLUMN p_code TO product_code;
ALTER TABLE product_table RENAME COLUMN p_name TO product_name;

ALTER TABLE customer_datasets RENAME TO customer_table;
ALTER TABLE customer_table RENAME COLUMN c_id TO customer_id;
ALTER TABLE customer_table RENAME COLUMN c_name TO customer_name;
ALTER TABLE customer_table RENAME COLUMN c_location TO customer_location;
ALTER TABLE customer_table RENAME COLUMN c_phoneno TO customer_phone_number;

ALTER TABLE sales_datasets RENAME TO sales_table;
ALTER TABLE sales_table RENAME COLUMN order_no TO order_number;
ALTER TABLE sales_table RENAME COLUMN c_id TO customer_id;
ALTER TABLE sales_table RENAME COLUMN c_name TO customer_name;
ALTER TABLE sales_table RENAME COLUMN s_code TO product_code;
ALTER TABLE sales_table RENAME COLUMN p_name TO product_name;
ALTER TABLE sales_table RENAME COLUMN qty TO quantity;

SELECT * FROM customer_table;
SELECT * FROM product_table;
SELECT * FROM sales_table;

/* Task no.2 Write a query to add two columns 'S_no' and 'categories' to the sales table and then drop them.*/
ALTER TABLE sales_table
ADD S_no int,
ADD categories varchar(355);

SELECT * FROM sales_table;

ALTER TABLE sales_table
DROP COLUMN S_no,
DROP COLUMN categories;

SELECT * FROM sales_table;

/*task no.3-Write a query to change the column type of stock in the product table to varchar.*/
ALTER TABLE product_table
ALTER COLUMN stock TYPE VARCHAR;

SELECT stock FROM product_table;

/*Task no.4-Write a query to display customer id, order date, price, and quantity from the sales table.*/
SELECT customer_id,order_date,price,quantity FROM sales_table;

/*Task no.5-Write a query to display all the details in the product table if the category is stationary.*/
SELECT * FROM product_table
WHERE lower(category)='stationary';
/* lower makes sure that the search is case insensitive*/

/* Task no.6-Write a query to display a unique category from the product table.*/
SELECT DISTINCT(category)FROM product_table;

/*Task no.7-Write a query to display the sales details if quantity is greater than 2 and price is 
lesser than 500 from the sales table.*/
SELECT * FROM sales_table
WHERE quantity>2 AND price<500;

/* Task no.8-Write a query to display the customer’s name if the name ends with a.*/
SELECT customer_name FROM customer_table
WHERE customer_name LIKE '%a';

/*Task no.9-Write a query to display the product details in descending order of the price.*/
SELECT * FROM product_table
ORDER BY price DESC;

/*Task no.10-Write a query to display categories that have more than 2 products.Use product_table.*/
SELECT count(product_code) as num_of_products, category
FROM product_table
group by category
having count(product_code)>2
order by num_of_products;
