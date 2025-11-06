/*
Source Server         : DB Tests
Source Server Type    : PostgreSQL
Source Host           : localhost:5433
Source Catalog        : dbprin_lab1
Target Server Type    : PostgreSQL
Target Server Version : 140004

Date: 22/07/2022 13:49:53
 */
-- ----------------------------
-- Table structure for artist
-- ----------------------------
DROP TABLE
  IF EXISTS artist;

CREATE TABLE
  artist (
    artist_id serial PRIMARY KEY NOT NULL,
    artist_name VARCHAR (50) NOT NULL,
    artist_city VARCHAR (30) NOT NULL,
    artist_country CHAR (2) NOT NULL
  );

-- ----------------------------
-- Records of artist
-- ----------------------------
INSERT INTO
  artist (artist_name, artist_city, artist_country)
VALUES
  ('Michael ', 'Portsmouth', 'UK'),
  ('Sarah', 'Seattle', 'US'),
  ('Lolo', 'Prague', 'CZ'),
  ('Joline', 'Warsaw', 'PL'),
  ('John', 'London', 'UK'),
  ('Paul', 'Paris', 'FR'),
  ('George', 'Berlin', 'DE'),
  ('Ringo', 'Liverpool', 'UK');

-- ----------------------------
-- Table structure for artwork
-- ----------------------------
DROP TABLE
  IF EXISTS artwork;

CREATE TABLE
  artwork (
    artwork_id serial PRIMARY KEY NOT NULL,
    work_title VARCHAR (100) NOT NULL,
    price NUMERIC (6, 2) NOT NULL
  );

-- ----------------------------
-- Records of artwork
-- ----------------------------
INSERT INTO
  artwork (work_title, price)
VALUES
  ('My lovely song', 200.00),
  ('Lady in the sun', 250.00),
  ('Night street', 150.00),
  ('Colours of the Sky', 230.00),
  ('Long road to home', 150.00),
  ('The moon', 145.00),
  ('Time', 1001.00),
  ('Walking in the rain', 500.00),
  ('Reflection', 40.00),
  ('The war', 1.00),
  ('Last summer', 245.00),
  ('Remember', 710.00),
  ('Rainbow', 900.00);

-- ----------------------------
-- Table structure for creates
-- ----------------------------
DROP TABLE
  IF EXISTS creates;

CREATE TABLE
  creates (
    artist_id INTEGER NOT NULL,
    artwork_id INTEGER NOT NULL,
    CONSTRAINT fk1_artist FOREIGN KEY (artist_id) REFERENCES artist (artist_id),
    CONSTRAINT fk2_artwork FOREIGN KEY (artwork_id) REFERENCES artwork (artwork_id)
  );

-- ----------------------------
-- Records of creates
-- ----------------------------
INSERT INTO
  creates (artist_id, artwork_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 12),
  (2, 3),
  (3, 4),
  (3, 5),
  (4, 6),
  (5, 7),
  (5, 8),
  (6, 9),
  (6, 10),
  (6, 11),
  (7, 2),
  (7, 5),
  (7, 12),
  (8, 5),
  (8, 10),
  (8, 13);

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE
  IF EXISTS customer;

CREATE TABLE
  customer (
    cust_id serial PRIMARY KEY NOT NULL,
    cust_name VARCHAR (50) NOT NULL,
    cust_city VARCHAR (30) NOT NULL,
    cust_country CHAR (2) NOT NULL
  );

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO
  customer (cust_name, cust_city, cust_country)
VALUES
  ('Harry', 'Liverpool ', 'UK'),
  ('Margaret', 'Chicago', 'US'),
  ('Sally', 'London ', 'UK'),
  ('Mary', 'Paris ', 'FR'),
  ('John', 'Berlin ', 'DE'),
  ('Paul', 'Warsaw ', 'PL'),
  ('Michael', 'Portsmouth ', 'UK'),
  ('Sarah', 'Seattle ', 'US'),
  ('Adda', 'Rome', 'IT');

  -- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE
  IF EXISTS purchase;

CREATE TABLE
  purchase (
    cust_id INTEGER NOT NULL,
    artwork_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    CONSTRAINT fk3_customer FOREIGN KEY (cust_id) REFERENCES customer (cust_id),
    CONSTRAINT fk4_artwork FOREIGN KEY (artwork_id) REFERENCES artwork (artwork_id)
  );

-- ----------------------------
-- Records of purchase
-- ----------------------------
INSERT INTO
  purchase (cust_id, artwork_id, quantity)
VALUES
  (1, 1, 4),
  (1, 2, 2),
  (2, 3, 2),
  (3, 4, 3),
  (3, 5, 2),
  (3, 6, 1),
  (4, 8, 1),
  (4, 9, 1),
  (4, 10, 1),
  (5, 11, 1),
  (5, 12, 1),
  (6, 13, 1),
  (7, 5, 3),
  (6, 2, 1),
  (6, 3, 3),
  (6, 5, 2),
  (5, 9, 7),
  (6, 12, 1),
  (7, 13, 2),
  (7, 9, 4),
  (7, 7, 2),
  (7, 2, 1);

--q8--
SELECT 
    ar.artist_name as "Artist Name"--why use uppercase make slife hard--
FROM 
    artist ar
    JOIN creates c ON ar.artist_id = c.artist_id
    JOIN artwork aw ON c.artwork_id = aw.artwork_id
WHERE 
    aw.work_title = 'Rainbow';

--q9--
SELECT 
    aw.work_title as "Artwork Title"
FROM 
    artwork aw
    JOIN creates c ON aw.artwork_id = c.artwork_id
    JOIN artist ar ON c.artist_id = ar.artist_id
WHERE 
    ar.artist_name = 'Lolo';
--q10--
SELECT 
    c.cust_name as "Customer Name",
    aw.work_title as "Artwork Title",
    CONCAT('£', aw.price) as "Price"
FROM 
    customer c
    JOIN purchase p ON c.cust_id = p.cust_id
    JOIN artwork aw ON p.artwork_id = aw.artwork_id
WHERE 
    aw.price <= 200
ORDER BY 
    aw.price ASC;
    
----done---