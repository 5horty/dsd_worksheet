--q1--
CREATE ROLE junior_analyst WITH LOGIN PASSWORD 'Testing1234!';

psql -h localhost -p 5432 -U junior_analyst -d movie_rental

SELECT 
    * 
FROM 
    staff;

GRANT SELECT ON TABLE staff TO junior_analyst;

--q2--
CREATE ROLE cashier WITH LOGIN PASSWORD 'Testing1234!';
--permisson--
GRANT INSERT ON TABLE payment_p2022_01 TO cashier;
--erro9r--fix
GRANT USAGE, SELECT ON SEQUENCE payment_p2022_01_payment_id_seq TO cashier;
--role--
psql -h localhost -p 5432 -U cashier -d movie_rental
--inser--
INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date) 
VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);

--q3--
GRANT SELECT, INSERT ON TABLE rental TO cashier;
--role--
psql -h localhost -p 5432 -U cashier -d movie_rental
--insert--

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date,     staff_id, last_update)
VALUES (17000, CURRENT_DATE,  1,  1, NULL, 1, CURRENT_TIMESTAMP);

-- see if the insert was made (you should have the today date)
SELECT * FROM rental WHERE rental_id = 17000;

--delete--
DELETE FROM rental WHERE rental_id = 17000;
--fix
GRANT DELETE ON TABLE rental TO cashier;

--q4--
CREATE ROLE manager WITH LOGIN PASSWORD 'Testing1234!';
GRANT UPDATE ON TABLE country TO manager WITH GRANT OPTION; --good--
--sales--
CREATE ROLE sales WITH LOGIN PASSWORD 'Testing1234!';
--connect--
psql -h localhost -p 5432 -U manager -d movie_rental
--as manger--
GRANT UPDATE ON TABLE country TO sales;
--update--
UPDATE country SET last_update = NOW() WHERE country_id = 102; 
--fix--
GRANT SELECT, UPDATE ON TABLE country TO manager WITH GRANT OPTION;
--fixmanger to sales--
GRANT SELECT, UPDATE ON TABLE country TO sales;
--check--
SELECT * FROM country WHERE country_id=102;

--q5--
CREATE VIEW customer_view AS SELECT * FROM customer;
--permision--
GRANT SELECT ON customer_view TO sales;
--check--fail
SELECT * FROM customer;
--check-pass
SELECT * FROM customer_view;

--q6--
INSERT INTO staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture)
VALUES (3, 'Val', 'Adam', 5, 'val.adam@sakilastaff.com', 1, 't', 'valadam', '8cb2237d0679ca88db6464eac60da96345513964', CURRENT_TIMESTAMP, NULL);
--role--
CREATE ROLE admin WITH CREATEROLE;
--group--
CREATE ROLE valadam WITH LOGIN PASSWORD 'Testing1234!';
GRANT admin TO valadam;
--chec-
\du

--q7--
CREATE ROLE senior_analyst WITH LOGIN PASSWORD 'Testing1234!';
--per--
GRANT USAGE, CREATE ON SCHEMA public TO senior_analyst;
--table--test--
CREATE TABLE new_table ();
--check--fail--
SELECT * FROM customer;