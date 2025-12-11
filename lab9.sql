--q1--user??
SELECT 
    routine_name
FROM 
    information_schema.routines
WHERE 
    routine_schema NOT IN ('pg_catalog', 'information_schema')--only user func
ORDER BY 
    routine_name;


--q2--
--get_id--
SELECT 
    movie_id 
FROM 
    movie
WHERE 
    title = 'ANGELS LIFE';--agian witrh all cpas

SELECT movie_in_stock(25,1);

--q3--
--get_id--
SELECT 
    movie_id 
FROM 
    movie
WHERE 
    title = 'ANGELS LIFE';--agian witrh all cpas
--25--
--funbc--
SELECT COUNT(*) AS copies_available
FROM movie_in_stock(
    p_movie_id := (25),
    p_store_id := 1
);
--q3--
CREATE PROCEDURE sp_add_new_actor(
    new_first_name VARCHAR,
    new_last_name  VARCHAR
)
LANGUAGE plpgsql --lang
AS $$ -- {}
BEGIN
    INSERT INTO actor (first_name, last_name)
    VALUES (new_first_name, new_last_name);
END;
$$;

--testing--
CALL sp_add_new_actor('Rogan', 'MacLeod');

--q4--can add length??
ALTER TABLE country
ADD COLUMN country_code VARCHAR;

--q5--
ALTER TABLE country
ALTER COLUMN country_code TYPE CHAR(2);

--chec--
\d country
--q6--
UPDATE 
    country
SET 
    country_code = 'UK'
WHERE 
    country = 'United Kingdom';


--q7--

CREATE TABLE new_staff AS
SELECT 
    staff_id,
    first_name,
    last_name,
    email
FROM 
    staff;
--q8--
SELECT 
    m.title AS "Movie Title",
    COUNT(i.inventory_id) AS "Number of Copies"
FROM 
    inventory i
JOIN 
    movie m 
    ON i.movie_id = m.movie_id
GROUP BY 
    m.title
ORDER BY 
    COUNT(i.inventory_id) DESC,
    m.title ASC;
--q9--
SELECT 
    c.name AS "Category",
    ROUND(AVG(m.length), 2) AS "Average movie length in Minutes"--gets avg
FROM category c
JOIN movie_category mc 
    ON c.category_id = mc.category_id
JOIN movie m 
    ON mc.movie_id = m.movie_id
GROUP BY 
    c.name
ORDER BY 
    AVG(m.length) DESC;
--10--
SELECT 
    c.name AS "Category",
    ROUND(AVG(m.length), 2) AS "Average movie length in Minutes"
FROM category c
JOIN movie_category mc USING (category_id)
JOIN movie m USING (movie_id)
GROUP BY 
    c.name
HAVING 
    AVG(m.length) > 115.27
ORDER BY 
    AVG(m.length) DESC;
