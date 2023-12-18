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


