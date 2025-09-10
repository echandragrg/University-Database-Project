Torrens University Database Project
📌 Overview

This project designs and implements a relational database system for managing academic operations at Torrens University.
It includes entities such as Campuses, Students, Courses, Learning Facilitators, Program Directors, Academic Services Officers, Special Consideration Requests (SC), and Blackboard Requests.

The database is structured to support operations such as student enrollment, course management, staff allocation, and assessment tracking.

🛠️ Features

Database Creation & Initialization

Drops the old torrens database (if it exists) and creates a fresh one.

Creates normalized tables with primary and foreign keys.

Entities & Relationships

Campus – Stores campus details.

Learning Facilitator (LF) – Assigned to courses.

Program Director (PD) – Oversees academic programs.

Academic Services Officer (ASO) – Provides admin support.

Course – Contains assessments and is linked to LF and PD.

Student – Enrolled in courses at a campus.

SC (Special Consideration) – Tracks student assessment issues and outcomes.

BlackBoard – Stores requests linked to SC.

Data Population

Sample data for all entities (staff, courses, students, SC, Blackboard).

Example Queries

Query 1: Retrieve students by campus.

Query 2: Count students per campus (GROUP BY).

Query 3: Nested and join queries combining Student, Course, Program Director, and Campus.

Query 4: Calculate average assessment numbers by campus.

🗂️ File Structure
├── torrens.sql        # Main SQL script (schema + inserts + queries)
├── README.md          # Documentation (this file)

🚀 How to Run

Open MySQL Workbench (or any MySQL client).

Run the script:

SOURCE torrens.sql;


Verify tables with:

SHOW TABLES;


Run example queries at the bottom of the script.

📖 Example Queries
1. Select students by campus
SELECT LastName, GivenName, Gender, CampusLocation 
FROM Student 
JOIN Campus ON Student.CampusID = Campus.CampusID 
WHERE CampusLocation = 'Adelaide';

2. Count students per campus
SELECT CampusLocation, COUNT(*) as NumStudents 
FROM Student 
JOIN Campus ON Student.CampusID = Campus.CampusID 
GROUP BY CampusLocation;

3. Join with Program Director
SELECT LastName, GivenName, ProgramName, CampusLocation 
FROM Student 
JOIN Course ON Student.CourseID = Course.CourseID 
JOIN `Program Director` ON Course.PDID = `Program Director`.PDID 
JOIN Campus ON Student.CampusID = Campus.CampusID;

4. Nested query – average assessments by campus
SELECT CampusLocation, AVG(AssessmentNum) as AvgAssessment 
FROM (
    SELECT CourseID, COUNT(*) as AssessmentNum 
    FROM SC 
    GROUP BY CourseID
) as Assessments 
JOIN Course ON Assessments.CourseID = Course.CourseID 
JOIN Campus ON Course.CampusID = Campus.CampusID 
GROUP BY CampusLocation;

👨‍💻 Authors

Chandra Bahadur Gurung
