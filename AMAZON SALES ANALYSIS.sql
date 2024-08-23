create database capstone_project;

Create table if not exists WMsales (
 Invoice_ID  varchar(30) Not null primary Key,
 Branch  varchar (5) not null,
    City varchar (30) not null,
    Customer_type varchar (30) not null,
    Gender  varchar(10) not null,
    Product_line varchar (100) not null,
    Unit_price  decimal(10,2) not null,
    Quantity int not null,
    Tax  float(6,4) not null,
    Total decimal (12,4) not null,
    Date datetime not null,
    Time TIME not null,
    Payment_method varchar (15)  not null, 
    cogs  decimal (10, 2) not null,
    gross_margin_percentage float (11,9),
    gross_income decimal(12, 4) not null,
    Rating float (2, 1)
);

use capstone_project;

select * from amazon;

SELECT
 time,
 (CASE
 WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
 WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
 ELSE "Evening"
 END) AS time_of_day
FROM amazon;

ALTER TABLE amazon ADD COLUMN time_of_day VARCHAR(20);

UPDATE amazon
SET time_of_day = (
 CASE
  WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

select
 date,
    dayname(date)
from amazon;

alter table amazon add column day_name varchar(10);

update  amazon
set day_name = dayname(date);

select date,
	monthname(date)
    from amazon;
alter table amazon add column month_name varchar(30);

update amazon
set month_name = monthname(date);


# (1) What is the count of distinct cities in the dataset?

SELECT COUNT(DISTINCT(CITY)) FROM AMAZON;

# (2) For each branch, what is the corresponding city?
SELECT distinct(BRANCH) ,CITY from AMAZON;

# (3) What is the count of distinct product lines in the dataset?

SELECT COUNT(DISTINCT(PRODUCT_LINE)) FROM AMAZON;

# (4) Which payment method occurs most frequently?

SELECT PAYMENT, COUNT(PAYMENT) AS PAYMENT_COUNT FROM AMAZON
GROUP BY PAYMENT
ORDER BY PAYMENT_COUNT DESC
LIMIT 1;

# (5) Which product line has the highest sales?

SELECT PRODUCT_LINE ,SUM(QUANTITY) AS HIGHEST_SALES
FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY HIGHEST_SALES DESC
LIMIT 1;

# (6) How much revenue is generated each month?

SELECT MONTH_NAME AS MONTH ,ROUND(SUM(TOTAL)) AS "TOTAL REVENUE" 
FROM AMAZON
GROUP BY MONTH_NAME;

# (7) In which month did the cost of goods sold reach its peak?

SELECT MONTH_NAME ,ROUND(SUM(COGS)) AS COST_OF_GOODS FROM AMAZON
GROUP BY MONTH_NAME
ORDER BY COST_OF_GOODS DESC
LIMIT 1;

# (8) Which product line generated the highest revenue?

SELECT PRODUCT_LINE ,ROUND(SUM(TOTAL)) AS TOTAL FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY TOTAL DESC
LIMIT 1;

# (9) In which city was the highest revenue recorded?

SELECT CITY , ROUND(SUM(TOTAL)) AS TOTAL FROM AMAZON
GROUP BY CITY
ORDER BY TOTAL DESC
LIMIT 1;

# (10) Which product line incurred the highest Value Added Tax?

SELECT PRODUCT_LINE ,ROUND(SUM(TAX)) AS TAX 
FROM AMAZON
GROUP BY PRODUCT_LINE
ORDER BY TAX DESC
LIMIT 1;

# (11) For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."

SELECT ROUND(AVG(TOTAL)) FROM AMAZON;
select PRODUCT_LINE,
(case 
	when 323 < ROUND(AVG(TOTAL)) then "good"
        ELSE "bad"
    end) as indicating
from AMAZON
GROUP BY PRODUCT_LINE;
    
ALTER TABLE AMAZON ADD COLUMN SALES varchar(20);

UPDATE AMAZON 
	SET SALES = (case 
	when 323 < TOTAL then "good"
	ELSE "bad"
    end);

# (12) Identify the branch that exceeded the average number of products sold.

select branch ,SUM(QUANTITY) FROM AMAZON
WHERE QUANTITY > (SELECT avg(QUANTITY) FROM AMAZON)
GROUP BY BRANCH;

#(13) Which product line is most frequently associated with each gender?

SELECT  GENDER,PRODUCT_LINE,COUNT(GENDER) AS GENDER_COUNT FROM AMAZON
GROUP BY GENDER,PRODUCT_LINE
ORDER BY GENDER_COUNT DESC;

# (14) Calculate the average rating for each product line.

SELECT PRODUCT_LINE ,ROUND(AVG(RATING),2) AS "AVG RATING" 
FROM AMAZON
GROUP BY PRODUCT_LINE;

# (15) Count the sales occurrences for each time of day on every weekday.

SELECT DAY_NAME ,TIME_OF_DAY ,COUNT(*) AS SALES
FROM AMAZON
GROUP BY DAY_NAME,TIME_OF_DAY;

# (16) Identify the customer type contributing the highest revenue.

SELECT CUSTOMER_TYPE ,ROUND(SUM(TOTAL),2) AS REVENUE
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY REVENUE
LIMIT 1;

# (17) Determine the city with the highest VAT percentage.

SELECT CITY ,ROUND(SUM(TAX),2) AS VAT
FROM AMAZON
GROUP BY CITY
ORDER BY VAT DESC
LIMIT 1;

# (18) Identify the customer type with the highest VAT payments.

SELECT CUSTOMER_TYPE ,ROUND(SUM(TAX),2) AS VAT
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY CUSTOMER_TYPE DESC
LIMIT 1;

# (19) What is the count of distinct customer types in the dataset?

SELECT COUNT(DISTINCT(CUSTOMER_TYPE)) 
AS "DISTINCT CUSTOMER TYPE"
FROM AMAZON;

# (20) What is the count of distinct payment methods in the dataset?

SELECT COUNT(DISTINCT(PAYMENT))
AS "PAYMENT METHOD"
FROM AMAZON;

# (21) Which customer type occurs most frequently?

SELECT GENDER , COUNT(GENDER) AS CUSTOMER
FROM AMAZON
GROUP BY GENDER
ORDER BY CUSTOMER DESC
LIMIT 1;

# (22) Identify the customer type with the highest purchase frequency.

SELECT CUSTOMER_TYPE , ROUND(SUM(TOTAL),2) AS "HIGHEST PURCHASE"
FROM AMAZON
GROUP BY CUSTOMER_TYPE
ORDER BY SUM(TOTAL) DESC
LIMIT 1;

# (23) Determine the predominant gender among customers.

SELECT GENDER,COUNT(GENDER) AS "GENDER COUNT" 
FROM AMAZON
GROUP BY GENDER
ORDER BY COUNT(GENDER) DESC
LIMIT 1;

# (24) Examine the distribution of genders within each branch.

SELECT BRANCH ,GENDER,COUNT(GENDER) AS "GENDER COUNT"
FROM AMAZON
GROUP BY BRANCH,GENDER
ORDER BY BRANCH;

# (25) Identify the time of day when customers provide the most ratings.

SELECT TIME_OF_DAY ,COUNT(RATING) AS "RATING COUNT"
FROM AMAZON
GROUP BY TIME_OF_DAY
ORDER BY COUNT(RATING) DESC
LIMIT 1;

# (26) Determine the time of day with the highest customer ratings for each branch.

SELECT TIME_OF_DAY,BRANCH ,COUNT(RATING) AS RATING_COUNT FROM AMAZON
WHERE BRANCH = "A"
GROUP BY TIME_OF_DAY,BRANCH
ORDER BY RATING_COUNT DESC
LIMIT 1;
SELECT TIME_OF_DAY,BRANCH ,COUNT(RATING) AS RATING_COUNT FROM AMAZON
WHERE BRANCH = "B"
GROUP BY TIME_OF_DAY,BRANCH
ORDER BY RATING_COUNT DESC
LIMIT 1;
SELECT TIME_OF_DAY,BRANCH ,COUNT(RATING) AS RATING_COUNT FROM AMAZON
WHERE BRANCH = "C"
GROUP BY TIME_OF_DAY,BRANCH
ORDER BY RATING_COUNT DESC
LIMIT 1;

# (27) Identify the day of the week with the highest average ratings.

SELECT DAY_NAME AS "DAY OF THE WEEK",
ROUND(AVG(RATING),2) AS AVG_RATING FROM AMAZON
GROUP BY DAY_NAME
ORDER BY AVG_RATING DESC
LIMIT 1;

# (28) Determine the day of the week with the highest average ratings for each branch.

SELECT BRANCH ,DAY_NAME AS "DAY OF THE WEEK",
ROUND(AVG(RATING),2) AS AVG_RATING FROM AMAZON
WHERE BRANCH = "A"
GROUP BY BRANCH ,DAY_NAME
ORDER BY AVG_RATING DESC
LIMIT 1;
SELECT BRANCH ,DAY_NAME AS "DAY OF THE WEEK",
ROUND(AVG(RATING),2) AS AVG_RATING FROM AMAZON
WHERE BRANCH = "B"
GROUP BY BRANCH ,DAY_NAME
ORDER BY AVG_RATING DESC
LIMIT 1;
SELECT BRANCH ,DAY_NAME AS "DAY OF THE WEEK",
ROUND(AVG(RATING),2) AS AVG_RATING FROM AMAZON
WHERE BRANCH = "C"
GROUP BY BRANCH ,DAY_NAME
ORDER BY AVG_RATING DESC
LIMIT 1;