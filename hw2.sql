-- Brett Barinaga
-- CPSC 321
-- 9/10/2018
-- HW2


-- Dropping tables if they already exist 
DROP TABLE IF EXISTS individuals;
DROP TABLE IF EXISTS founders;
DROP TABLE IF EXISTS investments;
DROP TABLE IF EXISTS companies;


-- Create first table companies(company name, city, year founded, funding stage, type, funds raised, area)
-- The primary key is company name 
CREATE TABLE companies (
	Company_Name VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,	
	Year_Founded INT NOT NULL,
	Funding_Stage ENUM('Seed','Series A','Series B','Series C','Acquired') NOT NULL,
	Type ENUM('Startup', 'VC Firm', 'Incubator', 'Private') NOT NULL,
	Funds_Raised INT DEFAULT 0,
	Area ENUM('Retail', 'Mobile', 'Education', 'Advertising', 'Games') NOT NULL,
	PRIMARY KEY(Company_Name)
)Engine=InnoDB;

-- Inserting rows into companies table
INSERT INTO companies 
VALUES
	('A','Seattle',2012,'Seed','Startup',130843,'Retail'),
	('B','New York',2012,'Series A','VC Firm',240400,'Mobile'),
	('C','Houston',2013,'Series C','Incubator',3523100,'Education'),
	('D','Dallas',2013,'Series A','Private',4000100,'Advertising'),
	('E','Atlanta',2014,'Acquired','Startup',1995302,'Games'),
	('F','Los Angeles',2014,'Seed','VC Firm',2995302,'Retail'),
	('G','Palo Alto',2015,'Series A','Incubator',3995302,'Mobile'),
	('H','Chicago',2015,'Series B','Private',9952402,'Education'),
	('I','Green Bay',2016,'Series C','Startup',99245302,'Advertising'),
	('J','Miami',2016,'Acquired','VC Firm',1245302,'Games');

-- Create second table investments(company name, investor, investor ssn, amount, year invested)
-- The primary key is a composite of Company name and Investor
CREATE TABLE investments (
	Company_Name VARCHAR(50) NOT NULL,
	Investor VARCHAR(50) NOT NULL,
	SSN INT,
	Amount INT DEFAULT 0,
	Year_Invested INT NOT NULL,
	PRIMARY KEY (Company_Name, Investor)
)Engine=InnoDB;

-- Inserting rows into investments table
INSERT INTO investments 
VALUES
	('A','D',NULL,415,2015),
	('A','Angel Gonzalez',11118,2310,2014),
	('B','D',NULL,28211,2015),
	('B','Cody Castillo',11116,28211,2015),
	('C', 'D', NULL, 130843, 2015),
	('C', 'Colton Davis', 11111, 130843, 2015),
	('D', 'Colton Davis', 11111, 130843, 2015),
	('D', 'Dom Hawkins', 11112, 130843, 2015);

-- Create third table founders(name, ssn, company name, position held, year left)
-- Primary key is Company_Name since each company only has one founder and thus
--	only shows up once
CREATE TABLE founders (
	Name VARCHAR(50) NOT NULL,
	SSN INT NOT NULL,
	Company_Name VARCHAR(50) NOT NULL,
	Position_Held VARCHAR(50) NOT NULL,
	Year_Left INT NOT NULL,
	PRIMARY KEY (Company_Name)
)Engine=InnoDB;

-- Inserting rows into founders table
INSERT INTO founders
VALUES
	('Colton Davis', 11111, 'A', 'CFO', 2012),
	('Colton Davis', 11111, 'B', 'CEO', 2012),
	('Zayne Braun', 11113, 'C', 'CFO', 2013),
	('Zayne Braun', 11113, 'D', 'CEO', 2013),
	('Lainey Hobbs', 11115, 'E', 'COO', 2014),
	('Lainey Hobbs', 11115, 'F', 'CEO', 2014),
	('Chad Fields', 11117, 'G', 'COO', 2015),
	('Chad Fields', 11117, 'H', 'CF0', 2015),
	('Alexus Rivera', 11119, 'I', 'CFO', 2016),
	('Alexus Rivera', 11119, 'J', 'CEO', 2016);

-- Create fourth table individuals(name, ssn, last school, degree, company name, position, year entered)
-- Primary key is ssn, since each person has a unique social security number
CREATE TABLE individuals (
	Name VARCHAR(50),
	SSN INT NOT NULL,
	Last_School VARCHAR(50),
	Degree VARCHAR(50),
	Company_Name VARCHAR(50) NOT NULL,
	Position VARCHAR(50),
	Year_Entered INT NOT NULL,
	PRIMARY KEY (SSN)
)Engine=InnoDB;

-- Inserting rows into individuals table
INSERT INTO individuals
VALUES
	('Colton Davis',11111,'UW',	'B.S. Business','J','CFO',	2012),
	('Dom Hawkins',11112,'UW',	'B.S. Business','I','CEO',	2012),
	('Zayne Braun',11113,'WSU',	'B.S. Business','H','CFO',	2012),
	('Nikolas Crosby',11114,'WSU',	'B.S. Business','G','CEO',	2012),
	('Lainey Hobbs',11115,'GU',	'B.S. Business','F','COO',	2012),
	('Cody Castillo',11116,'GU',	'B.S. Business','E','CEO',	2012),
	('Chad Fields',11117,'WWU',	'B.S. Business','D','COO',	2013),
	('Angel Gonzalez',11118,'WWU',	'B.S. Business','C','CFO',	2013),
	('Alexus Rivera',11119,'WU',	'B.S. Business','B','CFO',	2013),
	('Todd Simons',11120,'WU',	'B.S. Business','A','CEO',	2013),
	('Jayce Cisneros',11121,'EWU',	'B.S. CS','J','Engineer',2014),
	('Meghan Moreno',11122,	'EWU',	'B.S. CS','I','Engineer',2014),
	('Colten Hampton',11123,'SU',	'B.S. CS','H','Engineer',2014),
	('Eleanor Butler',11124,'SU',	'B.S. CS','G','Engineer',2014),
	('Saul Spencer',11125,'UCLA',	'B.S. CS','F','Engineer',2015),
	('Bobby Newton',11126,'UCLA',	'B.S. CS','E','Engineer',2015),
	('Kyler Duarte',11127,'Stanford',	'B.S. CS','D','Engineer',2015),
	('Willie Aguirre',11128,'Stanford',	'B.S. CS','C','Engineer',2016),
	('Bernard Cooke',11129,'Harvard',	'B.S. CS','B','Engineer',2016),
	('Cade Phillips',11130,	'Harvard',	'B.S. CS','A','Engineer',2016);



