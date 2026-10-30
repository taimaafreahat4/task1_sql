create table TempInstructors(
tempid INT ,
tempname varchar(50),
joinedate date);

create table Departments(
departmentid INT primary key ,
departmentname varchar(100) not null unique
);

create table students(
studentid INT primary key ,
funllname varchar(100) not null ,
email varchar(100) unique,
gpa decimal(3,2),
departmentID int references Departments(departmentid)
);


create table StudentProfiles(
profileid INT primary key ,
studentid int  unique references students(studentid),
Address VARCHAR(200),
EmergencyPhone VARCHAR(20)
);


create table courses(
courseid INT primary key ,
coursename varchar(100)  not null ,
credits int,
departmentID int references Departments(departmentid)
);


create table StudentCourses (
studentid int references students(studentid),
courseid int references courses(courseid),
EnrollmentDate  date DEFAULT GETDATE(),
primary key(studentid,courseid));


alter table students add age int ;
select * from students
drop table TempInstructors

insert into Departments values (1, 'Computer Science'), (2, 'Software Engineering'), (3, 'Business Administration');

INSERT INTO students
VALUES
(101, 'Ali Smadi', 'ali@coursehub.com', 3.80, 1, 22),
(102, 'Omar Ahmad', 'omar@coursehub.com', 2.90, 1, 21),
(103, 'Laila Hassan', 'laila@coursehub.com', 3.50, 2, 23),
(104, 'Tariq Zaid', 'tariq@coursehub.com', 2.10, 3, 20);


INSERT INTO StudentProfiles
VALUES
(1, 101, 'Amman, Jordan', '0791111111'),
(2, 102, 'Irbid, Jordan', '0792222222'),
(3, 103, 'Zarqa, Jordan', '0793333333');


INSERT INTO courses
VALUES
(201, 'Database Systems', 3, 1),
(202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2);

INSERT INTO StudentCourses
(StudentID, CourseID)
VALUES
(101, 201),
(101, 202),
(102, 201),
(103, 203);


SELECT * FROM Students;
SELECT * FROM StudentProfiles;
SELECT * FROM Courses;
SELECT * FROM StudentCourses;
select * from Departments;

update students set gpa=2.50 where studentid=104;
delete from students where studentid=104;

select funllname,gpa,departmentname from students
inner join Departments on students.departmentid= Departments.departmentID;


select departmentname,funllname from Departments 
left join students on students.departmentID=Departments.departmentid;


select funllname,Address,EmergencyPhone from students
inner join StudentProfiles on students.studentid= StudentProfiles.studentid;


select funllname,coursename,EnrollmentDate
from students 
inner join StudentCourses 
on students.studentid=StudentCourses.studentid
inner join courses on courses.courseid=StudentCourses.courseid;


--Task 5.1: Global Aggregations
select count(*) as TotalStudents ,
avg(gpa) as AverageGPA ,
max(gpa) as HighestGPA ,
min(gpa) as LowestGPA
from students;

select * from Departments
--Task 5.2: GROUP BY Department
select departmentid,avg(gpa) as AverageGPA,
count(*) as TotalStudents
from students
group by departmentID;


--Task 5.3: HAVING Clause
select departmentid,avg(gpa) as AverageGPA
from students
group by departmentID
having avg(gpa)>3.00;


--Task 5.4: Combined Query (WHERE + GROUP BY + HAVING)
select  count(*) as TotalStudents,departmentid
from students
where gpa>=2.50
group by departmentID
having count(*)>1;



CREATE NONCLUSTERED INDEX IX_Students_Email
ON Students(Email);

--Task 7.1: Subqueries
select * from students where gpa>(select avg(gpa)from students);

--Task 7.2: Views
create view vw_StudentAcademicDetails as 
select studentid,funllname,gpa,departmentname
from students
inner join Departments on students.studentid=Departments.departmentid
select * from vw_StudentAcademicDetails;


--Task 7.3: Stored Procedures
CREATE PROCEDURE sp_GetStudentsByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Students
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetStudentsByDepartment @DeptID = 1;
EXEC sp_GetStudentsByDepartment @DeptID = 2;