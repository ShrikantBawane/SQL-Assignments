CREATE DATABASE PRACTICE_PROGRAMS_2;

CREATE TABLE employees (employee_id INT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50),job_id VARCHAR(20),
salary DECIMAL(10, 2), department_id INT, hire_date DATE);

CREATE TABLE departments (department_id INT PRIMARY KEY, department_name VARCHAR(50), manager_id INT);

INSERT INTO employees ()
VALUES (101, 'John', 'Smith', 'IT_PROG', 60000, 1, '2021-05-10'),
(102, 'Jane', 'Doe', 'HR_REP', 50000, 2, '2019-03-15'),
(103, 'Alice', 'Johnson', 'IT_PROG', 70000, 1, '2020-11-20'),
(104, 'Bob', 'Brown', 'SALES_REP', 45000, 3, '2022-02-01'),
(105, 'Charlie', 'Lee', 'IT_PROG', 75000, 1, '2018-08-25'),
(106, 'Eve', 'White', 'HR_REP', 52000, 2, '2023-07-15'),
(107, 'Grace', 'Green', 'SALES_REP', 40000, NULL, '2020-06-05');

SELECT * FROM employees;

INSERT INTO departments ()
VALUES (1, 'IT', 101),
(2, 'HR', 102),
(3, 'Sales', 104),
(4, 'Marketing', NULL);

SELECT * FROM DEPARTMENTS;

-----------------------------------------------------------------------------------------------------

-- Q1. Find the total number of employees in each department to understand workload distribution.

SELECT JOB_ID AS DEPARTMENT_NAME, COUNT(CONCAT(first_name,last_name)) AS TOTAL_COUNT
FROM employees
GROUP BY JOB_ID;

-- Q2. Calculate the average salary for each department to evaluate pay scale fairness.

SELECT JOB_ID AS DEPARTMENT_NAME, ROUND(AVG(SALARY),2) AS AVERAGE_SALARY
FROM employees
GROUP BY DEPARTMENT_NAME;

-- Q3. Identify the highest-paid employee in each department to assess top talent.

SELECT 
	JOB_ID AS DEPARTMENT,
	FULL_NAME,
	MAX_SALARY AS HIGHEST_SALARY
FROM (
	SELECT 
		JOB_ID,
		CONCAT(FIRST_NAME, '  ', LAST_NAME) AS FULL_NAME,
		SALARY AS MAX_SALARY
	FROM EMPLOYEES	)
	
AS DETAILS

WHERE MAX_SALARY = (
	SELECT MAX(SALARY) FROM employees E
	WHERE E.JOB_ID = DETAILS.JOB_ID
	)
GROUP BY JOB_ID, FULL_NAME, MAX_SALARY; 

-- Q4. List employees who are not assigned to any department.

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME, JOB_ID AS DEPARTMENT 
FROM employees
WHERE JOB_ID IS NULL;

-- Q5. Find the total salary expenditure for each department to manage budgets.

SELECT JOB_ID AS DEPARTMENT, SUM(SALARY) AS TOTAL_SALARY 
FROM employees
GROUP BY DEPARTMENT; 

-- Q6. Determine the percentage of employees in each department to prioritize hiring needs.

SELECT JOB_ID AS DEPARTMENT, COUNT(*) / 100.0 * (SELECT COUNT(*) FROM employees) AS PERCENTAGE_OF_EMPLOYEES
FROM employees
GROUP BY DEPARTMENT; 

-- Q7. Find the most recent hire date in each department to analyze hiring trends.

SELECT JOB_ID AS DEPARTMENT, MAX(HIRE_DATE) AS RECENT_HIRE_DATE
FROM employees
GROUP BY DEPARTMENT;

-- Q8. Identify employees hired in the last year to track new hires.

SELECT CONCAT(FIRST_NAME,' ',LAST_NAME) AS FULL_NAME, HIRE_DATE
FROM employees
WHERE HIRE_DATE > DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Q9. Calculate the average tenure of employees in each department.

SELECT JOB_ID AS DEPARTMENT, AVG(DATEDIFF(CURDATE(), HIRE_DATE)/365) AS AVERAGE_TENURE_YEAR
FROM employees
GROUP BY DEPARTMENT;

-- Q10. Find the department with the highest salary expenditure.

SELECT JOB_ID AS DEPARTMENT, MAX(SALARY) AS HIGHEST_SALARY
FROM employees
GROUP BY DEPARTMENT
ORDER BY HIGHEST_SALARY
LIMIT 1;

-- Q11. Identify employees earning above the average salary of their department.

SELECT 
    CONCAT(employees.FIRST_NAME, ' ', employees.LAST_NAME) AS FULL_NAME,
    employees.department_id,
    employees.salary,
    dept_data.AVERAGE_SALARY
FROM employees
JOIN (
    SELECT 
        department_id, 
        AVG(salary) AS AVERAGE_SALARY
    FROM employees
    GROUP BY department_id
) AS dept_data
ON employees.department_id = dept_data.department_id
WHERE employees.salary > dept_data.AVERAGE_SALARY;

-- Q12. Recommend departments for budget cuts by finding departments with fewer employees but high salary expenditure.

SELECT DEPARTMENT_ID , COUNT(*) AS NUMBER_OF_EMPLOYEES, SUM(SALARY) AS TOTAL_SALARY
FROM employees
GROUP BY DEPARTMENT_ID
HAVING NUMBER_OF_EMPLOYEES < 3 & TOTAL_SALARY < 100000;

