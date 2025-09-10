-- drop old database & create database
DROP DATABASE IF EXISTS torrens;

CREATE DATABASE torrens;

USE torrens;
-- drop old tables if any
DROP TABLE IF EXISTS BlackBoard;
DROP TABLE IF EXISTS SC;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS `Program Director`;
DROP TABLE IF EXISTS `Academic Services Officer`;
DROP TABLE IF EXISTS `Learning Facilitator`;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Campus;
-- create tables
CREATE TABLE Campus (
    CampusID INT PRIMARY KEY,
    CampusLocation VARCHAR(255)
);

CREATE TABLE `Learning Facilitator` (
    LFID INT PRIMARY KEY,
    LastName VARCHAR(255),
    GivenName VARCHAR(255),
    Email VARCHAR(255),
    CampusID INT,
    FOREIGN KEY (CampusID) REFERENCES Campus(CampusID)
);

CREATE TABLE `Program Director` (
    PDID INT PRIMARY KEY,
    Name VARCHAR(255),
    ProgramName VARCHAR(255),
    CampusID INT,
    FOREIGN KEY (CampusID) REFERENCES Campus(CampusID)
);

CREATE TABLE `Academic Services Officer` (
    ASOID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255),
    CampusID INT,
    FOREIGN KEY (CampusID) REFERENCES Campus(CampusID)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(255),
    Assessment01Date DATE,
    Assessment02Date DATE,
    Assessment03Date DATE,
    LFID INT,
    CampusID INT,
    PDID INT,
    FOREIGN KEY (LFID) REFERENCES `Learning Facilitator`(LFID),
    FOREIGN KEY (CampusID) REFERENCES Campus(CampusID),
    FOREIGN KEY (PDID) REFERENCES `Program Director`(PDID)
);

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    LastName VARCHAR(255),
    GivenName VARCHAR(255),
    Gender VARCHAR(10),
    Email VARCHAR(255),
    CampusID INT,
    CourseID INT,
    FOREIGN KEY (CampusID) REFERENCES Campus(CampusID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE SC (
    SCID INT PRIMARY KEY,
    SentDate DATE,
    DenyDate DATE,
    Statement VARCHAR(255),
    AssessmentNum INT,
    LFID INT,
    CourseID INT,
    StudentID INT,
    PDID INT,
    FOREIGN KEY (LFID) REFERENCES `Learning Facilitator`(LFID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (PDID) REFERENCES `Program Director`(PDID)
);

CREATE TABLE BlackBoard (
    BBID INT PRIMARY KEY,
    RequestDate DATE,
    SCID INT,
    FOREIGN KEY (SCID) REFERENCES SC(SCID)
);

-- insert data in tables
INSERT INTO Campus (CampusID, CampusLocation) VALUES
(1, 'Sydney'),
(2, 'Melbourne'),
(3, 'Adelaide');



INSERT INTO `Learning Facilitator` (LFID, LastName, GivenName, Email, CampusID)
VALUES 
  (1, 'Patel', 'Rajesh', 'rpatel@torrens.edu.au', 1),
  (2, 'Wong', 'Jasmine', 'jwong@torrens.edu.au', 2),
  (3, 'Kim', 'Jin-Soo', 'jkim@torrens.edu.au', 3),
  (4, 'Nguyen', 'Thanh', 'tnguyen@torrens.edu.au', 1),
  (5, 'Garcia', 'Alejandro', 'agarcia@torrens.edu.au', 1),
  (6, 'Singh', 'Arun', 'asingh@torrens.edu.au', 2),
  (7, 'Abdullah', 'Nur', 'nabdullah@torrens.edu.au', 3),
  (8, 'Fernandes', 'Sofia', 'sfernandes@torrens.edu.au', 2),
  (9, 'Ali', 'Madiha', 'mali@torrens.edu.au', 1),
  (10, 'Lee', 'Yoon-Jung', 'ylee@torrens.edu.au', 2),
  (11, 'Chowdhury', 'Rahul', 'rchowdhury@torrens.edu.au', 3),
  (12, 'Kapoor', 'Anjali', 'akapoor@torrens.edu.au', 3),
  (13, 'Mak', 'Jia-Hui', 'jmak@torrens.edu.au', 1),
  (14, 'Kamara', 'Fatima', 'fkamara@torrens.edu.au', 2),
  (15, 'Ouedraogo', 'Seydou', 'souedraogo@torrens.edu.au', 3);


INSERT INTO `Program Director` (PDID, Name, ProgramName, CampusID) VALUES
    (1, 'Jane Doe', 'MBA', 1),
    (2, 'Bob Johnson', 'MBIS', 2),
    (3, 'Emily Chen', 'MIT', 1),
    (4, 'Mohammed Ahmed', 'MBA', 3),
    (5, 'Samantha Lee', 'MBIS', 2),
    (6, 'Carlos Hernandez', 'MIT', 1),
    (7, 'Aisha Malik', 'MBA', 3);

INSERT INTO Course (CourseID, CourseName, Assessment01Date, Assessment02Date, Assessment03Date, LFID, CampusID, PDID)
VALUES 
    (1, 'Introduction to Computer Science', '2023-05-15', '2023-06-15', '2023-07-15', 11, 2, 7),
    (2, 'Data Structures and Algorithms', '2023-06-20', '2023-07-20', '2023-08-20', 6, 3, 2),
    (3, 'Database Systems', '2023-07-15', '2023-08-15', '2023-09-15', 10, 1, 3),
    (4, 'Corporate Finance', '2023-05-20', '2023-06-20', '2023-07-20', 4, 1, 7),
    (5, 'Marketing Management', '2023-06-25', '2023-07-25', '2023-08-25', 3, 3, 2),
    (6, 'Organizational Behavior', '2023-07-10', '2023-08-10', '2023-09-10', 13, 2, 6),
    (7, 'Introduction to Artificial Intelligence', '2023-06-01', '2023-07-01', '2023-08-01', 7, 1, 4),
    (8, 'Machine Learning', '2023-07-05', '2023-08-05', '2023-09-05', 1, 2, 1),
    (9, 'Deep Learning', '2023-08-10', '2023-09-10', '2023-10-10', 9, 3, 6),
    (10, 'International Business', '2023-06-15', '2023-07-15', '2023-08-15', 2, 1, 4),
    (11, 'Project Management', '2023-07-20', '2023-08-20', '2023-09-20', 15, 2, 7),
    (12, 'Entrepreneurship', '2023-08-25', '2023-09-25', '2023-10-25', 5, 3, 5),
    (13, 'Introduction to Psychology', '2023-05-25', '2023-06-25', '2023-07-25', 14, 1, 1),
    (14, 'Cognitive Psychology', '2023-06-30', '2023-07-30', '2023-08-30', 8, 2, 6),
    (15, 'Abnormal Psychology', '2023-07-20', '2023-08-20', '2023-09-20', 12, 3, 3),
    (16, 'Introduction to Ethics', '2023-08-01', '2023-09-01', '2023-10-01', 4, 1, 5);


INSERT INTO Student (StudentID, LastName, GivenName, Gender, Email, CampusID, CourseID)
VALUES 
(1, 'Nguyen', 'Hoa', 'F', 'hoa.nguyen@example.com', 1, 1),
(2, 'Wang', 'Li', 'F', 'li.wang@example.com', 2, 2),
(3, 'Gupta', 'Amit', 'M', 'amit.gupta@example.com', 3, 3),
(4, 'Sanchez', 'Maria', 'F', 'maria.sanchez@example.com', 1, 4),
(5, 'Ndiaye', 'Fatou', 'F', 'fatou.ndiaye@example.com', 1, 5),
(6, 'Zhang', 'Jie', 'M', 'jie.zhang@example.com', 2, 6),
(7, 'Kumar', 'Raj', 'M', 'raj.kumar@example.com', 3, 7),
(8, 'Santos', 'Pedro', 'M', 'pedro.santos@example.com', 2, 8),
(9, 'Diallo', 'Awa', 'F', 'awa.diallo@example.com', 1, 9),
(10, 'Lopez', 'Juan', 'M', 'juan.lopez@example.com', 2, 10),
(11, 'Chowdhury', 'Aisha', 'F', 'aisha.chowdhury@example.com', 3, 11),
(12, 'Ahmed', 'Rashid', 'M', 'rashid.ahmed@example.com', 3, 12),
(13, 'Dubois', 'Sophie', 'F', 'sophie.dubois@example.com', 1, 13),
(14, 'Chen', 'Yun', 'F', 'yun.chen@example.com', 2, 14),
(15, 'Okeke', 'Emeka', 'M', 'emeka.okeke@example.com', 3, 15),
(16, 'Ramirez', 'Sofia', 'F', 'sofia.ramirez@example.com', 1, 16),
(17, 'Gao', 'Jing', 'M', 'jing.gao@example.com', 1, 1),
(18, 'Patel', 'Ravi', 'M', 'ravi.patel@example.com', 2, 2),
(19, 'Makhlouf', 'Hassan', 'M', 'hassan.makhlouf@example.com', 3, 3),
(20, 'Fernandez', 'Ana', 'F', 'ana.fernandez@example.com', 2, 4),
(21, 'Sharma', 'Neha', 'F', 'neha.sharma@example.com', 1, 5),
(22, 'Li', 'Tian', 'M', 'tian.li@example.com', 2, 6),
(23, 'Gomez', 'Miguel', 'M', 'miguel.gomez@example.com', 3, 2),
(24, 'Sekou', 'Amina', 'F', 'amina.sekou@example.com', 3, 7),
(25, 'Gomez', 'Maria', 'F', 'gomez.maria@gmail.com', 1, 5),
(26, 'Silva', 'Pedro', 'M', 'silva.pedro@gmail.com', 2, 1),
(27, 'Bello', 'Ana', 'F', 'bello.ana@gmail.com', 1, 8),
(28, 'Sharma', 'Neha', 'F', 'sharma.neha@gmail.com', 3, 12),
(29, 'Perez', 'Juan', 'M', 'perez.juan@gmail.com', 1, 13),
(30, 'Chen', 'Wei', 'M', 'chen.wei@gmail.com', 2, 12),
(31, 'Makinde', 'Oluwafemi', 'M', 'makinde.oluafemi@gmail.com', 3, 14),
(32, 'Nkosi', 'Thabo', 'M', 'nkosi.thabo@gmail.com', 1, 16),
(33, 'Ng', 'Mei-ling', 'F', 'ng.meiling@gmail.com', 2, 12),
(34, 'Lopez', 'Juan', 'M', 'lopez.juan@gmail.com', 1, 11),
(35, 'Wang', 'Wei', 'M', 'wang.wei@gmail.com', 3, 3),
(36, 'Diop', 'Fatoumata', 'F', 'diop.fatoumata@gmail.com', 1, 1),
(37, 'Das', 'Arundhati', 'F', 'das.arundhati@gmail.com', 2, 7),
(38, 'Martinez', 'Luis', 'M', 'martinez.luis@gmail.com', 1, 8),
(39, 'Adebayo', 'Tolu', 'M', 'adebayo.tolu@gmail.com', 3, 15),
(40, 'Chu', 'Yan', 'F', 'chu.yan@gmail.com', 1, 13),
(41, 'Vargas', 'Alejandro', 'M', 'vargas.alejandro@gmail.com', 2, 6),
(42, 'Dubois', 'Emilie', 'F', 'dubois.emilie@gmail.com', 1, 5),
(43, 'Mukherjee', 'Debjani', 'F', 'mukherjee.debjani@gmail.com', 3, 4),
(44, 'Sinha', 'Amitabh', 'M', 'sinha.amitabh@gmail.com', 3, 3),
(45, 'Lee', 'Soo-jung', 'F', 'lee.soojung@gmail.com', 1, 9)
;

INSERT INTO SC (SCID, SentDate, DenyDate, Statement, AssessmentNum, LFID, CourseID, StudentID, PDID)
VALUES 
    (1, '2023-05-01', '2023-05-05', 'The student did not submit the assessment', 1, 1, 1, 1, 1),
    (2, '2023-05-01', '2023-05-05', 'The student submitted an incomplete assessment', 1, 1, 1, 2, 1),
    (3, '2023-05-02', NULL, 'The student submitted a well-written assessment', 1, 2, 2, 3, 2),
    (4, '2023-05-03', NULL, 'The student\'s assessment was plagiarized', 2, 3, 2, 4, 3),
    (5, '2023-05-04', NULL, 'The student\'s assessment was of average quality', 2, 4, 3, 5, 4),
    (6, '2023-05-05', NULL, 'The student submitted the assessment on time', 3, 5, 3, 6, 5),
    (7, '2023-05-06', NULL, 'The student did not follow the assessment instructions', 3, 6,4, 7, 6),
    (8, '2023-05-07', '2023-05-10', 'The student failed to submit the assessment on time', 3, 7, 8, 8, 7),
    (9, '2023-05-08', NULL, 'The student submitted an excellent assessment', 2, 8, 9, 9, 1),
    (10, '2023-05-09', NULL, 'The student\'s assessment was poorly written', 1, 9, 10, 10, 2),
    (11, '2023-05-10', NULL, 'The student submitted a creative assessment', 2, 10, 11, 11, 3),
    (12, '2023-05-11', NULL, 'The student\'s assessment was well-organized', 1, 11, 12, 12, 4),
    (13, '2023-05-12', '2023-05-14', 'The student submitted the assessment after the deadline', 3, 12, 13, 13, 5),
    (14, '2023-05-13', NULL, 'The student\'s assessment was very detailed', 1, 13, 14, 14, 6),
    (15, '2023-05-14', NULL, 'The student\'s assessment was missing some key information', 2, 14, 15, 15, 7),
    (16, '2023-05-15', NULL, 'The student\'s assessment was very well-researched', 3, 15, 6, 16, 1),
    (17, '2023-05-16', NULL, 'The student\'s assessment was not relevant to the assignment', 1, 1, 5, 16,2);


INSERT INTO BlackBoard (BBID, RequestDate, SCID)
VALUES 
    (1, '2023-05-05', 1),
    (2, '2023-05-06', 2),
    (3, '2023-05-07', 3),
    (4, '2023-05-08', 4),
    (5, '2023-05-09', 5),
    (6, '2023-05-10', 6),
    (7, '2023-05-11', 7),
    (8, '2023-05-12', 8),
    (9, '2023-05-13', 9),
    (10, '2023-05-14', 10),
    (11, '2023-05-15', 11),
    (12, '2023-05-16', 12),
    (13, '2023-05-17', 13),
    (14, '2023-05-18', 14),
    (15, '2023-05-19', 15),
    (16, '2023-05-20', 16),
    (17, '2023-05-21', 17);

-- query1 example for select
SELECT LastName, GivenName, Gender, CampusLocation 
FROM Student 
JOIN Campus ON Student.CampusID = Campus.CampusID 
WHERE CampusLocation = 'Adelaide';

-- query2 example for Group by
SELECT CampusLocation, COUNT(*) as NumStudents 
FROM Student 
JOIN Campus ON Student.CampusID = Campus.CampusID 
GROUP BY CampusLocation;
 
-- query3 example for JOIN query Nested query
SELECT LastName, GivenName, ProgramName, CampusLocation 
FROM Student 
JOIN Course ON Student.CourseID = Course.CourseID 
JOIN `Program Director` ON Course.PDID = `Program Director`.PDID 
JOIN Campus ON Student.CampusID = Campus.CampusID;
SELECT CampusLocation, AVG(AssessmentNum) as AvgAssessment 
FROM (
    SELECT CourseID, COUNT(*) as AssessmentNum 
    FROM SC 
    GROUP BY CourseID
) as Assessments 
JOIN Course ON Assessments.CourseID = Course.CourseID 
JOIN Campus ON Course.CampusID = Campus.CampusID 
GROUP BY CampusLocation;




