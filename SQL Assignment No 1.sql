CREATE DATABASE PRACTICE_PROGRAMS;

-- Create the table schema for 'students'
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(1),
    grade INT,
    math_score INT,
    reading_score INT,
    writing_score INT,
    attendance INT,
    class_teacher VARCHAR(50),
    class_section VARCHAR(5)
);


-- Insert sample data into the 'students' table
INSERT INTO students (student_id, first_name, last_name, age, gender, grade, math_score, reading_score, writing_score, attendance, class_teacher, class_section) 
VALUES 
(1, 'John', 'Doe', 14, 'M', 8, 85, 78, 90, 170, 'Mr. Smith', 'A'),
(2, 'Emma', 'Brown', 13, 'F', 8, 92, 88, 95, 180, 'Mr. Smith', 'A'),
(3, 'Sophia', 'Johnson', 15, 'F', 9, 78, 85, 88, 160, 'Ms. Davis', 'B'),
(4, 'James', 'Miller', 14, 'M', 8, 75, 72, 80, 165, 'Mr. Smith', 'A'),
(5, 'Isabella', 'Wilson', 13, 'F', 8, 65, 79, 70, 175, 'Mr. Smith', 'A'),
(6, 'Liam', 'Anderson', 14, 'M', 9, 95, 88, 94, 180, 'Ms. Davis', 'B'),
(7, 'Mia', 'Thomas', 13, 'F', 7, 82, 89, 78, 172, 'Mr. Johnson', 'C'),
(8, 'William', 'Moore', 14, 'M', 9, 88, 91, 85, 180, 'Ms. Davis', 'B'),
(9, 'Oliver', 'Taylor', 12, 'M', 7, 90, 93, 89, 160, 'Mr. Johnson', 'C'),
(10, 'Ava', 'Jackson', 15, 'F', 10, 87, 90, 92, 155, 'Mr. Lee', 'D'),
(11, 'Lucas', 'Martin', 13, 'M', 7, 78, 85, 80, 170, 'Mr. Johnson', 'C'),
(12, 'Ella', 'White', 16, 'F', 10, 82, 89, 88, 160, 'Mr. Lee', 'D');


-------------------------------------------------------------------------------------------------------------

-- Q1. Write a query to fetch all student details in the dataset.

SELECT * FROM students;

-- Q2. Retrieve the names of students who have 180 days of attendance.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, ATTENDANCE FROM students
WHERE attendance = 180;

-- Q3. Get a list of students who scored more than 90 in Math.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, MATH_SCORE AS MATH_MARKS FROM students
WHERE MATH_SCORE > 90;

-- Q4. Calculate the average score of all students in Reading.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, AVG(READING_SCORE) AS AVERAGE_SCORE FROM students
GROUP BY FULL_NAME
HAVING AVG(READING_SCORE);

-- Q5. Count how many students are there in each grade.

SELECT GRADE,COUNT(CONCAT(FIRST_NAME," ",LAST_NAME)) AS TOTAL_STUDENTS FROM students
GROUP BY GRADE;

-- Q6. Find the students who scored above the average Math score.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, MATH_SCORE FROM students
WHERE MATH_SCORE > (SELECT AVG(MATH_SCORE) FROM students);

-- Q7. Fetch the details of the top 3 students based on their Writing score.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME), WRITING_SCORE FROM students
ORDER BY WRITING_SCORE DESC
LIMIT 3;

-- Q8. Count how many male and female students are there in each class section.

SELECT GENDER, CLASS_SECTION, COUNT(*) AS STUDENT_COUNT FROM students
GROUP BY GENDER, CLASS_SECTION;

-- Q9. List the students who scored below 40 in Math, Reading, or Writing.

SELECT CONCAT(FIRST_NAME," ", LAST_NAME) AS STUDENT_NAME, MATH_SCORE, READING_SCORE, WRITING_SCORE FROM STUDENTS
WHERE ((MATH_SCORE < 40) & (READING_SCORE < 40) & (WRITING_SCORE < 40 ));

-- Q10. Calculate the average attendance for each class section.

SELECT CLASS_SECTION, AVG(ATTENDANCE) AS AVERAGE_ATTENDENCE FROM students
GROUP BY CLASS_SECTION;

-- Q11. For each class section, find the student with the highest combined score in Math, Reading, and Writing.

SLECT CLASS_SECTION, (MATH_SCORE+READING_SCORE+WRITING_SCORE) AS TOTAL_SCORE FROM students
WHERE (CLASS_SECTION, (MATH_SCORE+READING_SCORE+WRITING_SCORE)) IN 
(SELECT CLASS_SECTION, MAX((MATH_SCORE+READING_SCORE+WRITING_SCORE) FROM students
GROUP BY CLASS_SECTION);

-- Q12. Calculate the average scores in Math, Reading, and Writing for each gender.

SELECT GENDER, AVG(MATH_SCORE) AS MATH_SCORE, AVG(READING_SCORE) AS READING_SCORE, AVG(WRITING_SCORE) AS WRITING_SCORE
FROM students
GROUP BY GENDER;

-- Q13. Find students who scored 10% or more above their class section's average Math score.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, CLASS_SECTION, MATH_SCORE FROM students S
WHERE MATH_SCORE > 1.10 * (SELECT AVG(MATH_SCORE) FROM students WHERE CLASS_SECTION = S.class_section);

-- Q14. Rank students by their total score across all subjects (Math, Reading, Writing) in descending order.

SELECT CONCAT(FIRST_NAME," ",LAST_NAME) AS FULL_NAME, (MATH_SCORE+READING_SCORE+WRITING_SCORE) AS TOTAL_SCORE 
FROM students
ORDER BY TOTAL_SCORE DESC
LIMIT 3;

-- Q15. Find out which class teacher's students have the highest average total score across all subjects.

SELECT CLASS_TEACHER, AVG(MATH_SCORE+READING_SCORE+WRITING_SCORE) AS TOTAL_SCORE FROM students
GROUP BY CLASS_TEACHER
ORDER BY TOTAL_SCORE DESC
LIMIT 1;