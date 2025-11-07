--Question 1: Get a list of customers that require pet or baggage accommodations.
SELECT first_name,last_name, 
CASE pet
    WHEN 1 THEN 'yes'
    WHEN 0 THEN 'no'
END AS 'Pet Accomodation Needed', 
CASE baggage
    WHEN 1 THEN 'yes'
    WHEN 0 THEN 'no'
END AS 'Baggage Accomodation Needed'
FROM customers
WHERE pet = 1 OR baggage = 1

--Question 2: What is the most popular seating accommodations on the train?
SELECT ticket.type AS 'Accomodation Type', ticket.price AS 'Accomodadtion Price', COUNT(ticket.type) AS 'Number of Customers in Accomodation Type'
FROM ticket 
LEFT JOIN customers ON customers.fk_ticket = ticket.id
GROUP BY ticket.type, ticket.price
ORDER BY COUNT(ticket.type) DESC

--Question 3: What is the total profit from the customers who booked economy seating?
SELECT 
  SUM(ticket.price) AS 'Total Revenue From Economy'
FROM customers
JOIN ticket ON customers.fk_ticket = ticket.id
WHERE ticket.type like 'Economy';

--Question 4: The train now offers longer service hours at the bar. Update Castiel to a full-time employee.

SELECT  
    employee_id,
    employee.first_name, 
    employee.last_name, 
    department.name AS department_name, 
    employment_type.type AS employment_type
FROM employee
LEFT JOIN department ON department.id = employee.id
LEFT JOIN employment_type ON employee.fk_employment_type = employment_type.id
ORDER BY fk_employment_type

UPDATE employee 
SET fk_employment_type = (SELECT id FROM employment_type WHERE type = 'full-time')
WHERE employee_id = 23568

--Question 5: How many customers are getting off at each station?
SELECT station.location AS 'Train Station', COUNT(station.location) AS 'Number Of Customers Getting Off At The Train Station'
FROM station
LEFT JOIN customers ON station.id = fk_train_station
GROUP BY station.location

