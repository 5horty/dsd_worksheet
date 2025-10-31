create table animal_type(
  animal_type_id SERIAL PRIMARY KEY,
  common_name VARCHAR(50) UNIQUE NOT NULL,
  scientific_name VARCHAR(150) NOT NULL,
  conservation_status VARCHAR(50) NOT NULL  
);

create table menagerie(
    menagerie_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL REFERENCES animal_type(common_name),
    date_acquired DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    acquired_from VARCHAR(250) NOT NULL,
    name VARCHAR(50) NOT NULL,
    notes TEXT 
);


INSERT INTO animal_type (common_name, scientific_name, conservation_status)
VALUES ('Bengal Tiger', 'Panthera tigris tigris', 'Endangered');

INSERT INTO animal_type (common_name, scientific_name, conservation_status)
VALUES ('Arctic Wolf', 'Canis lupus arctos', 'Least Concern');

INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES ('Bengal Tiger', '2011-07-14', 'M', 'Dhaka Zoo', 'Ariel', 'Healthy coat at last exam');

INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES ('Bengal Tiger', '2008-09-30', 'F', 'National Zoo', 'Freddy', 'Strong appetite');

INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES ('Arctic Wolf', '2006-06-01', 'M', 'Scotland Zoo', 'Spark', 'Likes to play');

INSERT INTO menagerie (common_name, date_acquired, gender, acquired_from, name, notes)
VALUES ('Arctic Wolf', '2007-06-12', 'F', 'Southampton National Park', 'Mia', 'Doesn''t like sun');



SELECT 
    at.common_name,
    at.scientific_name,
    m.name AS animal_name,
    m.date_acquired
FROM 
    menagerie m
JOIN 
    animal_type at ON m.common_name = at.common_name
WHERE 
    at.conservation_status = 'Endangered'
ORDER BY 
    m.date_acquired;
