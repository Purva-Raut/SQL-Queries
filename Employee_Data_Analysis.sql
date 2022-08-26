DROP TABLE IF EXISTS employee;
CREATE TABLE employee(
"employee_id" INT PRIMARY KEY NOT NULL , 
"first_name" VARCHAR(100), 
"last_name" VARCHAR(100), 
"job_id" VARCHAR(100), 
"salary" INT, 
"manager_id" INT,
"department_id" INT
);

COPY employee FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\SQL_Projects\4.Employee_Data_Analysis\employee.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

SELECT* FROM employee;

/*Write a query to find the first name and salary of the employee whose salary is higher than 
the employee with the last name Kumar from the employee table.*/

SELECT first_name, salary
FROM employee
WHERE salary >
(SELECT salary
FROM employee
WHERE lower(last_name)='kumar');

/*Write a query to display the employee id and last name of the employee whose salary is greater than
the average salary from the employee table.*/

SELECT employee_id,last_name
FROM employee
WHERE salary > 
(SELECT AVG(salary)
FROM employee);

/*Write a query to display the employee id, first name, and salary of the employees who earn a salary
that is higher than the salary of all the shipping clerks (JOB_ID = HP122). Sort the results of the salary 
in ascending order.*/

SELECT employee_id, first_name, salary
FROM employee
WHERE salary >
(SELECT salary
FROM employee
WHERE job_id='HP122')
ORDER BY salary;

/*Write a query to display the first name, employee id, and salary of the first three employees 
with highest salaries.*/

SELECT first_name,employee_id,salary
FROM employee
ORDER BY salary DESC
LIMIT 3;