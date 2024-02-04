# Date created and Last ran : 01-01-2024
# Solution Queries authored by Ruby Gunna on MySQ Workbench 8.0 
# Project Name: Statistical Loan Analysis: Using Python and SQL
# Source: HiCounselor.com

CREATE DATABASE Loans_data;
USE Loans_data;
drop table loans_data;
CREATE TABLE loans_data (
    id INT PRIMARY KEY,
    duration INT,
    status VARCHAR(50),
    rate DECIMAL(5, 4),
    yield DECIMAL(5, 4),
    loss DECIMAL(5, 4),
    `return` DECIMAL(5, 4),
    prosper CHAR(2),
   occupation VARCHAR(100),
   employment VARCHAR(50),
   home_owner VARCHAR(5),
   loan_amount INT,
  payment DECIMAL(7, 2),
    investors INT
);
DROP Table loans_data;
-- Task 1: Count the total number of rows in the 'loans_data' table.
SELECT COUNT(*) FROM loans_data;

/*Task 2: Profiling Loan Data
Calculate statistics for loans where the rate is between 0.06 and 0.26. Statistics include loan count, average interest rate, minimum
 and maximum interest rates, and average, minimum, and maximum loan amounts.*/
 
SELECT
    COUNT(*) AS loan_count,
    AVG(rate) AS average_interest_rate,
    MIN(rate) AS min_interest_rate,
    MAX(rate) AS max_interest_rate,
    AVG(loan_amount) AS average_loan_amount,
    MIN(loan_amount) AS min_loan_amount,
    MAX(loan_amount) AS max_loan_amount
FROM
    loans_data
WHERE
    rate BETWEEN 0.06 AND 0.26;

/*Task 3: Aggregating Loan Amounts by Employment Status
Aggregate total loan amounts by employment status.*/
SELECT
    employment,
    SUM(loan_amount) AS total_loan
FROM
    loans_data
GROUP BY
    employment
ORDER BY
    employment ASC;

-- Task 4: Counting Loans by Duration and Status
SELECT
    duration,
    status,
    COUNT(*) AS loan_count
FROM
    loans_data
GROUP BY
    duration, status
ORDER BY
    duration ASC, status ASC;
    
/* Task 5: Analyzing Loans by Employment Status
Analyze loans by employment status, calculating average interest rate and loan count for each employment category.*/
SELECT 
    employment,
    AVG(rate) AS average_interest_rate,
    COUNT(*) AS loan_count
FROM 
    loans_data
GROUP BY
    employment
ORDER BY 
employment ASC;
   
/*Task 6: Analyzing Loans by Home Ownership
Analyze loans based on homeownership status, calculating average interest rate and loan count for homeowners and non-homeowners.*/

SELECT
    home_owner,
    AVG(rate) AS average_interest_rate,
    COUNT(*) AS loan_count
FROM
    loans_data
GROUP BY
    home_owner
ORDER BY
    home_owner ASC;

/*Task 7: Analyzing Loans by Prosper Rating
Analyze loans based on Prosper rating, calculating average interest rate and loan count for each rating category.*/
SELECT
    prosper,
    AVG(rate) AS average_interest_rate,
    COUNT(*) AS loan_count
FROM
    loans_data
GROUP BY
    prosper
ORDER BY
    prosper ASC;
    
/*Task 8: Analyzing Loans by Loan Amount
Analyze loans by loan amount, calculating average monthly payments and loan count for each loan amount category.*/
SELECT
    loan_amount,
    AVG(payment) AS average_payment,
    COUNT(*) AS loan_count
FROM
    loans_data
GROUP BY
    loan_amount
ORDER BY
    loan_amount ASC;

/*Task 9: Analyzing Loans by Number of Investors
Examine the connection between the number of investors and interest rates, and count the number of loans for each investor group.*/
SELECT
    investors,
    AVG(rate) AS average_interest_rate,
    COUNT(*) AS loan_count
FROM
    loans_data
GROUP BY
    investors
ORDER BY
    investors ASC;

/*Task 10: Analyzing Loans by Duration and Return Rate
Analyze loans by duration, calculating average return rate and loan count for each duration category.*/
SELECT
    duration,
    AVG(`return`) AS average_return_rate,
    COUNT(*) AS loan_count
FROM 
    loans_data
GROUP BY
    duration
ORDER BY
    duration ASC;
    
/*Task 11: Analyzing Loans by Prosper Rating and Return Rate
Analyze loans based on Prosper rating, calculating average return rate and loan count for each rating category.*/
SELECT
    prosper,
    AVG(`return`) AS average_return_rate,
    COUNT(*) AS loan_count
FROM 
    loans_data
GROUP BY
    prosper
ORDER BY
    prosper ASC;


