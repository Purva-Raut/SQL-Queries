/*Task 1:Write a query to create a students table with appropriate data types for student id, 
student first name, student last name, class, and age where the student last name, student first name, 
and student id should be a NOT NULL constraint, and the student id should be in a primary key.*/

DROP TABLE IF EXISTS students_table;

CREATE TABLE students_table (
"student_id" INT PRIMARY KEY NOT NULL,
"first_name" VARCHAR(100) NOT NULL,
"last_name" VARCHAR(100) NOT NULL,
"class" INT,
"age" INT
);

SELECT * FROM students_table;

/*Task 2: Write a query to create a marksheet table that includes score, year, ranking, class, and student id.*/

DROP TABLE IF EXISTS marksheet_table;

CREATE TABLE marksheet_table(
"score" INT,
"year" INT,
"ranking" INT,
"class" INT,
"student_id" INT
);

SELECT * FROM marksheet_table;

/*Task 3:Write a query to insert values in students and marksheet tables.*/

INSERT INTO students_table (student_id, first_name, last_name, class,age)
VALUES (1,'krishna','gee',10,18),
(2,'Stephen','Christ',10,17),
(3,'Kailash','kumar',10,18),
(4,'ashish','jain',10,16),
(5,'khusbu','jain',10,17),
(6,'madhan','lal',10,16),
(7,'saurab','kothari',10,15),
(8,'vinesh','roy',10,14),
(9,'rishika','r',10,15),
(10,'sara','rayan',10,16),
(11,'rosy','kumar',10,16);
SELECT * FROM students_table;

INSERT INTO marksheet_table(score,year,ranking,class,student_id)
VALUES(989,2014,10,1,1),
(454,2014,10,10,2),
(880,2014,10,4,3),
(870,2014,10,5,4),
(720,2014,10,7,5),
(670,2014,10,8,6),
(900,2014,10,3,7),
(540,2014,10,9,8),
(801,2014,10,6,9),
(420,2014,10,11,10),
(970,2014,10,2,11),
(720,2014,10,12,12);
SELECT * FROM marksheet_table;

/*Task 3:Write a query to display student id and student first name from the student table if the age is greater 
than or equal to 16 and the student's last name is Kumar.*/
SELECT student_id,first_name
FROM students_table
WHERE age>=16 AND lower(last_name) ='kumar';

/*Task 4:Write a query to display all the details from the marksheet table if the score is between 800 and 1000.*/
SELECT * FROM marksheet_table
WHERE score BETWEEN 800 and 1000;

/*Task 5:Write a query to display the marksheet details from the marksheet table by adding 5 to the score 
and by naming the column as new score.*/
SELECT (score+5) AS new_score, year, class,ranking,student_id
FROM marksheet_table;

/*Task 6:Write a query to display the marksheet table in descending order of the  score.*/
SELECT * FROM marksheet_table
ORDER BY score DESC;

/*Task 7:Write a query to display details of the students whose first name starts with a.*/
SELECT * FROM students_table
WHERE lower(first_name) LIKE 'a%';