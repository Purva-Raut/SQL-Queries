/***************** CREATING customer_datasets TABLE *****************/
DROP TABLE IF EXISTS customer_datasets;

CREATE TABLE customer_datasets (
    "c_id" BIGINT PRIMARY KEY NOT NULL,
    "c_name" VARCHAR(355),
    "c_location" VARCHAR(355),
    "c_phoneno" INT
);

COPY customer_datasets FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\SQL_Projects\1.Project_Retail_Mart_Management\customer_datasets.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER; 


/***************** CREATING product_datasets TABLE *****************/

DROP TABLE IF EXISTS product_datasets;

CREATE TABLE product_datasets (
    "p_code" INT PRIMARY KEY NOT NULL,
    "p_name" VARCHAR(355),
    "price" INT,
    "stock" INT,
    "category" VARCHAR(355)  
);

COPY product_datasets FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\SQL_Projects\1.Project_Retail_Mart_Management\product_datasets.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

/***************** CREATING manager_survey TABLE *****************/

DROP TABLE IF EXISTS sales_datasets;

CREATE TABLE sales_datasets (
    "order_date" DATE,
    "order_no" CHAR(4),
    "c_id" BIGINT,
    "c_name" VARCHAR(355),
    "s_code" INT,
    "p_name" VARCHAR(355),
    "qty" INT,
    "price" INT
);

COPY sales_datasets FROM 'C:\Users\PurvaRaut\Desktop\DataAnalytics\SQL_Projects\1.Project_Retail_Mart_Management\sales_datasets.csv' NULL AS 'NA' DELIMITER ',' CSV HEADER;

/* Verify that all tables have been copied successfully by running the below */
DROP TABLE IF EXISTS TABLE_ROW_COUNT;

CREATE TEMP TABLE TABLE_ROW_COUNT AS
	(SELECT 'customer_datasets' AS TABLE_NAME,
			COUNT(*) AS NO_ROWS
		FROM customer_datasets
		UNION ALL SELECT 'product_datasets' AS TABLE_NAME,
			COUNT(*) AS NO_ROWS
		FROM product_datasets
		UNION ALL SELECT 'sales_datasets' AS TABLE_NAME,
			COUNT(*) AS NO_ROWS
		FROM sales_datasets);

DROP TABLE IF EXISTS TABLE_COLUMN_COUNT;

CREATE TEMP TABLE TABLE_COLUMN_COUNT AS
	(SELECT TABLE_NAME,
			COUNT(COLUMN_NAME) AS NO_COLUMNS
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'customer_datasets'
			OR TABLE_NAME = 'product_datasets'
			OR TABLE_NAME = 'sales_datasets'
		GROUP BY 1);
        
DROP TABLE IF EXISTS TAB_MART;

CREATE TABLE TAB_MART AS
	(SELECT A.*,
			B.NO_ROWS
		FROM TABLE_COLUMN_COUNT AS A
		LEFT JOIN TABLE_ROW_COUNT AS B ON A.TABLE_NAME = B.TABLE_NAME);

/*************************************************** 
Verify the no. of rows and columns for each table.
***************************************************/

SELECT * FROM TAB_MART;