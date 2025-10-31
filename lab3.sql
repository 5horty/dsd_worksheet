CREATE TABLE language(
    language_id SERIAL PRIMARY KEY,
    language_name VARCHAR(50)
);


CREATE TABLE film(
    film_id SERIAL PRIMARY KEY,
    langguage_id INT REFERENCES language (language_id),
    original_languages INT REFERENCES language (language_id),
    film_name VARCHAR(100),
    release_year INT
);

CREATE TABLE actor(
    actor_id SERIAL PRIMARY KEY,
    actor_fname VARCHAR(50),
    actor_lname VARCHAR(50),
    birth_year INT

);

CREATE TABLE film_actor(
    film_id INT REFERENCES film (film_id),
    actor_id INT REFERENCES actor (actor_id),
    role_name VARCHAR(100),
    PRIMARY KEY (film_id, actor_id)

);

CREATE TABLE category(
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100)

);

CREATE TABLE film_category(
    film_id INT REFERENCES film (film_id),
    category_id INT REFERENCES category (category_id),
    PRIMARY KEY (film_id, category_id)


);




-- insert data
---------------
-- insert languages
INSERT INTO language (language_name) VALUES 
('Eglish'),
('Spanish'),
('french'),
('Japanese'),
('german'),
('Italian');

-- insert films
INSERT INTO film (langguage_id, original_languages, film_name, release_year) VALUES 
(1, 1, 'The dark Knight', 2008),
(1, 1, 'Inception', 2010),
(1, 2, 'The departed', 2006),
(1, 1, 'Pulp fiction', 1994),
(3, 3, 'Amélie', 2001),
(4, 4, 'spirited Away', 2001),
(1, 1, 'the Shawshank Redemption', 1994),
(1, 1, 'forrest Gump', 1994),
(2, 2, 'Pan''s Labyrinth', 2006),
(5, 5, 'The Lives of Others', 2006);

-- insert actors
INSERT INTO actor (actor_fname, actor_lname, birth_year) VALUES 
('christian', 'Bale', 1974),
('Heath', 'Ledger', 1979),
('Leonardo', 'diCaprio', 1974),
('Marion', 'Cotillard', 1975),
('Matt', 'Damon', 1970),
('jack', 'Nicholson', 1937),
('John', 'travolta', 1954),
('Samuel L.', 'jackson', 1948),
('Audrey', 'Tautou', 1976),
('morgan', 'Freeman', 1937),
('Tim', 'robbins', 1958),
('Tom', 'Hanks', 1956),
('Sergi', 'lópez', 1965),
('ulrich', 'Mühe', 1953);

-- insert categories
INSERT INTO category (category_name) VALUES 
('Action'),
('Drama'),
('crime'),
('Thriller'),
('Science fiction'),
('Romance'),
('Comedy'),
('fantasy'),
('Animation'),
('mystery');

-- insert film Actor relationships
INSERT INTO film_actor (film_id, actor_id, role_name) VALUES 
(1, 1, 'bruce Wayne / batman'),
(1, 2, 'joker'),
(1, 10, 'Lucius Fox'),
(2, 3, 'Dom Cobb'),
(2, 4, 'Mal Cobb'),
(3, 3, 'billy Costigan'),
(3, 5, 'Colin sullivan'),
(3, 6, 'Frank Costello'),
(4, 7, 'Vincent vega'),
(4, 8, 'Jules Winnfield'),
(5, 9, 'amélie Poulain'),
(7, 10, 'Ellis Boyd Redding'),
(7, 11, 'Andy dufresne'),
(8, 12, 'forrest Gump'),
(9, 13, 'captain Vidal'),
(10, 14, 'Hauptmann Gerd Wiesler');

-- insert film Category relationships
INSERT INTO film_category (film_id, category_id) VALUES 
(1, 1), (1, 3), (1, 2),
(2, 1), (2, 5), (2, 4),
(3, 3), (3, 2), (3, 4),
(4, 3), (4, 2),
(5, 7), (5, 6), (5, 2),
(6, 9), (6, 8), (6, 7),
(7, 2), (7, 3),
(8, 2), (8, 6),
(9, 8), (9, 2), (9, 1),
(10, 2), (10, 4);



--select statemetn--
SELECT 
    f.film_name as movie_name, -- its a movie not film too old timy 
    f.release_year, 
    CONCAT_WS('-',a.actor_fname,a.actor_lname) AS actor_name,
    fa.role_name
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor a ON fa.actor_id = a.actor_id
WHERE 
    c.category_name = 'Action' 
    AND f.release_year > 2005
ORDER BY 
    f.release_year DESC;


--insert statment--
INSERT INTO film (langguage_id, original_languages, film_name, release_year) 
VALUES (1, 1, 'Interstellar', 2014);

-- film_id = 11 for the new film
INSERT INTO film_category (film_id, category_id) 
VALUES (11, 5), (11, 2);  -- science diction lol

INSERT INTO actor (actor_fname, actor_lname, birth_year) 
VALUES ('Matthew', 'Mcconaughey', 1969); -- 69 nice 

--  actor_id =15 for the new actor
INSERT INTO film_actor (film_id, actor_id, role_name) 
VALUES (11, 15, 'Cooper');


-- update statment--
-- release year of a film and actors role
UPDATE film 
SET release_year = 2009 
WHERE film_name = 'The dark Knight';

UPDATE film_actor 
SET role_name = 'bruce Wayne_two / The batman' 
WHERE film_id = 1 AND actor_id = 1;
--check--
--

SELECT 
    f.film_name as movie_name,  
    f.release_year, 
    CONCAT_WS('-',a.actor_fname,a.actor_lname) AS actor_name,
    fa.role_name
FROM 
    film f
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor a ON fa.actor_id = a.actor_id
WHERE 
    f.release_year = 2009;





--before delete
SELECT 
    f.film_name as movie_name  
FROM 
    film f;

-- delete statment -- 
-- has to be in oerder for fk
DELETE FROM film_actor WHERE film_id = 10;
DELETE FROM film_category WHERE film_id = 10;
DELETE FROM film WHERE film_id = 10;  -- deletes The Lives of Others

--check
SELECT 
    f.film_name as movie_name  
FROM 
    film f;


