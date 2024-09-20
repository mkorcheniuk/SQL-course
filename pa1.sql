create table Employees (
    EmployeeID int primary key,
    EmployeeName varchar(100),
    DepartmentID int
);

create table Departments (
    DepartmentID int primary key,
    DepartmentName varchar(100)
);

create table Projects (
    ProjectID int primary key,
    ProjectName varchar(100),
    StartDate date
);

CREATE TABLE ArchivedProjects (
    ProjectID int PRIMARY KEY,
    ProjectName varchar(100),
    StartDate date
);

create table Assignments (
    AssignmentID int primary key,
    EmployeeID int,
    ProjectID int,
    HoursWorked int,
    foreign key (EmployeeID) references Employees(EmployeeID),
    foreign key (ProjectID) references Projects(ProjectID)
);

create table Salaries (
    SalaryID int primary key,
    EmployeeID int,
    MonthlySalary decimal(10, 2),
    foreign key (EmployeeID) references Employees(EmployeeID)
);


insert into Departments (DepartmentID, DepartmentName) values
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Finance');

insert into Employees (EmployeeID, EmployeeName, DepartmentID) values
(1, 'Alice Johnson', 1),
(2, 'Bob Smith', 2),
(3, 'Charlie Lee', 1),
(4, 'Diana Adams', 3);

insert into Projects (ProjectID, ProjectName, StartDate) values
(1, 'Project Alpha', '2023-01-15'),
(2, 'Project Beta', '2022-12-10'),
(3, 'Project Gamma', '2023-03-05');

insert into Assignments (AssignmentID, EmployeeID, ProjectID, HoursWorked) values
(1, 1, 1, 100),
(2, 2, 2, 50),
(3, 3, 1, 120),
(4, 3, 3, 80),
(5, 4, 2, 60);

insert into Salaries (SalaryID, EmployeeID, MonthlySalary) values
(1, 1, 6000),
(2, 2, 4500),
(3, 3, 5000),
(4, 4, 5500);

INSERT INTO ArchivedProjects (ProjectID, ProjectName, StartDate) VALUES
(4, 'Project Delta', '2022-03-01'),
(5, 'Project Epsilon', '2021-06-10');

with ProjectDAta as (
	select ProjectID, ProjectName, StartDate
	from projects
	union
	select ProjectID, ProjectName, StartDate
	FROM archivedprojects
)
select
	e.EmployeeName,
	p.ProjectName,
	avg(s.monthlySalary) as averagesalary,
	sum(a.HoursWorked) as totalhours
from
employees e
join
	assignments a
	on e.EmployeeID = a.EmployeeID
join
	ProjectData p
	on a.ProjectID = P.ProjectID
join salaries s
	on e.EmployeeID = s.EmployeeID
where p.Startdate > '2023-01-01'
group by 
    e.Employeename,
    p.Projectname
order by totalhours desc;

