--q1--
SELECT 
    actor_id,
    first_name,
    last_name
FROM 
    actor
WHERE 
    first_name ILIKE 'Scarlett';

--q2--
SELECT COUNT(DISTINCT last_name) AS unique_last_names --disctint diff 
FROM actor;
--q3--
SELECT 
    last_name
FROM 
    actor
GROUP BY 
    last_name
HAVING 
    COUNT(*) = 1 --having a acount of one after group
ORDER BY 
    last_name;

--q4--
SELECT 
    a.first_name,
    a.last_name,
    COUNT(ma.movie_id) AS movie_count
FROM 
    actor a
    JOIN movie_actor ma USING (actor_id)
GROUP BY 
    a.actor_id, 
    a.first_name, --groups one person 
    a.last_name
ORDER BY 
    movie_count DESC --most first
LIMIT 1;
--q5--Caps why in wrksheet
SELECT 
    i.inventory_id
FROM 
    inventory i
LEFT JOIN rental r 
    ON i.inventory_id = r.inventory_id 
    AND r.return_date IS NULL   -- ony match active 
WHERE 
    i.store_id = 1
    AND i.movie_id = (
        SELECT 
            movie_id 
        FROM 
            movie 
        WHERE title = 'PURPLE MOVIE'
        )
    AND r.rental_id IS NULL;    -- not rent



--q6--due to lab 7 val is also here is that right or not?? it doesnt sayt o delete it or not
SELECT 
    CONCAT(s.first_name, ' ', s.last_name) AS "staff name",
    a.address AS "Staff address",
    c.city AS "Staff city",
    s.email AS "Staff email"
FROM 
    staff s
JOIN 
    address a ON s.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
ORDER BY 
    s.last_name, 
    s.first_name;

--q7--
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name
FROM 
    actor a
JOIN 
    movie_actor ma ON a.actor_id = ma.actor_id
JOIN 
    movie m ON ma.movie_id = m.movie_id
WHERE 
    m.title = 'AGENT TRUMAN'--all caps but in worksheet its lowercase very evial
ORDER BY 
    a.last_name, 
    a.first_name;

--chall--
SELECT 
    m.title AS "Movie title",
    STRING_AGG(a.first_name || ' ' || a.last_name, ', 'ORDER BY a.last_name) AS "Actors in the movie" --string_aggs many row woth comma sep
FROM 
    movie m
JOIN 
    movie_actor ma ON m.movie_id = ma.movie_id
JOIN 
    actor a ON ma.actor_id = a.actor_id
WHERE 
    m.title = 'AGENT TRUMAN'
GROUP BY 
    m.title;





