# Date created and Last ran : 01-09-2024
# solution Queries authored by Ruby Gunna on MySQ Workbench 8.0 
# Project Name: Medical Dataset Analysis: Python, SQL, and Insights
# Source: HiCounselor.com
CREATE DATABASE medical_data;
USE medical_data;
-- Create the table structure
CREATE TABLE hospitalization_details (
    customer_id VARCHAR(10),
    year INT,
    month VARCHAR(3),
    date INT,
    children INT,
    charges DECIMAL(10, 2),
    hospital_tier VARCHAR(10),
    city_tier VARCHAR(10),
    state_id VARCHAR(5)
);
drop table medical_examinations;
-- Create the table structure
CREATE TABLE medical_examinations (
    customer_id VARCHAR(10),
    BMI DECIMAL(5, 3),
    HBA1C DECIMAL(5, 2),
    health_issues VARCHAR(3),
    any_transplant VARCHAR(3),
    cancer_history VARCHAR(3),
    numberofmajorsurgeries VARCHAR(20),
    smoker VARCHAR(3)
);
-- Create the table structure
CREATE TABLE names (
    customer_id VARCHAR(10),
    name VARCHAR(255)
);

-- Module 2 Task 2
-- What SQL query can assist you in determining the average hospital charge
SELECT AVG(charges) AS average_charge
FROM hospitalization_details;

-- Module 2 Task 3
-- Retrieve the unique customer identifiers, corresponding years, and charges from a specific dataset for records where charges exceed 700
SELECT customer_id, year, charges
FROM hospitalization_details
WHERE charges > 700;

-- Module 2 Task 4
-- Retrieve the name, year, and charges for customers with a BMI greater than 35.
SELECT
    n.name,
    h.year,
    h.charges
FROM names n
JOIN hospitalization_details h ON
    n.customer_id = h.customer_id
JOIN medical_examinations m ON
    m.customer_id = n.customer_id
WHERE m.BMI > 35
ORDER BY h.year;

-- Module 2 Task 5
-- List the customer_id and name of customers from the names table who have had major surgeries (greater than or equal to 1) as per the medical_examinations table.

SELECT n.customer_id , n.name from names n
JOIN medical_examinations m on m.customer_id = n.customer_id 
WHERE  m.numberofmajorsurgeries >= 1;

-- Module 2 Task 6
-- Calculate the average charges per hospital_tier for the year 2000 from the hospitalization_details table.
SELECT hospital_tier , 
       AVG(charges) as avg_charges 
FROM hospitalization_details 
WHERE year = 2000
GROUP BY hospital_tier;

-- Module 2 Task 7
-- Get the customer_id, BMI, and charges for customers who are smokers and have undergone a transplant.able
SELECT  m.customer_id ,
        m.BMI ,
        h.charges
FROM hospitalization_details h 
JOIN medical_examinations m on m.customer_id = h.customer_id
where m.smoker = 'yes' and  m.any_transplant = 'yes';

-- Module 2 Task 8
-- Retrieve the names of customers who have had at least 2 major surgeries or a history of cancer
SELECT n.name
FROM names n 
JOIN  medical_examinations m on m.customer_id = n.customer_id
WHERE  m.numberofmajorsurgeries >=2 or m.cancer_history = 'yes';

-- Module 2 Task 9
-- Find the customer with the highest number of major surgeries and display their customer_id and name.
SELECT n.customer_id, n.name from names n 
JOIN medical_examinations m on m.customer_id = n.customer_id 
ORDER BY m.numberofmajorsurgeries desc 
LIMIT 1;

-- Module 2 Task 10
-- List the customers who have had major surgeries and their respective cities' tier levels (city_tier) from the hospitalization_details table.
select n.customer_id , n.name , h.city_tier from names n 
join hospitalization_details h on h.customer_id =n.customer_id
join medical_examinations m on m.customer_id = n.customer_id
where m.numberofmajorsurgeries > 0 ;

-- Module 2 Task 11
-- Calculate the average BMI for each city_tier level in the year 1995 (city_tier) from the hospitalization_details table.
SELECT
    h.city_tier,
    AVG(m.BMI) avg_bmi
FROM
    hospitalization_details h
JOIN medical_examinations m ON
    m.customer_id = h.customer_id
WHERE
    h.year = '1995'
GROUP BY
    1;

-- Module 2 Task 12
-- Get the customer_id, name, and charges of customers who have health issues and a BMI greater than 30.

SELECT n.customer_id ,
	   n.name ,
       h.charges 
FROM names n 
JOIN hospitalization_details h on n.customer_id = h.customer_id
JOIN  medical_examinations m on m.customer_id = n.customer_id
where m.BMI > 30 and m.health_issues = 'yes';

-- Module 2 Task 13
-- For each year, find the customer with the highest total charges and their corresponding city_tier.
--  Display the year, customer name, city_tier, and the total charges.
WITH MaxChargesCTE AS (
    SELECT
        hd.year,
        n.name,
        hd.city_tier,
        hd.charges,
        ROW_NUMBER() OVER (PARTITION BY hd.year ORDER BY hd.charges DESC) AS rn
    FROM
        hospitalization_details hd
    JOIN
        names n ON hd.customer_id = n.customer_id
)
SELECT
    year,
    name,
    city_tier,
    charges AS max_charges
FROM
    MaxChargesCTE
WHERE
    rn = 1;

-- Module 2 Task 14
-- Find the top 3 customers with the highest average yearly charges over the years they have been hospitalized. Display their names and the average yearly charges.

WITH YearlyCharges as ( SELECT h.year, n.name as name , avg(h.charges) as avg_yearly_charges from hospitalization_details
                       h join names n on h.customer_id = n.customer_id 
                       GROUP by 1,2 ) 
                       
                      select name, avg_yearly_charges from YearlyCharges
                      order by avg_yearly_charges DESC
                      LIMIT 3;
                      
-- Module 2 Task 15
-- Rank the customers based on their total charges over the years in descending order(Use Rank function). Display their names, total charges, and their rank.
SELECT
    n.name,
    SUM(h.charges) AS total_charges,
    RANK() OVER ( ORDER BY SUM(h.charges) DESC) AS rank1
FROM
    names n
JOIN
    hospitalization_details h ON h.customer_id = n.customer_id
GROUP BY
    n.name;
    
-- Module 2 Task 16
-- Find the year with the highest number of hospitalizations. Display the year and the count of hospitalizations in that year.

WITH YearlyHospitalizations AS (
    SELECT
        year,
        COUNT(customer_id) AS hospitalization_count
    FROM
        hospitalization_details
    GROUP BY
        year
)

SELECT
    year,
    hospitalization_count
FROM
    YearlyHospitalizations
WHERE
    year = (SELECT MAX(year) FROM YearlyHospitalizations);




