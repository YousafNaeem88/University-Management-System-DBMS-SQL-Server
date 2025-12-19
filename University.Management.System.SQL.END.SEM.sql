
   ---------CREATE DATABASE------------

CREATE DATABASE universitydb;
USE universitydb;

  ---------------- CREATE TABLES --------------

CREATE TABLE department (
    d_id INT PRIMARY KEY,
    d_name VARCHAR(100)
);

CREATE TABLE student (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(100),
    s_email VARCHAR(100),
    s_age INT not null,
    d_id INT,
    c_id INT,
    s_marks INT not null
);

CREATE TABLE professor (
    p_id INT PRIMARY KEY,
    p_name VARCHAR(100),
    p_email VARCHAR(100),
    p_number VARCHAR(20),
    p_address VARCHAR(200),
    d_id INT,
    c_id INT
);

CREATE TABLE course (
    c_id INT PRIMARY KEY,
    c_name VARCHAR(100) not null,
    c_creditHour INT not null,
    p_id INT,
    s_id INT,
    d_id INT
);

CREATE TABLE studentcourse (
    s_c_id INT PRIMARY KEY,
    s_id INT,
    c_id INT
);

CREATE TABLE professorcourse (
    p_c_id INT PRIMARY KEY,
    p_id INT,
    c_id INT
);


-------------- ADD FOREIGN KEYS ---------------


ALTER TABLE student
ADD FOREIGN KEY (d_id) REFERENCES department(d_id);

ALTER TABLE student
ADD FOREIGN KEY (c_id) REFERENCES course(c_id);

ALTER TABLE professor
ADD FOREIGN KEY (d_id) REFERENCES department(d_id);

ALTER TABLE professor
ADD FOREIGN KEY (c_id) REFERENCES course(c_id);

ALTER TABLE course
ADD FOREIGN KEY (p_id) REFERENCES professor(p_id);

ALTER TABLE course
ADD FOREIGN KEY (s_id) REFERENCES student(s_id);

ALTER TABLE course
ADD FOREIGN KEY (d_id) REFERENCES department(d_id);

ALTER TABLE studentcourse
ADD FOREIGN KEY (s_id) REFERENCES student(s_id);

ALTER TABLE studentcourse
ADD FOREIGN KEY (c_id) REFERENCES course(c_id);

ALTER TABLE professorcourse
ADD FOREIGN KEY (p_id) REFERENCES professor(p_id);

ALTER TABLE professorcourse
ADD FOREIGN KEY (c_id) REFERENCES course(c_id);

---------- DEMONSTRATING OPERATIONS ---------------------

-- ADD
ALTER TABLE student
ADD s_phone VARCHAR(15);

-- MODIFY
ALTER TABLE professor
ALTER COLUMN p_number VARCHAR(25);

-- RENAME (SQL SERVER WAY)
EXEC sp_rename 'course.c_creditHour', 'credit_hours', 'COLUMN';

-- DROP
ALTER TABLE student
DROP COLUMN s_age;

ALTER TABLE student
ADD s_age int not null;


-------------details insertion----------

----departments---
INSERT INTO department VALUES
(1, 'Computer Science'),
(2, 'Business Administration'),
(3, 'Electrical Engineering'),
(4, 'Mathematics'),
(5, 'Physics');

-----students----
INSERT INTO student (s_id, s_name, s_email, s_age, d_id, c_id, s_phone, s_marks)
VALUES
(101, 'Ali Khan', 'ali@gmail.com', 20, 1, NULL, '03001234567', 90),
(102, 'Ahmed Raza', 'ahmed@gmail.com', 21, 1, NULL, '03011234567', 80),
(103, 'Sara Malik', 'sara@gmail.com', 22, 2, NULL, '03021234567', 70),
(104, 'Ayesha Noor', 'ayesha@gmail.com', 20, 3, NULL, '03031234567', 60),
(105, 'Usman Ali', 'usman@gmail.com', 23, 4, NULL, '03041234567', 55);

------professor-----
INSERT INTO professor VALUES
(201, 'Dr. Ahmed', 'ahmed@uni.com', '03011234567', 'Lahore', 1, NULL),
(202, 'Dr. Bilal', 'bilal@uni.com', '03021234567', 'Islamabad', 2, NULL),
(203, 'Dr. Sana', 'sana@uni.com', '03031234567', 'Karachi', 3, NULL),
(204, 'Dr. Kamran', 'kamran@uni.com', '03041234567', 'Peshawar', 4, NULL),
(205, 'Dr. Hina', 'hina@uni.com', '03013303388', 'Quetta', 5, NULL);

------courses--------
INSERT INTO course VALUES
(301, 'Database Systems', 3, 201, 101, 1),
(302, 'Marketing', 3, 202, 103, 2),
(303, 'Circuits', 4, 203, 104, 3),
(304, 'Calculus', 3, 204, 105, 4),
(305, 'Quantum Physics', 4, 205, 102, 5);

-------studentcourse-----
INSERT INTO studentcourse VALUES
(401, 101, 301),
(402, 102, 305),
(403, 103, 302),
(404, 104, 303),
(405, 105, 304);

-------professorcourse-----
INSERT INTO professorcourse VALUES
(501, 201, 301),
(502, 202, 302),
(503, 203, 303),
(504, 204, 304),
(505, 205, 305);

--------query (update,delete,like)---------

----update----
UPDATE student
SET s_email = 'ali.khan@uni.com'
WHERE s_id = 101;

----delete-----
DELETE FROM studentcourse
WHERE s_c_id = 405;

----like-----
SELECT * 
FROM student
WHERE s_name LIKE 'A%';

-------update student's c_id----------
UPDATE student
SET c_id = 301
WHERE s_id = 101;

UPDATE student
SET c_id = 305
WHERE s_id = 102;

UPDATE student
SET c_id = 302
WHERE s_id = 103;

UPDATE student
SET c_id = 303
WHERE s_id = 104;

UPDATE student
SET c_id = 304
WHERE s_id = 105;

-------update professor's c_id------
UPDATE professor
SET c_id = 301
WHERE p_id = 201;

UPDATE professor
SET c_id = 302
WHERE p_id = 202;

UPDATE professor
SET c_id = 303
WHERE p_id = 203;

UPDATE professor
SET c_id = 304
WHERE p_id = 204;

UPDATE professor
SET c_id = 305
WHERE p_id = 205;

-----select statement-----
SELECT * 
FROM student;

SELECT s_name, s_email
FROM student;

SELECT c_id, c_name
FROM course;

-----order by statement------
SELECT s_id, s_name, s_age
FROM student
ORDER BY s_age ASC;

SELECT p_id, p_name
FROM professor
ORDER BY p_name DESC;

SELECT c_id, c_name, credit_hours
FROM course
ORDER BY credit_hours;

-----top statement-------
SELECT TOP 3 s_id, s_name
FROM student;

SELECT TOP 2 p_id, p_name
FROM professor;

SELECT TOP 4 c_id, c_name, credit_hours
FROM course
ORDER BY credit_hours DESC;

-----subqueries using in------
SELECT s_id, s_name
FROM student
WHERE c_id IN (
    SELECT c_id
    FROM course
    WHERE d_id = 2
);

SELECT p_id, p_name
FROM professor
WHERE c_id IN (
    SELECT c_id
    FROM course
    WHERE credit_hours > 3
);

SELECT s_id, s_name
FROM student
WHERE s_id IN (
    SELECT s_id
    FROM studentcourse
);

-----subqueries using NOT IN------
SELECT s_id, s_name
FROM student
WHERE s_id NOT IN (
    SELECT s_id
    FROM studentcourse
);

SELECT p_id, p_name
FROM professor
WHERE p_id NOT IN (
    SELECT p_id
    FROM professorcourse
);

SELECT c_id, c_name
FROM course
WHERE c_id

NOT IN (
    SELECT c_id
    FROM studentcourse
);

-----subqueries using exist------
SELECT s_id, s_name
FROM student s
WHERE EXISTS (
    SELECT 1
    FROM studentcourse sc
    WHERE sc.s_id = s.s_id
);

SELECT p_id, p_name
FROM professor p
WHERE EXISTS (
    SELECT 1
    FROM professorcourse pc
    WHERE pc.p_id = p.p_id
);

-----joins for student------
SELECT s.s_id, s.s_name, c.c_name
FROM student s
INNER JOIN course c
ON s.c_id = c.c_id;

SELECT s.s_id, s.s_name, c.c_name
FROM student s
LEFT JOIN course c
ON s.c_id = c.c_id;

SELECT s.s_name, c.c_name
FROM student s
RIGHT JOIN course c
ON s.c_id = c.c_id;

--cross join--
SELECT s.s_name, c.c_name
FROM student s,course c;

------joins for professor-------
SELECT p.p_name, d.d_name
FROM professor p
JOIN department d
ON p.d_id = d.d_id;

SELECT p.p_name, c.c_name
FROM professor p
LEFT JOIN course c
ON p.c_id = c.c_id;

SELECT p.p_name, c.c_name
FROM professor p
FULL OUTER JOIN course c
ON p.c_id = c.c_id;

---EQUI JOIN---
SELECT 
    p.p_name,
    d.d_name 
FROM professor p, department d
WHERE p.d_id = d.d_id;


------joins for courses-----
SELECT c.c_name, d.d_name
FROM course c
INNER JOIN department d
ON c.d_id = d.d_id;

SELECT c.c_name, d.d_name
FROM course c
RIGHT JOIN department d
ON c.d_id = d.d_id;

SELECT c.c_name, s.s_name
FROM course c
FULL OUTER JOIN student s
ON c.s_id = s.s_id;

SELECT s.s_name, c.c_name
FROM student s
INNER JOIN course c
ON s.c_id = c.c_id;

------select statement-------
select*from department
select*from student
select*from professor
select*from course

------------------------------- Functions ----------------------------------
  ------------ SCALAR FUNCTIONS ----------------

----- Student Age Group ------
CREATE FUNCTION fn_GetStudentAgeGroup (@Age INT)
RETURNS VARCHAR(15)
AS
BEGIN
    DECLARE @Category VARCHAR(15)

    IF @Age < 18
        SET @Category = 'Child'
    ELSE IF @Age < 22
        SET @Category = 'Young Adult'
    ELSE
        SET @Category = 'Adult'

    RETURN @Category
END
SELECT s_name, s_age, dbo.fn_GetStudentAgeGroup(s_age) AS MATURITY FROM student;


----- Student Grade Plus/Minus -----
CREATE FUNCTION fn_GetStudentGradePlusMinus (@Marks INT)
RETURNS VARCHAR(2)
AS
BEGIN
    DECLARE @Grade VARCHAR(2)

    IF @Marks >= 90
        SET @Grade = 'A+'
    ELSE IF @Marks >= 80
        SET @Grade = 'A'
    ELSE IF @Marks >= 70
        SET @Grade = 'B'
    ELSE
        SET @Grade = 'C'

    RETURN @Grade
END
SELECT s_name, dbo.fn_GetStudentGradePlusMinus(s_marks) AS GRADE FROM student;

----- Get Maximum Student Age in a Department -----
CREATE FUNCTION fn_GetMaxStudentAgeByDept (@DeptID INT)
RETURNS INT
AS
BEGIN
    DECLARE @MaxAge INT

    SELECT @MaxAge = MAX(s_age)
    FROM student
    WHERE d_id = @DeptID

    RETURN @MaxAge
END

SELECT d_name, dbo.fn_GetMaxStudentAgeByDept(d_id) AS MaxAge
FROM department;


  -------------- INLINE TABLE-VALUED FUNCTIONS ----------------

----- Students with Department Name -----
CREATE FUNCTION fn_GetStudentsWithDepartment()
RETURNS TABLE
AS
RETURN
(
    SELECT s.s_id, s.s_name, d.d_name
    FROM student s
    JOIN department d ON s.d_id = d.d_id
);

SELECT * FROM dbo.fn_GetStudentsWithDepartment();


----- Professors with Department -----
CREATE FUNCTION fn_GetProfessorsDetails()
RETURNS TABLE
AS
RETURN
(
    SELECT p.p_id, p.p_name, p.p_email, p.p_number, d.d_name AS DepartmentName
    FROM professor p
    JOIN department d ON p.d_id = d.d_id
);

SELECT * FROM dbo.fn_GetProfessorsDetails();


----- Courses with Credit Hours -----
CREATE FUNCTION fn_GetCoursesWithCredits()
RETURNS TABLE
AS
RETURN
(
    SELECT c_id, c_name, credit_hours
    FROM course
);

SELECT * FROM dbo.fn_GetCoursesWithCredits();

----- Students by Department ID -----
CREATE FUNCTION fn_GetStudentsByDept (@DeptID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT s_id AS StudentID, s_name AS StudentName
    FROM student
    WHERE d_id = @DeptID
);
GO

SELECT * FROM dbo.fn_GetStudentsByDept(1);


----- Students by Course ID -----
CREATE FUNCTION fn_GetStudentsByCourse (@CourseID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT s_id AS StudentID, s_name AS StudentName
    FROM student
    WHERE c_id = @CourseID
);
GO

SELECT * FROM dbo.fn_GetStudentsByCourse(302);

----- Professors by Department ID -----
CREATE FUNCTION fn_GetProfessorsByDept (@DeptID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT p_id AS ProfessorID, p_name AS ProfessorName
    FROM professor
    WHERE d_id = @DeptID
);
GO

SELECT * FROM dbo.fn_GetProfessorsByDept(3);


   ---------------STORE PROCEDURES-----------------

   ---------GET ALL STUDENTS----------
CREATE PROCEDURE sp_GetAllStudents
AS
BEGIN
    SELECT * FROM student
END
GO

EXEC sp_GetAllStudents;


   -------UPDATE STUDENT COURSE-------
CREATE PROCEDURE sp_UpdateStudentCourse
    @s_id INT,
    @c_id INT
AS
BEGIN
    UPDATE student
    SET c_id = @c_id
    WHERE s_id = @s_id
END
GO

EXEC sp_UpdateStudentCourse @s_id=101,@c_id=301;

   --------DELETE STUDENT-----------
CREATE PROCEDURE sp_DeleteStudent
    @s_id INT
AS
BEGIN
    DELETE FROM student
    WHERE s_id = @s_id
END
GO
EXEC sp_DeleteStudent @s_id=301;


  ----------INSERT PROFESSOR----------
CREATE PROCEDURE sp_AddProfessor
    @p_id INT,
    @p_name VARCHAR(100),
    @p_email VARCHAR(100),
    @p_number VARCHAR(25),
    @p_address VARCHAR(200),
    @d_id INT,
    @c_id INT
AS
BEGIN
    INSERT INTO professor
    VALUES (@p_id, @p_name, @p_email, @p_number, @p_address, @d_id, @c_id)
END
GO

EXEC sp_AddProfessor 206, 'Dr. Ali', 'ali@uni.com', '03001112233', 'Lahore', 1, NULL;

select*from professor

   --------UPDATE PROFESSOR DEPARTMENT---------
CREATE PROCEDURE sp_UpdateProfessorDept
@p_id INT,
@d_id INT
AS
BEGIN
UPDATE professor
SET d_id = @d_id
WHERE p_id = @p_id;
END
GO

EXEC sp_UpdateProfessorDept @p_id=201, @d_id=2;

select*from professor

--------DELETE PROFESSOR-----------
CREATE PROCEDURE sp_DeleteProfessor
    @p_id INT
AS
BEGIN
    DELETE FROM professor
    WHERE p_id = @p_id
END
GO

EXEC sp_DeleteProfessor @p_id=206;

select*from professor


   ---------PROFESSOR ADDRESS---------
CREATE PROCEDURE sp_ProfessorAddress
    @Address VARCHAR(30)
AS
BEGIN
    SELECT p_id, p_name, p_address
    FROM professor
    WHERE p_address=@Address;
END;
    
    EXEC sp_ProfessorAddress @Address = 'Lahore';


   --------GET STUDENTS BY DEPARTMENT---------
CREATE PROCEDURE sp_GetStudentsByDepartment
    @d_id INT
AS
BEGIN
    SELECT s_id, s_name, s_email
    FROM student
    WHERE d_id = @d_id
END
GO

    EXEC sp_GetStudentsByDepartment @d_id = 1;


   --------GET PROFESSORS WITH COURSES-----------
CREATE PROCEDURE sp_GetProfessorsWithCourses
AS
BEGIN
    SELECT p.p_name, c.c_name
    FROM professor p
    JOIN course c ON p.c_id = c.c_id
END
GO
    EXEC sp_GetProfessorsWithCourses;


    ------------------TRIGGERS----------------------
    ---after insert(student)---
    CREATE TRIGGER trg_AfterInsertStudent
ON student
AFTER INSERT
AS
BEGIN
    PRINT 'New student record inserted successfully.'
END;
GO

---AFTER UPDATE (Student's Course Change)---
CREATE TRIGGER trg_AfterUpdateStudentCourse
ON student
AFTER UPDATE
AS
BEGIN
    IF UPDATE(c_id)
        PRINT 'Student course updated successfully.'
END;
GO


---AFTER DELETE (Student)---
CREATE TRIGGER trg_AfterDeleteStudent
ON student
AFTER DELETE
AS
BEGIN
    PRINT 'Student record deleted.'
END;
GO

---Update Department Name)---
CREATE TRIGGER trg_AfterUpdateDepartmentName
ON department
AFTER UPDATE
AS
BEGIN
    IF UPDATE(d_name)
    BEGIN
        PRINT 'Department name updated successfully.'
    END
END;
GO

---AFTER INSERT (Professor)---
CREATE TRIGGER trg_AfterInsertProfessor
ON professor
AFTER INSERT
AS
BEGIN
    PRINT 'Professor added successfully.'
END;
GO

---AFTER UPDATE (Professor Phone Number)---
CREATE TRIGGER trg_AfterUpdateProfessorPhone
ON professor
AFTER UPDATE
AS
BEGIN
    IF UPDATE(p_number)
        PRINT 'Professor contact number updated.'
END;
GO

---AFTER INSERT (Course)---
CREATE TRIGGER trg_AfterInsertCourse
ON course
AFTER INSERT
AS
BEGIN
    PRINT 'New course added.'
END;
GO

---AFTER INSERT (StudentCourse)---
CREATE TRIGGER trg_AfterInsertStudentCourse
ON studentcourse
AFTER INSERT
AS
BEGIN
    PRINT 'Student enrolled in course.'
END;
GO


---AFTER INSERT (ProfessorCourse)---
CREATE TRIGGER trg_AfterInsertProfessorCourse
ON professorcourse
AFTER INSERT
AS
BEGIN
    PRINT 'Professor assigned to course.'
END;
GO

