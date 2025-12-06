--b4_q1
SELECT 
    address_id, 
    phone 
FROM 
    ADDRESS 
WHERE 
    address_id = 100;

--change

UPDATE 
    ADDRESS
SET 
    phone = '02392844444'
WHERE 
    address_id = 100;

--q2--
EXPLAIN
SELECT 
    *
FROM 
    ADDRESS
WHERE 
    phone = '02392844444';

--q3--

CREATE INDEX idx_address_phone ON ADDRESS(phone);
\di

--q4--just reused q2 :)
EXPLAIN
SELECT 
    *
FROM 
    ADDRESS
WHERE 
    phone = '02392844444';

--q5--
DROP INDEX idx_address_phone;
\di
--6--
CREATE VIEW customer_details AS
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS "customer",
    CONCAT(c.email, ' | ', a.phone) AS "contact_Details",
    a.address AS "customer_Address",
    ci.city AS "customer_City",
    co.country AS "customer_Country"
FROM 
    CUSTOMER c
    JOIN ADDRESS a ON c.address_id = a.address_id
    JOIN CITY ci ON a.city_id = ci.city_id
    JOIN COUNTRY co ON ci.country_id = co.country_id
ORDER BY 
    co.country;

--selecting--
SELECT 
    * 
FROM 
    customer_details;

drop view customer_details;

--q7--
SELECT 
    city_id,
    city
FROM 
    CITY
WHERE 
    country_id = (
        SELECT country_id 
        FROM COUNTRY 
        WHERE country = 'United Kingdom'
    );

--8--
SELECT 
    ci.city_id,
    ci.city,
    co.country
FROM 
    CITY ci
    JOIN COUNTRY co ON ci.country_id = co.country_id
WHERE 
    ci.country_id IN (
        SELECT country_id 
        FROM COUNTRY 
        WHERE country IN ('United Kingdom', 'France')
    )
ORDER BY 
    co.country,
    ci.city;
