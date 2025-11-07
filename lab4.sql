--q1--
SELECT 
    e.name as "Employee Name",
    d.department as "Department",
    p.project_name as "Project Name"
FROM 
    Employees e
    JOIN Departments d ON e.dept_id = d.dept_id
    JOIN Projects p ON e.project_id = p.project_id;

--q2--
SELECT 
    d.department as "department",
    COUNT(e.emp_id) as "number of employes"
FROM 
    Departments d
    LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY 
    d.department
ORDER BY 
    COUNT(e.emp_id) DESC;

--q3--
SELECT 
    d.department as "department",
    d.location as "location",
    e.name as "employee name"
FROM 
    Departments d
    LEFT JOIN Employees e ON d.dept_id = e.dept_id
WHERE 
    d.location IN ('London', 'Manchester')
ORDER BY 
    d.department, e.name;

--q4--
SELECT 
    o.order_id as "order ID",
    o.order_date as "order Date",
    s.shipper_name as "shipper name",
    c.customer_name as "customer name"
FROM 
    Orders o
    JOIN Shippers s ON o.shipper_id = s.shipper_id
    LEFT JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY 
    o.order_id;

--q5--
SELECT 
    t.team_name as "Team Name",
    v.venue_name as "Venue Name"
FROM 
    Teams t
    CROSS JOIN Venues v
ORDER BY 
    t.team_name, v.venue_name;--duble trouble first rpior

--q6--
SELECT 
    e.name as "employee name",
    m.name as "manager name",
    d.department as "manager department"
FROM 
    Employees e
    LEFT JOIN Employees m ON e.manager_id = m.emp_id
    LEFT JOIN Departments d ON m.dept_id = d.dept_id
ORDER BY 
    e.name;

--wrksheet code--
--q7--
SELECT m.name,
    b.title,
    g.genre_name
FROM Members m
    JOIN Loans l ON m.member_id = l.member_id
    JOIN Books b ON l.book_id = b.book_id
    JOIN Genres g ON b.genre_id = g.genre_id
WHERE g.genre_name = 'Science Fiction';
--nodes joins 
--leaves base tables
--root final output
--q8--
SELECT 
    p.name as "product mame",
    ca.category_name as "category name",
    cu.cust_name as "customer name"
FROM 
    Products p
    JOIN Sales s ON p.product_id = s.product_id
    JOIN Categories ca ON p.category_id = ca.category_id
    JOIN Customers cu ON s.customer_id = cu.customer_id
WHERE 
    ca.category_name = 'Electronics';

π f.flight_no, a.airport_name, l.airline_name
|
σ l.airline_name = 'SkyJet'
|
⋈ f.airline_id = l.airline_id
|        /             \
        /              airlines
⋈ r.destination_id = a .airport_id
       /                     \
     /                        airpots
⋈ f.route_id = r.route_id
   /                  \
flights                routes

