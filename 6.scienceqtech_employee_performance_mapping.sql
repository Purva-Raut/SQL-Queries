DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    "emp_id" CHAR(4) PRIMARY KEY NOT NULL,
    "first_name" VARCHAR(50),
    "last_name" VARCHAR(50),
    "gender" CHAR(1),
    "role" VARCHAR(50),
    "dept" VARCHAR(50),
    "exp" INT,
    "country" VARCHAR(50),
    "continent" VARCHAR(50),
    "salary" INT,
    "emp_rating" INT,
    "manager_id" CHAR(4)
);

COPY employees FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\4.SQL\SQL_Project\employees.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

SELECT * FROM employees;


DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
    "proj_id" char(4),
    "proj_name" varchar(50),
    "domain" VARCHAR(50),
    "start_date" DATE ,
    "closure_date" DATE ,
    "dev_qtr" CHAR(2),
    "status" VARCHAR (50)
);

COPY projects FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\4.SQL\SQL_Project\projects.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

SELECT * FROM projects;


DROP TABLE IF EXISTS ds_team;

CREATE TABLE ds_team (
    "emp_id" CHAR(4),
    "first_name" VARCHAR(50),
    "last_name" VARCHAR (50),
    "gender" CHAR (1),
    "role" VARCHAR(50),
    "dept" VARCHAR(50),
    "exp" INT,
    "country" VARCHAR(50),
    "continent" VARCHAR(50)

);

COPY ds_team FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\4.SQL\SQL_Project\ds_team.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

SELECT * FROM ds_team;


/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table,
and make a list of employees and details of their department*/

SELECT DISTINCT(emp_id), first_name, last_name,gender,dept
FROM employees;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
less than two
greater than four 
between two and four*/

SELECT emp_id, first_name, last_name,gender,dept,emp_rating,
CASE
WHEN emp_rating<2 THEN 'low_rating'
WHEN emp_rating BETWEEN 2 AND 4 THEN 'mid_rating'
WHEN emp_rating >4 THEN 'high_rating'
END AS emp_rating_group
FROM employees
ORDER BY emp_rating;

/*Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department
from the employee table and then give the resultant column alias as NAME.*/

SELECT CONCAT(first_name,' ', last_name) AS NAME
FROM employees
WHERE lower(dept) = 'finance';

/*Write a query to list only those employees who have someone reporting to them. 
Also, show the number of reporters (including the President).*/

SELECT DISTINCT(m.manager_id), e.first_name, e.last_name
FROM employees e
RIGHT JOIN employees m
ON e.emp_id=m.manager_id;
/*We have joined the same table using aliases and this will give us names of the managers only*/

SELECT manager_id,COUNT(emp_id) AS NO_OF_REPORTERS
FROM employees
GROUP BY manager_id;
/*This gives us no.of reporters reporting to the managers but doe not give the names of the managers*/

/*Write a query to list down all the employees from the healthcare and finance departments using union.
Take data from the employee record table.*/
SELECT emp_id,first_name,last_name,dept FROM employees
WHERE lower(dept)='healthcare'
UNION
SELECT emp_id,first_name,last_name,dept FROM employees
WHERE lower(dept)='finance'
ORDER BY emp_id;
/*The SQL UNION operator is used to combine the result sets of 2 or more SELECT statements.
It removes duplicate rows between the various SELECT statements(UNION ALL keeps the duplicates).
Each SELECT statement within the UNION must have the same number of fields in the result sets with similar data types.*/

SELECT emp_id,first_name,last_name,dept FROM employees
WHERE lower(dept)='healthcare' or lower(dept)='finance'
ORDER BY emp_id;
/*We get the same result using the above query*/

/*Extract employee names and projects in domain -'healthcare' and 'finance' using UNION of employees and projects tables*/
SELECT e.emp_id as id,CONCAT(e.first_name,' ',e.last_name) AS name,e.dept FROM employees e
WHERE lower(e.dept)in ('healthcare','finance')
UNION
SELECT p.proj_id,p.proj_name,p.domain FROM projects p
WHERE lower(p.domain) in ('healthcare','finance')
ORDER BY id,dept;

/*Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and 
EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the 
department.*/
SELECT emp_id,first_name,last_name, role,dept,emp_rating,max(emp_rating) OVER (PARTITION BY dept) AS max_emp_rating
FROM employees
ORDER BY dept;
/*Window functions operate on a set of rows and return a single aggregated value for each row. 

Types of Window functions
*Aggregate Window Functions
SUM(), MAX(), MIN(), AVG(). COUNT()
*Ranking Window Functions
RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
*Value Window Functions
LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE()

We have used aggregate windows function max in our exercise.OVER:Specifies the window clauses for aggregate functions.
PARTITION BY partition_list:Defines the window (set of rows on which window function operates) for window functions. 
We need to provide a field or list of fields for the partition after PARTITION BY clause. 
Multiple fields need be separated by a comma as usual. If PARTITION BY is not specified, grouping will be done on 
entire table and values will be aggregated accordingly.*/

/*Write a query to calculate the minimum and the maximum salary of the employees in each role. 
Take data from the employee record table.*/
SELECT role, MIN(salary) AS min_salary,MAX(salary) AS max_salary
FROM employees
GROUP BY ROLE
ORDER BY max_salary;
/* using simple aggregate function and group by clause that operates on an entire table and causes rows
to become grouped into a single output row*/

SELECT emp_id,first_name,last_name, role, salary, min(salary) OVER (PARTITION BY role) AS min_salary ,
max(salary) OVER (PARTITION BY role) AS max_salary
FROM employees
ORDER BY max_salary;
/* using windows aggregate function which operates on a set of rows and return a single aggregated value for each row.
The rows retain their separate identities and an aggregated value will be added to each row.*/

/*Write a query to assign ranks to each employee based on their experience. 
Take data from the employee record table.*/
SELECT emp_id,first_name,last_name, exp, RANK() OVER (ORDER BY exp)
FROM employees;
/*ORDER BY order_list:Sorts the rows within each partition. If ORDER BY is not specified, ORDER BY uses 
the entire table.

The RANK() function is used to give a unique rank to each record based on a specified value.
If two records have the same value then the RANK() function will assign the same rank to both records by
skipping the next rank.*/

SELECT emp_id,first_name,last_name, exp, DENSE_RANK() OVER (ORDER BY exp)
FROM employees;
/*The DENSE_RANK() function is identical to the RANK() function except that it does not skip any rank. 
This means that if two identical records are found then DENSE_RANK() will assign the same rank to both records 
but not skip then skip the next rank.*/

/*Write a query to create a view that displays employees in various countries whose salary is more than six thousand.
Take data from the employee record table.*/

CREATE VIEW emp_sal_above_6000 AS
SELECT emp_id, first_name, last_name, country, salary
FROM employees
WHERE salary > 6000
ORDER BY salary;

SELECT * FROM emp_sal_above_6000;

/* A view is simply a virtual table. Think of it as just a query that is stored on SQL Server and when used by a user,
it will look and act just like a table but it’s not. It is a view and does not have a definition or structure of a 
table.Its definition and structure is simply a query that, under the hood, can access many tables or a part of a
table.

Views can be used for a few reasons. Some of the main reasons are as follows:

*To simplify database structure to the individuals using it
*As a security mechanism to DBAs for allowing users to access data without granting them permissions to 
directly access the underlying base tables
*To provide backward compatibility to applications that are using our database */

/*Write a nested query to find employees with experience of more than ten years.
Take data from the employee record table.*/

SELECT emp_id, first_name, last_name,exp
FROM employees
WHERE exp in
(SELECT exp
FROM employees
WHERE exp>10)
ORDER BY exp;

/* What is a stored procedure?
Stored procedure is a prepared sql code which can be saved and reused. So if we need a sql query that we write over
and over again, we can save it as a stored procedure  and then call it whenever we want*/

/*Write a query to calculate the bonus for all the employees, based on their ratings and salaries 
(Use the formula: 5% of salary * employee rating).*/

SELECT emp_id,first_name,last_name,emp_rating,salary,0.05*salary*emp_rating AS bonus
FROM employees
ORDER BY bonus;

/*Write a query to calculate the average salary distribution based on the continent and country.
Take data from the employee record table.*/

SELECT continent, COALESCE(country,'all_countries') AS country,CEIL(AVG(salary)) AS avg_salary
FROM employees
GROUP BY ROLLUP (continent, country)
ORDER BY continent ;

/*The ROLLUP is an extension of the GROUP BY clause. The ROLLUP option allows you to include extra rows that 
represent the subtotals, which are commonly referred to as super-aggregate rows, along with the grand total row. 
By using the ROLLUP option, you can use a single query to generate multiple grouping sets.
To make the output more readable, you can use the COALESCE() function to substitute the NULL value*/









