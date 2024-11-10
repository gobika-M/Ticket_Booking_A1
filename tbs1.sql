CREATE DATABASE TICKET_BOOKING_SYSTEM
drop table venu
--CREATING VENU TABLE
CREATE TABLE Venu (
venue_id INT IDENTITY(1,1) PRIMARY KEY,
venue_name VARCHAR(100) NOT NULL, address VARCHAR(255) NOT NULL)


select *from venu

--CREATION OF EVENT TABLE
CREATE TABLE Event (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    event_type VARCHAR(20) CHECK (event_type IN ('Movie', 'Sports', 'Concert')),
    FOREIGN KEY (venue_id) REFERENCES Venu(venue_id))

	ALTER TABLE EVENT
ADD CONSTRAINT FK_EVENT_ID
FOREIGN KEY (VENUE_ID) REFERENCES VENU(VENUE_id);
SELECT*FROM EVENT

--INSERTION OF RECORDS
INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('nightconcert', '2024-02-01', '18:00:00', 1, 150, 120, 150, 'Movie'),
('OperaNight', '2024-03-15', '20:00:00', 2, 200, 180, 250, 'Concert'),
('BasketballGame', '2024-04-05', '14:30:00', 3, 50000, 49000, 500, 'Sports'),
('ComedyShow', '2024-05-10', '19:00:00', 4, 300, 250, 120, 'Concert'),
('ClassicalConcert', '2024-06-20', '16:00:00', 5, 40000, 38000, 400, 'Sports'),
('cup', '2024-07-25', '17:30:00', 6, 250, 200, 80, 'Movie'),
('FootballGame', '2024-08-10', '19:30:00', 7, 150, 100, 200, 'Concert'),
('CricketMatch', '2024-09-18', '18:00:00', 8, 10000, 9000, 300, 'Sports'),
('RockConcert', '2024-10-12', '20:30:00', 9, 100, 80, 400, 'Concert'),
('MovieNight','2023-09-08','16:00:00',10,28,10,900,'movie')


--CREATION OF CUSTOMER TABLE
CREATE TABLE Customer_Table (
    customer_id INT IDENTITY PRIMARY KEY,
    customer_name VARCHAR(30),
    email VARCHAR(30),
    phone_number BIGINT)

--INSERTION OF CUSTOMER TABLE
INSERT INTO Customer_Table VALUES ('Sri', 'srivarshicse@gmail.com', 934282705);
INSERT INTO CUSTOMER_TABLE  VALUES('John Doe', 'johndoe@example.com', 98765432)
INSERT INTO CUSTOMER_TABLE VALUES('HARISH','hari23@gmail.com',83748)
INSERT INTO CUSTOMER_TABLE VALUES('ROY','roy@gmail.com',9284675)
INSERT INTO CUSTOMER_TABLE VALUES('srisha','sri78@gmail.com',897654)
INSERT INTO CUSTOMER_TABLE VALUES('madhu','madhu@gmail.com',234523)
INSERT INTO CUSTOMER_TABLE VALUES('thiya','thiyanesh@gmail.com',8983874)
INSERT INTO CUSTOMER_TABLE VALUES('sri','srivarshi@gmail.com',78937472)
INSERT INTO CUSTOMER_TABLE VALUES('subha','subasre@gmail.com',782635)
INSERT INTO CUSTOMER_TABLE VALUES('gayi','gayimec@gmail.com',79279734)
INSERT INTO CUSTOMER_TABLE VALUES('varshi','varshi@gmail.com',790000)
select *from Customer_Table
drop table booking_table
--CREATION OF BOOKING TABLE
CREATE TABLE Booking_Table (
    booking_id INT IDENTITY PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost INT,
    booking_date DATE,
	FOREIGN KEY (customer_id) REFERENCES customer_table(customer_id),
	FOREIGN KEY (event_id) REFERENCES event(event_id))

	--INSERTION OF BOOKING TABLE

	INSERT INTO Booking_Table VALUES(1,6,100,1000,'2022-09-10')
	INSERT INTO Booking_Table VALUES(2,5,500,3000,'2023-07-09')
	INSERT INTO Booking_Table VALUES(3,4,7000,850,'2024-01-1')
	INSERT INTO Booking_Table VALUES(4,3,2200,900,'2024-07-13')
	INSERT INTO Booking_Table VALUES(5,2,3300,450,'2023-08-21')
	INSERT INTO Booking_Table VALUES(6,1,400,305,'2022-07-05')
	INSERT INTO Booking_Table VALUES(7,7,700,1050,'2020-08-10')
	INSERT INTO Booking_Table VALUES(8,8,4500,600,'2021-09-07')
	INSERT INTO Booking_Table VALUES(9,9,9000,100,'2022-09-20')
	INSERT INTO Booking_Table VALUES(10,10,2000,1000,'2024-07-10')
	select*from BOOKING_TABLE


---structure
exec sp_help customer_table


ALTER TABLE Customer_Table
ADD CONSTRAINT FK_Booking_Customer
FOREIGN KEY (booking_id) REFERENCES Booking_Table(booking_id);

select*from CUSTOMER_TABLE

---2.Write a SQL query to list all Events
select*from event
SELECT event_name, event_date, event_time FROM Event

--3.Write a SQL query to select events with available tickets
SELECT  available_seats 
FROM Event
WHERE available_seats > 0

--4.Write a SQL query to select events name partial match with ‘cup’
SELECT event_name
FROM Event
WHERE event_name LIKE '%cup%'


--5.Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT  ticket_price
FROM Event
WHERE ticket_price BETWEEN 1000 AND 2500

--6.Write a SQL query to retrieve events with dates falling within a specific range.
SELECT event_date
FROM Event
WHERE event_date BETWEEN '2024-01-01' AND '2024-12-31'

--7.Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * 
FROM Event
WHERE event_name LIKE '%Concert%'
AND available_seats > 0;


--8.Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT *FROM Customer_Table
ORDER BY customer_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

--9.Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
SELECT num_tickets
FROM Booking_Table
WHERE num_tickets > 4;


--10. Write a SQL query to retrieve customer information whose phone number end with ‘000’
SELECT *FROM Customer_Table
WHERE phone_number LIKE '%000'

--11.Write a SQL query to retrieve the events in order whose seat capacity more than 15000
select*from event
where total_seats>15000

--12.Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z
select *from event
where not event_name='x''y''z'

----------------------------------------------------------------------------------------------------------------
--TASK 3

--1.Write a SQL query to List Events and Their Average Ticket Prices
Select avg(ticket_price)as [revenue]
from event

--2.Write a SQL query to Calculate the Total Revenue Generated by Events
SELECT SUM(ticket_price) AS total_revenue
FROM Event;

--3.Write a SQL query to find the event with the highest ticket sales.
SELECT top 1 ticket_price, 
SUM(TICKET_PRICE) AS total_sales
FROM Event
ORDER BY total_sales DESC 
SELECT*FROM EVENT

--4.Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_id,Sum(num_tickets) AS total_tickets_sold
FROM Booking_Table
GROUP BY event_id;

SELECT event_id, count(num_tickets) AS total_tickets_sold
FROM Booking_Table
GROUP BY event_id;
select*from Booking_Table

--5.Write a SQL query to Find Events with No Ticket Sales.
SELECT e.event_id, e.event_name, e.event_date, e.venue_id
FROM Event e
LEFT JOIN Booking_Table b ON e.event_id = b.event_id
WHERE b.num_tickets IS NULL;

--6.Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT TOP 1 b.customer_id, c.customer_name, SUM(b.num_tickets) AS total_tickets_booked
FROM Booking_Table b
JOIN Customer_Table c ON b.customer_id = c.customer_id
GROUP BY b.customer_id, c.customer_name
ORDER BY total_tickets_booked DESC

--7.Write a SQL query to List Events and the total number of tickets sold for each month
SELECT 
    e.event_name,
    YEAR(b.booking_date) AS year,
    MONTH(b.booking_date) AS month,
    SUM(b.num_tickets) AS total_tickets_sold
FROM Booking_Table b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_name, YEAR(b.booking_date), MONTH(b.booking_date)
ORDER BY year DESC, month DESC, e.event_name;

--8.Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
SELECT 
    v.venue_name,
    AVG(e.ticket_price) AS average_ticket_price
FROM Event e
JOIN Venu v ON e.venue_id = v.venue_id
GROUP BY v.venue_name
ORDER BY average_ticket_price DESC;

--9.Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type
SELECT 
    e.event_type,
    SUM(b.num_tickets) AS total_tickets_sold
FROM Booking_Table b
JOIN Event e ON b.event_id = e.event_id
GROUP BY e.event_type
ORDER BY total_tickets_sold DESC;




--10.Write a SQL query to calculate the total Revenue Generated by Events in Each year
SELECT 
    YEAR(b.booking_date) AS year,
    SUM(b.num_tickets * e.ticket_price) AS total_revenue
FROM Booking_Table b
JOIN Event e ON b.event_id = e.event_id
GROUP BY YEAR(b.booking_date)
ORDER BY year DESC;

--11.Write a SQL query to list users who have booked tickets for multiple events.
select*from event
select*from booking_table
select*from customer_table
SELECT 
    c.customer_name, 
 
    COUNT(DISTINCT b.event_id) AS events_booked
FROM Booking_Table b
JOIN Customer_Table c ON b.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT b.event_id) > 1;


--12.Write a SQL query to calculate the Total Revenue Generated by Events for Each User
SELECT 
    c.customer_name,
    c.email,
    SUM(b.num_tickets * e.ticket_price) AS total_revenue
FROM Booking_Table b
JOIN Customer_Table c ON b.customer_id = c.customer_id
JOIN Event e ON b.event_id = e.event_id
GROUP BY c.customer_name, c.email
ORDER BY total_revenue DESC;

--13.Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue
select *from event

select*from venu
select e.event_type, avg(e.ticket_price) as avg_ticket_price
from event as e
where e.event_id=e.venue_id
group by e.event_type
order by e.event_type

--14.Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30Days.
select *from Booking_Table
select*from Customer_Table

select c.customer_name,sum(b.num_tickets)as total_tickets
from Booking_Table as b
join Customer_Table as c 
on b.customer_id=c.customer_id
group by c.customer_name
order by( DATEDIFF(day,'2024-10-22',GETDATE()))
--------------------------------------------------------------------------------------------------------------
----Task 4

--1.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT 
    v.venue_name,
    (SELECT AVG(e.ticket_price)
     FROM Event e
     WHERE e.venue_id = v.venue_id) AS average_ticket_price
FROM Venu v;


--2.Find Events with More Than 50% of Tickets Sold using subquery
SELECT 
    event_name, 
    total_seats, 
    available_seats
FROM Event
WHERE (total_seats - 
       (SELECT available_seats FROM Event AS e2 WHERE e2.event_id = Event.event_id)
      ) > (total_seats * 0.5);

--3.Calculate the Total Number of Tickets Sold for Each Event
SELECT E.EVENT_NAME,

(SELECT SUM(NUM_TICKETS)
FROM Booking_Table AS B
WHERE E.event_id=B.event_id)AS TOTAL_TICKETS_SOLD
FROM EVENT AS E


--4.Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery
SELECT 
    c.customer_name, 
    c.email
FROM Customer_Table c
WHERE NOT EXISTS (
    SELECT ISNULL(NUM_TICKETS,'NO BOOKING')
    FROM Booking_Table b 
    WHERE b.customer_id = c.customer_id);
--5.List Events with No Ticket Sales Using a NOT IN Subquery
SELECT 
    event_name, 
    event_date
FROM Event
WHERE event_id NOT IN (
    SELECT DISTINCT event_id 
    FROM Booking_Table);

--6.Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
 SELECT C.customer_name FROM Customer_Table C WHERE EXISTS (SELECT 1 FROM Booking_Table B
JOIN Event E ON B.event_id = E.event_id
WHERE B.customer_id = C.customer_id
AND E.venue_id = 1); 



--7.Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
select *from event
select event_name,ticket_price
from event
where ticket_price >(select avg(ticket_price)from event)

--8.Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery
select*from Customer_Table
select*from Booking_Table
select*from venu
SELECT 
    c.customer_id,
    c.customer_name,
    (SELECT SUM(b.total_cost)
     FROM Booking_Table b
     WHERE b.customer_id = c.customer_id) AS total_revenue
FROM Customer_Table c;

--9.List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
SELECT E.event_type, (SELECT SUM(num_tickets)
FROM Booking_Table B
WHERE B.event_id = E.event_id) AS total_tickets_sold
FROM Event E;

--10.Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY

SELECT 
    e.event_type,
    SUM(t.total_tickets) AS total_tickets_sold
FROM (
    SELECT 
        event_id, 
        SUM(num_tickets) AS total_tickets
    FROM Booking_Table
    GROUP BY event_id
) AS t
JOIN Event e ON t.event_id = e.event_id
GROUP BY e.event_type;

--11.Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT
SELECT  c.customer_name,
    DATEPART(YEAR, b.booking_date) AS booking_year,
    DATEPART(MONTH, b.booking_date) AS booking_month,
    SUM(b.num_tickets) AS total_tickets from Booking_Table as b,Customer_Table as c

WHERE 
    c.customer_id IN (
        SELECT b.customer_id
        FROM Booking_Table AS b
        WHERE DATEPART(MONTH, b.booking_date) IS NOT NULL
    )
GROUP BY 
    c.customer_name, DATEPART(YEAR, b.booking_date), DATEPART(MONTH, b.booking_date)
ORDER BY 
    booking_year, booking_month;

--12.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery

SELECT EVENT_NAME,(SELECT AVG(TICKET_PRICE)
FROM EVENT
WHERE EVENT.event_id=EVENT.venue_id)AS AVG_TICKET_PRICE
FROM EVENT
----------------------------------*******------------------------------------------------



