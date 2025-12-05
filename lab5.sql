--q1--

SELECT
    movie_id AS "Movie ID",
    movie_title AS "movie_title",
    movie_lang AS "LANGUAGE",
    cat_name AS "Category"
FROM
    movie
    INNER JOIN category ON movie.movie_id = category.movie_id
WHERE
    movie_title = 'ALADDIN CALENDAR';


--q3
SELECT 
    COUNT(*)
FROM 
    information_schema.views
WHERE 
    table_schema = 'public';   --7 

--q4--part1

EXPLAIN ANALYZE
SELECT 
    m.title
FROM 
    MOVIE m
    JOIN MOVIE_CATEGORY mc ON m.movie_id = mc.movie_id
    JOIN CATEGORY c ON mc.category_id = c.category_id
WHERE c.name = 'Documentary';

--check for id--
SELECT 
    category_id 
FROM 
    CATEGORY 
WHERE 
    name = 'Documentary'; --6

--find using id q4part2--
EXPLAIN ANALYZE
SELECT 
    m.title
FROM 
    MOVIE m
    JOIN MOVIE_CATEGORY mc ON m.movie_id = mc.movie_id
WHERE 
    mc.category_id = 6;


--q5
SELECT 
    m.title,
    m.release_year
FROM 
    MOVIE m
    JOIN LANGUAGE l ON m.original_language_id = l.language_id
WHERE 
    l.name = 'Italian'
ORDER BY m.release_year ASC;

--q6
SELECT 
    l.name AS language,
    c.name AS category,
    COUNT(m.movie_id) AS movie_count
FROM 
    MOVIE m
    JOIN LANGUAGE l ON m.original_language_id = l.language_id
    JOIN MOVIE_CATEGORY mc ON m.movie_id = mc.movie_id
    JOIN CATEGORY c ON mc.category_id = c.category_id
GROUP BY 
    l.name, 
    c.name
ORDER BY 
    l.name ASC, 
    c.name ASC;