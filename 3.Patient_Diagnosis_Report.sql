/*1.Write a query to create a patients table with the fields such as date, patient id, patient name, 
age, weight, gender, location, phone number, disease, doctor name, and doctor id.
2.Write a query to insert values into the patients table.*/

DROP TABLE IF EXISTS patients;
CREATE TABLE patients(
"date" DATE, 
"patient_id" VARCHAR(20) , 
"patient_name" VARCHAR(50), 
"age" INT, 
"weight" INT,
"gender" VARCHAR(10), 
"location" VARCHAR(20), 
"phone_number" INT, 
"disease" VARCHAR(20), 
"doctor_name" VARCHAR(20), 
"doctor_id" INT
);

INSERT INTO patients(date, patient_id, patient_name, 
age, weight, gender, location, phone_number, disease, doctor_name,doctor_id)
VALUES
('15/06/2019','AP2021','Sarath',67,76,'Male','chennai',5462829,'Cardiac','Mohan',21),
('13/02/2019','AP2022','John',62,80,'Male','banglore',1234731,'Cancer','Suraj',22),
('08/01/2018','AP2023','Henry',43,65,'Male','Kerala',9028320,'Liver','Mehta',23),
('04/02/2020','AP2024','Carl',56,72,'Female','Mumbai',9293829,'Asthma','Karthik',24),
('15/09/2017','AP2025','Shikar',55,71,'Male','Delhi',7821281,'Cardiac','Mohan',21),
('22/07/2018','AP2026','Piysuh',47,59,'Male','Haryana',8912819,'Cancer','Suraj',22),
('25/03/2017','AP2027','Stephen',69,55,'Male','Gujarat',8888211,'Liver','Mehta',23),
('22/04/2019','AP2028','Aaron',75,53,'Male','Banglore',9012192,'Asthma','Karthik',24);

SELECT * FROM patients;

/*3.Write a query to display the total number of patients in the table.*/
SELECT COUNT(DISTINCT patient_id) AS total_patients
FROM patients;

/*4.Write a query to display the patient id, patient name, gender, and disease of the patient whose age is maximum.*/
SELECT patient_id,patient_name,gender,disease
FROM patients
ORDER BY age DESC
LIMIT 1;

/*5.Write a query to display patient id and patient name with the current date.*/
SELECT patient_id,patient_name
FROM patients
WHERE date=NOW();

/*6.Write a query to display the old patient’s name and new patient's name in uppercase.*/
SELECT UPPER(patient_name) as patient
FROM patients
WHERE date=
(SELECT MIN(date) FROM patients)
OR
 date=
(SELECT MAX(date) FROM patients);

/*7.Write a query to display the patient’s name along with the length of their name.*/
SELECT patient_name,length(patient_name) as length_of_name
FROM patients;

/*8.Write a query to display the patient’s name, and the gender of the patient must be mentioned as M or F.*/
SELECT patient_name,
CASE
WHEN gender='Male' then 'M'
WHEN gender='Female' then 'F'
END
FROM patients;

/*9.Write a query to combine the names of the patient and the doctor in a new column. */
SELECT CONCAT(patient_name,' ',doctor_name) as patient_doctor_names
FROM patients;

/*10.Write a query to display the patients’ age along with the logarithmic value (base 10) of their age.*/
SELECT age,log(age)
FROM patients;

/*11.Write a query to extract the year from the given date in a separate column.*/
SELECT date,EXTRACT(YEAR FROM date) as year, patient_id, patient_name, 
age, weight, gender, location, phone_number, disease, doctor_name,doctor_id
FROM patients;

/*12.Write a query to return NULL if the patient’s name and doctor’s name are similar else return 
the patient’s name.*/
SELECT
CASE
WHEN patient_name = doctor_name THEN 'NULL'
WHEN patient_name != doctor_name THEN patient_name
END
FROM patients;

/*13. Write a query to return Yes if the patient’s age is greater than 40 else return No.*/
SELECT patient_name,
CASE
WHEN age> 40 THEN 'Yes'
WHEN age<=40 THEN 'No'
END as age_40_plus
FROM patients;

/*14.Write a query to display the doctor’s duplicate name from the table.*/
SELECT COUNT(doctor_name) as Num_duplicate_name,doctor_name
FROM patients
GROUP BY doctor_name
HAVING COUNT(doctor_name)>1;
