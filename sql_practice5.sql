-- Ex 1
SELECT B.CONTINENT, FLOOR(AVG(A.POPULATION))
FROM CITY AS A
  INNER JOIN COUNTRY AS B
  ON A.COUNTRYCODE = B.CODE
GROUP BY B.CONTINENT
-- Ex2
SELECT round(
        COUNT(t.email_id)::DECIMAL/COUNT(DISTINCT e.email_id),2) AS confirm_rate
FROM emails AS e
LEFT JOIN texts AS t
    ON e.email_id = t.email_id
    AND t.signup_action = 'Confirmed'
-- Ex 3
SELECT B.age_bucket, 
      ROUND(100*
       SUM(A.time_spent) 
       FILTER 
        (WHERE A.activity_type = 'send')/SUM(time_spent),2) AS send_perc,
      ROUND(100*
       SUM(A.time_spent)
       FILTER 
        (WHERE A.activity_type = 'open')/SUM(time_spent),2) AS open_perc
FROM activities as A
 INNER JOIN age_breakdown AS B 
 ON A.user_id = B.user_id
WHERE A.activity_type IN('open','send')
GROUP BY B.age_bucket
-- Ex 4
SELECT a.customer_id
FROM customer_contracts as a 
  Left join products as b 
  On a.product_id = b.product_id
Group by a.customer_id
HAVING count(distinct b.product_category) = 3
-- Ex 5
Select a.employee_id, name, reports_count, average_age
From(
      Select reports_to as employee_id,
             count(employee_id) as reports_count,
             round(avg(age)) as average_age
      From Employees
      Group by reports_to
      Having reports_to is not null 
) as a
Left join Employees as b
On a.employee_id = b.employee_id
Order by employee_id
-- Ex 6
Select a.product_name, sum(b.unit) as unit
From Products as a
Right Join Orders as b
On a.product_id = b.product_id
Where year(order_date) = 2020 
       AND month(order_date) = 02
Group by product_name
Having sum(b.unit) >= 100
-- Ex 7
SELECT a.page_id
FROM pages as a
   LEFT JOIN page_likes as b
   On a.page_id = b.page_id
   Where b.page_id is NULL
	
--MID COURSE
  
-- EX1
SELECT MIN(REPLACEMENT_COST)
FROM FILM
--EX2
SELECT 
  CASE
    WHEN REPLACEMENT_COST BETWEEN 9.99 AND 19.99
	THEN 'LOW'
	WHEN REPLACEMENT_COST BETWEEN 20.00 AND 24.99
	THEN 'MEDIUM'
	WHEN REPLACEMENT_COST BETWEEN 25.00 AND 29.99
	THEN 'HIGH'
	ELSE 'OTHER'
  END AS COST_TYPE,
  COUNT(FILM_ID) AS TOTAL
FROM FILM
GROUP BY COST_TYPE
-- EX 3
--BẢNG A: FILM, BẢNG B: FILM_CATEGORY, BẢNG C: CATEGORY
--JOIN BẢNG A VS B BẰNG FILM_ID
--JOIN TIẾP VS BẢNG C BẰNG CATEGORY_ID
SELECT CONCAT(A.TITLE,' ',A.LENGTH,' ',C.NAME) AS FILM_TITLE, 
       A.LENGTH
FROM FILM AS A
INNER JOIN FILM_CATEGORY AS B
ON A.FILM_ID = B.FILM_ID
INNER JOIN CATEGORY AS C
ON B.CATEGORY_ID = C.CATEGORY_ID
WHERE C.NAME IN('Drama','Sports')
ORDER BY A.LENGTH DESC
SELECT * FROM ACTOR
-- Ex 4
SELECT C.NAME, COUNT(A.FILM_ID) AS TOTAL
FROM FILM AS A
INNER JOIN FILM_CATEGORY AS B
  ON A.FILM_ID = B.FILM_ID
INNER JOIN CATEGORY AS C
  ON B.CATEGORY_ID = C.CATEGORY_ID
GROUP BY C.NAME
ORDER BY COUNT(A.FILM_ID) DESC
-- Ex 5
SELECT A.ACTOR_ID, A.FIRST_NAME, A.LAST_NAME,
       COUNT(B.FILM_ID) as FILM_COUNT
FROM ACTOR AS A
JOIN FILM_ACTOR AS B
  ON A.ACTOR_ID = B.ACTOR_ID
GROUP BY ACTOR_ID
order by COUNT(B.FILM_ID) DESC
-- Ex 6
SELECT COUNT(A.CUSTOMER_ID) AS TOTAL_NULL_ADDRESS
FROM CUSTOMER AS A
RIGHT JOIN ADDRESS AS B
 ON A.ADDRESS_ID = B.ADDRESS_ID
WHERE A.CUSTOMER_ID IS NULL
-- Ex 7
-- BẢNG PAYMENT: A | BẢNG CUSTOMER: B | BẢNG ADDRESS: C | BẢNG CITY: D
SELECT D.CITY, SUM(A.AMOUNT) 
FROM PAYMENT AS A
LEFT JOIN CUSTOMER AS B
 ON A.CUSTOMER_ID = B.CUSTOMER_ID
LEFT JOIN ADDRESS AS C
 ON B.ADDRESS_ID = C.ADDRESS_ID
LEFT JOIN CITY AS D
 ON C.CITY_ID = D.CITY_ID
GROUP BY D.CITY 
ORDER BY SUM(A.AMOUNT) DESC 
-- EX 8
-- BẢNG PAYMENT: A | BẢNG CUSTOMER: B | BẢNG ADDRESS: C | BẢNG CITY: D | BẢNG COUNTRY: E
SELECT CONCAT(D.CITY,', ',E.COUNTRY) AS CITY_COUNTRY,
       SUM(A.AMOUNT) 
FROM PAYMENT AS A
LEFT JOIN CUSTOMER AS B
 ON A.CUSTOMER_ID = B.CUSTOMER_ID
LEFT JOIN ADDRESS AS C
 ON B.ADDRESS_ID = C.ADDRESS_ID
LEFT JOIN CITY AS D
 ON C.CITY_ID = D.CITY_ID
LEFT JOIN COUNTRY AS E
 ON D.COUNTRY_ID = E.COUNTRY_ID
GROUP BY CONCAT(D.CITY,', ',E.COUNTRY)
ORDER BY SUM(A.AMOUNT) DESC 
       




  
  





