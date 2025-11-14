USE RISE_TASKS_1
-- RAILWAY BOOKING SYSTEM --


-- TRAINS TABLE
CREATE TABLE Trains(
TRAIN_ID INT PRIMARY KEY ,
TRAIN_NAME VARCHAR(100) NOT NULL,
SOURCE VARCHAR(100) NOT NULL,
DESTINATION VARCHAR(50) NOT NULL,
DEPARTUE_TIME TIME NOT NULL,
ARRIVAL_TIME TIME NOT NULL,
DISTANCE_KM INT CHECK (DISTANCE_KM > 0)
);


-- PASSENGER TABLE
CREATE TABLE Passengers(
PASSENGER_ID INT PRIMARY KEY,
NAME VARCHAR(100) NOT NULL,
AGE INT CHECK(AGE > 0),
GENDER CHAR(1) CHECK (GENDER IN ('M','F')),
CITY VARCHAR(50)
);


-- RESERVATION
CREATE TABLE Reservation(
RES_ID INT PRIMARY KEY,
PASSENGER_ID INT,
TRAIN_ID INT,
TRAVEL_DATE DATE NOT NULL,
CLASS VARCHAR(20) CHECK (CLASS IN ('SLEEPER','AC1','AC2','AC3')),
FARE DECIMAL(10,2) CHECK (FARE > 0),
STATUS VARCHAR(20) CHECK (STATUS IN ('CONFIRMED','WAITING','CANCELLED'))

FOREIGN KEY (PASSENGER_ID) REFERENCES PASSENGERS(PASSENGER_ID) ON DELETE CASCADE,
FOREIGN KEY (TRAIN_ID) REFERENCES TRAINS(TRAIN_ID) ON DELETE CASCADE
);


INSERT INTO Trains VALUES
(101,'SHATABDI EXP','DELHI','BHOPAL','06:00','14:00',700),
(102,'RAJDHANI EXP','DELHI','MUMBAI','16:00','08:00',1400),
(103,'DURONTO EXP','MUMBAI','CHENNAI','20:00','10:00',1300),
(104,'GARIB RATH','KOLKATA','DELHI','12:00','06:00',1500);

INSERT INTO Passengers VALUES
(1,'RAMESH',45,'M','DELHI'),
(2,'SITA',32,'F','MUMBAI'),
(3,'ARJUN',28,'M','BHOPAL'),
(4,'PRIYA',19,'F','CHENNAI'),
(5,'ANIL',52,'M','KOLKATA');

INSERT INTO Reservation VALUES
(201,1,101,'2025-09-01','SLEEPER',500,'CONFIRMED'),
(202,2,102,'2025-09-05','AC2',1800,'CONFIRMED'),
(203,3,101,'2025-09-01','SLEEPER',500,'WAITING'),
(204,4,103,'2025-09-07','AC3',1200,'CONFIRMED'),
(205,5,104,'2025-09-10','SLEEPER',600,'CANCELLED');

-- EXTRA DATA FOR MORE OPTIMISED QQUERYIES
-- Additional TRAINS (8 more)
INSERT INTO Trains VALUES
(105,'EXPRESS MAIL','DELHI','LUCKNOW','07:00','13:30',500),
(106,'INTERCITY EXP','MUMBAI','PUNE','09:00','12:00',200),
(107,'JAN SHATABDI','CHENNAI','BANGALORE','05:30','11:00',350),
(108,'SUPERFAST EXP','JAIPUR','DELHI','14:00','21:00',450),
(109,'NAVJEEVAN EXP','AHMEDABAD','CHENNAI','06:45','09:30',1600),
(110,'KONKAN KANYA','MUMBAI','GOA','23:00','07:00',600),
(111,'NIZAMUDDIN EXP','DELHI','HYDERABAD','15:00','09:30',1250),
(112,'HOWRAH MAIL','KOLKATA','MUMBAI','19:00','11:30',1960);

-- Additional PASSENGERS (8 more)
INSERT INTO Passengers VALUES
(6,'RAHUL',29,'M','LUCKNOW'),
(7,'MEENA',40,'F','PUNE'),
(8,'VIKAS',34,'M','JAIPUR'),
(9,'ANITA',27,'F','AHMEDABAD'),
(10,'ROHAN',22,'M','GOA'),
(11,'KAVITA',36,'F','BANGALORE'),
(12,'SUNIL',48,'M','HYDERABAD'),
(13,'NEHA',31,'F','RAIPUR');

-- Additional RESERVATIONS (9 more)
INSERT INTO Reservation VALUES
(206,6,105,'2025-09-02','SLEEPER',450,'CONFIRMED'),
(207,7,106,'2025-09-04','AC1',900,'CONFIRMED'),
(208,8,108,'2025-09-06','AC2',1100,'WAITING'),
(209,9,109,'2025-09-08','SLEEPER',1500,'CONFIRMED'),
(210,10,110,'2025-09-10','AC3',850,'CANCELLED'),
(211,11,107,'2025-09-03','AC2',600,'CONFIRMED'),
(212,12,111,'2025-09-09','AC1',2000,'CONFIRMED'),
(213,13,112,'2025-09-11','SLEEPER',1800,'WAITING'),
(214,6,110,'2025-09-12','AC3',700,'CONFIRMED');


--List all trains running from Delhi as source station.
SELECT * FROM Trains
WHERE SOURCE = 'DELHI'

--Find all passengers who are above 40 years of age.
SELECT * FROM Passengers
WHERE AGE > 40

--Get the total number of reservations made.
SELECT COUNT(RES_ID) AS TOTAL_RESERVATION FROM Reservation

--Count how many reservations are in 'Confirmed' status.
SELECT COUNT(RES_ID) AS TOTAL_CONFIRMED_RESERVATION FROM Reservation
WHERE STATUS = 'CONFIRMED'

--Show the average fare paid for each train.
SELECT T.TRAIN_ID, T.TRAIN_NAME, AVG(FARE) AS AVG_FARE
FROM Reservation R INNER JOIN Trains T
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_ID, T.TRAIN_NAME
ORDER BY T.TRAIN_ID
 
--List reservations ordered by fare in descending order.
SELECT * FROM Reservation
ORDER BY FARE DESC

--Find passengers who booked AC classes (AC2, AC3).
SELECT P.PASSENGER_ID, P.NAME, R.CLASS
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
WHERE CLASS IN ('AC2','AC3')

--Get total revenue collected per train (only Confirmed reservations).
SELECT T.TRAIN_NAME, R.STATUS, SUM(FARE) AS TOTAL_REVENUE
FROM Reservation R JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
WHERE R.STATUS = 'CONFIRMED'
GROUP BY T.TRAIN_NAME, R.STATUS

--Find the train with the maximum distance_km.
SELECT TOP 1 TRAIN_NAME, DISTANCE_KM FROM Trains
ORDER BY DISTANCE_KM DESC
-- OR
SELECT TRAIN_NAME, DISTANCE_KM FROM Trains
WHERE DISTANCE_KM = (SELECT MAX(DISTANCE_KM) FROM Trains)

--Show number of male and female passengers.
SELECT GENDER, COUNT(PASSENGER_ID) AS PASSENGERS FROM Passengers
GROUP BY GENDER

--Get the passenger names who have booked tickets in Sleeper class.
SELECT P.NAME, R.CLASS
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
WHERE R.CLASS = 'SLEEPER'

--Find total number of reservations made from each city (JOIN with Passengers).
SELECT P.CITY , COUNT(R.RES_ID) AS TOTAL_RESERVATION
FROM Reservation R JOIN Passengers P
ON P.PASSENGER_ID = R.PASSENGER_ID
GROUP BY P.CITY

--Show train name and total passengers booked for it, ordered by passenger count descending.
SELECT T.TRAIN_NAME, COUNT(R.PASSENGER_ID) AS TOTAL_PASSENGER
FROM Reservation R INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
GROUP BY T.TRAIN_NAME

--Find the average age of passengers who booked 'Confirmed' tickets.
SELECT R.STATUS, AVG(P.AGE) AS AVG_AGE
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
WHERE STATUS = 'CONFIRMED'
GROUP BY R.STATUS

--Display travel_date and number of reservations made on that date.
SELECT TRAVEL_DATE, COUNT(RES_ID) AS TOTAL_RESERVATION
FROM Reservation
GROUP BY TRAVEL_DATE




------------------------------- PRACTICE QUESTIONS ---------------------------------------
-- 1. Show all reservations where fare is greater than 1000.
SELECT * FROM Reservation
WHERE FARE > 1000

-- 2. List all passengers who live in Delhi or Mumbai.
SELECT * FROM Passengers
WHERE CITY IN ('DELHI', 'MUMBAI')

-- 3. Show all trains whose distance is more than 1200 km.
SELECT * FROM Trains
WHERE DISTANCE_KM > 1200

-- 4. Find reservations which are not "Cancelled".
SELECT * FROM Reservation
WHERE STATUS <> 'CANCELLED'

-- 5. Show the details of trains that have "Exp" in their name.
SELECT * FROM Trains
WHERE TRAIN_NAME LIKE '%EXP%'

-- 6. List all passengers ordered by their age in descending order.
SELECT * FROM Passengers
ORDER BY AGE DESC

-- 7. Display reservations sorted by travel_date (earliest first).
SELECT * FROM Reservation
ORDER BY TRAVEL_DATE DESC

-- 8. Find all trains ordered by distance (longest route first).
SELECT * FROM Trains
ORDER BY DISTANCE_KM DESC

-- 9. Show passengers ordered by name alphabetically.
SELECT * FROM Passengers
ORDER BY NAME

-- 10. List reservations ordered by class and then by fare.
SELECT * FROM Reservation
ORDER BY CLASS, FARE

-- 11. Count how many passengers are from each city.
SELECT CITY, COUNT(PASSENGER_ID) AS PASSENGERES FROM Passengers
GROUP BY CITY

-- 12. Find the total fare collected from all Confirmed reservations.
SELECT SUM(FARE) AS TOTAL_FARE FROM Reservation
WHERE STATUS = 'CONFIRMED'

-- 13. Show the minimum, maximum, and average age of passengers.
SELECT MAX(AGE) AS MAX_AGE, MIN(AGE) AS MIN_AGE, AVG(AGE) AS AVG_AGE FROM Passengers

-- 14. Find the highest fare paid in Sleeper class.
SELECT CLASS, MAX(FARE) AS HIGHEST_FARE FROM Reservation
WHERE CLASS = 'SLEEPER'
GROUP BY CLASS

-- 15. Get the average fare per travel_date.
SELECT TRAVEL_DATE, AVG(FARE) AS AVG_FARE  FROM Reservation
GROUP BY TRAVEL_DATE

-- 16. Show each class and the total number of reservations in it.
SELECT CLASS, COUNT(RES_ID) AS TOTAL_RESERVATIONS FROM Reservation
GROUP BY CLASS

-- 17. Find trains that have more than 1 reservation.
SELECT T.TRAIN_ID, T.TRAIN_NAME, COUNT(RES_ID) AS TOTAL_RSERVATIONS
FROM Trains T INNER JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_ID, T.TRAIN_NAME
HAVING COUNT(RES_ID) > 1

-- 18. List cities where more than 1 passenger lives.
SELECT CITY, COUNT(PASSENGER_ID) AS PASSENGERS
FROM Passengers
GROUP BY CITY
HAVING COUNT(PASSENGER_ID) > 1

-- 19. Show gender-wise average age of passengers.
SELECT GENDER, AVG(AGE) AS AVG_AGE FROM Passengers
GROUP BY GENDER

-- 20. Find passengers who booked more than 1 ticket.
SELECT P.PASSENGER_ID, P.NAME, COUNT(R.RES_ID) AS TOTAL_BOOKING
FROM Passengers P JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
GROUP BY P.PASSENGER_ID, P.NAME
HAVING COUNT(R.RES_ID) > 1

-- 21. Show passenger name, train name, and fare for each reservation.
SELECT P.NAME, T.TRAIN_NAME, R.FARE
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID

-- 22. List all passengers and the train name they booked (if any).
SELECT P.NAME, T.TRAIN_NAME
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID

-- 23. Show all trains and the number of passengers booked in each.
SELECT T.TRAIN_NAME, COUNT(R.PASSENGER_ID) AS TOTAL_PASSENGERS
FROM Reservation R INNER JOIN Passengers P
ON R.PASSENGER_ID = P.PASSENGER_ID
INNER JOIN Trains T
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_NAME

-- 24. Find all passengers who booked Rajdhani Exp.
SELECT P.PASSENGER_ID, P.NAME, T.TRAIN_NAME
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
WHERE T.TRAIN_NAME = 'RAJDHANI EXP'

-- 25. List passenger names with their travel_date and status.
SELECT P.NAME, R.TRAVEL_DATE, R.STATUS
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID

-- 26. Find the top 2 highest fare reservations.
SELECT TOP 2 RES_ID,PASSENGER_ID,FARE
FROM Reservation
ORDER BY FARE DESC

-- 27. Find the train with the lowest average fare.
SELECT TOP 1 T.TRAIN_NAME, AVG(FARE) AS AVG_FARE
FROM Trains T INNER JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_NAME
ORDER BY AVG_FARE ASC

-- 28. Show the train(s) where total distance travelled by all passengers > 1000 km.
SELECT T.TRAIN_NAME, SUM(T.DISTANCE_KM) AS TOTAL_DISTANCE_TRAVELLED
FROM Trains T INNER JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_NAME
HAVING SUM(T.DISTANCE_KM) > 1000

-- 29. Find passengers whose reservation status is "Waiting".
SELECT P.PASSENGER_ID, P.NAME, R.STATUS
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
WHERE R.STATUS = 'WAITING'

-- 30. Show the passenger(s) who paid the maximum fare overall.
SELECT TOP 1 P.NAME, R.FARE
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
ORDER BY R.FARE DESC

-- 31. Show all passengers whose age is between 20 and 40.
SELECT * FROM Passengers
WHERE AGE BETWEEN 20 AND 40

-- 32. Find trains that start from Kolkata or Chennai.
SELECT *
FROM Trains
WHERE SOURCE = 'KOLKATA' OR SOURCE = 'CHENNAI' -- IN ('KOLKATA', 'CHENNAI')

-- 33. Show all reservations made after 2025-09-05.
SELECT * FROM Reservation
WHERE TRAVEL_DATE > '2025-09-5'

-- 34. Display passengers whose name starts with 'A'.
SELECT NAME FROM Passengers
WHERE NAME LIKE 'A%'

-- 35. List passengers whose city is NOT Delhi.
SELECT NAME, CITY FROM Passengers
WHERE CITY != 'DELHI'

-- 36. Show the 3 youngest passengers.
SELECT TOP 3* FROM Passengers
ORDER BY AGE ASC

-- 37. Show the 2 longest-distance trains.
SELECT TOP 2* FROM Trains
ORDER BY DISTANCE_KM DESC

-- 38. Display the 5 most expensive reservations (highest fare).
SELECT TOP 5 * FROM Reservation
ORDER BY FARE DESC

-- 39. List trains in alphabetical order of train_name.
SELECT * FROM Trains
ORDER BY TRAIN_NAME

-- 40. Show passengers sorted by age (youngest first).
SELECT * FROM Passengers
ORDER BY AGE

-- 41. Find the average fare of all reservations.
SELECT AVG(FARE) AS AVG_FARE FROM Reservation

-- 42. Count the total number of male passengers.
SELECT COUNT(PASSENGER_ID) AS MALE_PASSENGERS FROM Passengers
WHERE GENDER = 'M'

-- 43. Show the maximum distance among all trains.
SELECT TRAIN_ID, TRAIN_NAME, DISTANCE_KM FROM Trains
WHERE DISTANCE_KM = (SELECT MAX(DISTANCE_KM) FROM Trains)

-- 44. Find the total number of Sleeper class reservations.
SELECT CLASS, COUNT(RES_ID) AS TOTAL_RESERVATION FROM Reservation
WHERE CLASS = 'SLEEPER'
GROUP BY CLASS

-- 45. Find the total fare paid by passengers from Mumbai.
SELECT P.CITY, SUM(R.FARE) AS TOTAL_FARE
FROM Reservation R INNER JOIN Passengers P
ON R.PASSENGER_ID = P.PASSENGER_ID
WHERE P.CITY = 'MUMBAI'
GROUP BY P.CITY

-- 46. Count the number of reservations per status (Confirmed/Waiting/Cancelled).
SELECT STATUS, COUNT(RES_ID) AS TOTA_RESERVATION
FROM Reservation
GROUP BY STATUS

-- 47. Find the total number of passengers per gender.
SELECT GENDER, COUNT(PASSENGER_ID) AS TOTAL_PASSENGERS FROM Passengers
GROUP BY GENDER

-- 48. Show the average fare for each class.
SELECT CLASS, AVG(FARE) AS AVG_FARE FROM Reservation
GROUP BY CLASS

-- 49. Display the number of trains starting from each source city.
SELECT P.CITY, COUNT(T.TRAIN_ID) AS TOTAL_TRAINS
FROM Trains T JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
INNER JOIN Passengers P
ON P.PASSENGER_ID = R.PASSENGER_ID
GROUP BY P.CITY

-- 50. Show total reservations grouped by travel_date.
SELECT TRAVEL_DATE, COUNT(RES_ID) AS TOTAL_RESERVATION FROM Reservation
GROUP BY TRAVEL_DATE

-- 51. Show passenger name, city, and train_name they booked.
SELECT P.NAME, P.CITY, T.TRAIN_NAME
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID

-- 52. List all reservations with passenger name and status.
SELECT P.NAME, R.STATUS
FROM Reservation R INNER JOIN Passengers P
ON R.PASSENGER_ID = P.PASSENGER_ID

-- 53. Show train_name and number of confirmed passengers on it.
SELECT T.TRAIN_NAME, COUNT(R.RES_ID) AS TOTAL_CNF_PASSENGER
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
WHERE R.STATUS = 'CONFIRMED'
GROUP BY T.TRAIN_NAME

-- 54. Display all passengers with train_name (if booked, else show NULL).
SELECT P.NAME, T.TRAIN_NAME
FROM Passengers P LEFT JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
LEFT JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID

-- 55. Find which passengers booked Garib Rath train.
SELECT P.NAME, T.TRAIN_NAME 
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
WHERE T.TRAIN_NAME = 'GARIB RATH'

-- 56. Show train_id and total fare collected, but only where fare > 1000.
SELECT T.TRAIN_ID, SUM(R.FARE) AS TOTAL_FARE
FROM Trains T INNER JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
WHERE R.FARE > 1000
GROUP BY T.TRAIN_ID

-- 57. List source cities that have more than 1 train.
SELECT T.SOURCE, COUNT(T.TRAIN_ID) AS TRAINS_RUNNING
FROM Passengers P INNER JOIN Reservation R
ON P.PASSENGER_ID = R.PASSENGER_ID
INNER JOIN Trains T
ON R.TRAIN_ID = T.TRAIN_ID
GROUP BY T.SOURCE
HAVING COUNT(T.TRAIN_ID) > 1


-- 58. Find passengers grouped by city where count > 1.
SELECT CITY, COUNT(PASSENGER_ID) AS TOTAL_PASSENGERS
FROM Passengers
GROUP BY CITY
HAVING COUNT(PASSENGER_ID) > 1

-- 59. Show classes that earned more than 2000 fare in total.
SELECT CLASS, SUM(FARE) AS TOTAL_FARE FROM Reservation
GROUP BY CLASS
HAVING SUM(FARE) > 2000

-- 60. List trains that have at least 2 passengers booked.
SELECT T.TRAIN_NAME, COUNT(RES_ID)
FROM Trains T INNER JOIN Reservation R
ON T.TRAIN_ID = R.TRAIN_ID
GROUP BY T.TRAIN_NAME

-- 61. Find the passenger(s) with the highest age.


-- 62. Show the train(s) with the shortest distance.

-- 63. Find the reservation(s) with the lowest fare.

-- 64. List passengers who paid above the average fare.

-- 65. Find trains whose distance is above the average train distance.

-- 66. Show all reservations in September 2025.

-- 67. Find the earliest travel_date booked.

-- 68. Find the latest travel_date booked.

-- 69. Count how many reservations are made per day.

-- 70. List passengers who booked tickets on the same date.

-- 71. Show passenger name, train_name, and distance travelled.

-- 72. Find the city that contributed the highest number of passengers.

-- 73. Display each train and its average fare (confirmed only).

-- 74. Show passengers who booked tickets in more than one class.

-- 75. Find train_name with maximum number of reservations.

SELECT * FROM Trains
SELECT * FROM Passengers
SELECT * FROM Reservation