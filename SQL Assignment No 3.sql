CREATE DATABASE TEST;

-- Creating table
CREATE TABLE EMPLOYEEINFO(EMPID INT, EMPFNAME VARCHAR(20),EMPLNAME VARCHAR(20),DEPARTMENT VARCHAR(20),PROJECT VARCHAR(10),ADDRESS VARCHAR(25),DOB DATE,GANDER VARCHAR(5));

INSERT INTO employeeinfo ()       -- Inserting values to the table
VALUES
(1, "Sanjay", "Mehra", "HR", "P1", "Hyderabad(HYD)", '1996-12-01', "M"),
(2, "Ananya", "Mehra", "Admin", "P2", "Delhi(DEL)", '1968-05-02', "F"),
(3, "Rohan", "Diwan", "Account", "P3", "Mumbai(BOM)", '1980-01-01', "M"),
(4, "Sonia", "Kulkirni", "HR", "P1", "Hyderabad(HYD)", '1992-05-02', "F"),
(5, "Ankit", "Kapur", "Admin", "P2", "Delhi(DEL)", '1994-07-03', "M");

SELECT * FROM employeeinfo;  -- for extract all data from table

CREATE TABLE EMPLOYEEPOSITION(EMPID INT,EMPPOSITION VARCHAR(20),DATEOFJOINING DATE,SALARY REAL); -- creating table

INSERT INTO employeeposition()       -- inserting values to the table
VALUES
(1, "Manager", '2022-05-01', 500000),
(2, "Executive", '2022-05-02', 75000),
(3, "Manager", '2022-05-01', 90000),
(2, "Lead", '2022-05-02', 85000),
(1, "Executive", '2022-05-01', 300000);

SELECT * FROM employeeposition;    -- for extract all data from table

-- 1 Write a query to fetch the EMPFNAME from the EMPLOYEEINFO table in uppercase and use the ALICE name as EmpName.

SELECT UPPER(EMPFNAME) AS EmpName FROM employeeinfo;

-- 2 Write a query to fetch the number of employees working in the department "HR".

SELECT COUNT(DEPARTMENT) AS DEPERTMENT_COUNT FROM employeeinfo
WHERE DEPARTMENT = "HR";

-- 3 Write a query to get the current date.

SELECT CURDATE();

-- 4 Write a query to retrive the first four characters of EMPLNAME from the EMPLOYEEINFO TABLE

SELECT SUBSTRING(EMPLNAME,1,4) AS FIRST_FOUR_CHARACTER FROM employeeinfo;

-- 5 Write a query to create a new table which consist of data and structure copied from the other table

CREATE TABLE COPIED_TABLE(SELECT * FROM employeeinfo);

SELECT * FROM copied_table;   -- for extract all data from the table

-- 6 Write a query to find all the employees whose salary is between 50000 to 100000

SELECT employeeinfo.EMPFNAME, EMPLOYEEPOSITION.SALARY
FROM employeeinfo
RIGHT JOIN EMPLOYEEPOSITION ON employeeinfo.EMPID = EMPLOYEEPOSITION.EMPID
WHERE SALARY BETWEEN 50000 AND 100000;

-- 7 Write a query to find names of employees that begin with 'S'

SELECT EMPFNAME FROM employeeinfo
WHERE EMPFNAME LIKE 's%';

-- 8 Write a query to fetch top 4 records from the employeeinfo table. "Full Name". The first and the last name must be seperate with space.

SELECT CONCAT(EMPFNAME," ", EMPLNAME) AS FULL_NAME FROM employeeinfo
LIMIT 4;

-- 9 Write a query to find number of employees whose DOB is between 02/05/1970 to 02/05/1992 

SELECT COUNT(EMPFNAME) AS NUMBER_OF_EMPLOYEE FROM employeeinfo
WHERE DOB BETWEEN '1970-05-02' AND '1992-05-02';

-- 10 Write a query to retrive EmpFname and EmpLname in a single columb as FULL_NAME and are grouped according to gender

SELECT GANDER AS GENDER,CONCAT(EMPFNAME," " , EMPLNAME) AS FULL_NAME FROM employeeinfo
GROUP BY GANDER;

-- 11 Write a query to fetch all records from the employeeinfo table ordered by EmpLname in descending order and Department in the ascending order.

SELECT * FROM employeeinfo
ORDER BY EMPLNAME DESC, DEPARTMENT ASC;

-- 12 Write a query to fetch details of employees whose EmpLname ends with an alphabet "A" and contains five characters

SELECT * FROM employeeinfo
WHERE EMPLNAME LIKE '____A';

-- 13 Write a query to fetch details of all employees excluding the employees with first name "Sanjay" and "Sonia" from the employeeinfo table

SELECT * FROM employeeinfo
WHERE EMPFNAME NOT IN ("Sanjay","Sonia");

-- 14 Write a query to fetch details of employees with the address as "DELHI(DEL)".

SELECT * FROM employeeinfo
WHERE ADDRESS = "Delhi(DEL)";

-- 15 Write a query to fetch all employees who also hold the managerial position

SELECT * FROM EMPLOYEEPOSITION
WHERE EMPPOSITION = "Manager";

-- 16 Write a query to fetch department wise count of employees sorted by department's count in ascending order

SELECT DISTINCT(DEPARTMENT), COUNT(DEPARTMENT) AS COUNT_DEPARTMENT FROM employeeinfo
GROUP BY DEPARTMENT
ORDER BY COUNT(DEPARTMENT);

-- 17 Write a query to retrive two minimum and maximum salaries from the employeeposition table

SELECT SALARY FROM EMPLOYEEPOSITION
ORDER BY SALARY
LIMIT 2;

SELECT SALARY FROM EMPLOYEEPOSITION
ORDER BY SALARY DESC
LIMIT 2

-- 18 Write a query to find 5th highest salary from the table

SELECT SALARY FROM EMPLOYEEPOSITION
ORDER BY SALARY DESC
LIMIT 4,1;

-- 19 Write a query to retrive dublicate records from the table

SELECT EMPID FROM EMPLOYEEPOSITION
GROUP BY EMPID
HAVING COUNT(EMPID)>1;

-- 20 Write a query to to retrive the the list of employees working in the "HR" and "ADMIN" department 

SELECT * FROM employeeinfo
WHERE DEPARTMENT IN ("HR","ADMIN");

-- 21 Write a query to find third highest salary from the empposition table

SELECT SALARY FROM EMPLOYEEPOSITION
ORDER BY SALARY DESC
LIMIT 2,1;

-- 22 Write a query to display the record where empid is 1

SELECT * FROM employeeinfo
WHERE EMPID = 1;

-- 23 Write a query to display the record where empid is 5

SELECT * FROM employeeinfo
WHERE EMPID = 5;

-- 24 Write a query to retrive departments who have less than 2 employees working in it.

SELECT DEPARTMENT , COUNT(DEPARTMENT) FROM employeeinfo
GROUP BY DEPARTMENT
HAVING COUNT(DEPARTMENT)<2;

-- 25 Write a query to retrive EmpPosition along with total salaries paid for each of them

SELECT EMPPOSITION FROM EMPLOYEEPOSITION
GROUP BY EMPPOSITION
HAVING SUM(SALARY);
