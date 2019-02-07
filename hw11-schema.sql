/*
Brett Barinaga
CPSC 321
11/29/2018
HW11
hw11-schema.sql
*/

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
	employee_id INT NOT NULL, -- unique id for each employee
	salary INT, -- the salary for each employee
	title VARCHAR(20), -- the employees title
	PRIMARY KEY (employee_id)
)engine=InnoDB;

CREATE INDEX salIndex
ON Employee (salary);

CREATE INDEX customIndex
ON Employee(title, salary);
