-- Brett Barinaga
-- CPSC 321
-- 9/22/2018
-- HW3

/*
============================================================================
							HW2 Tables
============================================================================
*/


-- Dropping tables if they already exist 
DROP TABLE IF EXISTS individuals;
DROP TABLE IF EXISTS founders;
DROP TABLE IF EXISTS investments;
DROP TABLE IF EXISTS companies;


-- Create first table companies(company name, city, year founded, funding stage, type, funds raised, area)
-- The primary key is company name 
CREATE TABLE companies (
	Company_Name VARCHAR(50) NOT NULL, -- The name of the company
	City VARCHAR(50) NOT NULL,	 -- The city where the company is located
	Year_Founded INT NOT NULL, -- The year the company was founded
	Funding_Stage ENUM('Seed','Series A','Series B','Series C','Acquired') NOT NULL, 
	-- The funding stage the company is in
	Type ENUM('Startup', 'VC Firm', 'Incubator', 'Private') NOT NULL,
	-- What type of operation the company is, be it startup or otherwise
	Funds_Raised INT DEFAULT 0, -- How many funds the company has raised
	Area ENUM('Retail', 'Mobile', 'Education', 'Advertising', 'Games') NOT NULL,
	-- The area/category the company is involved
	PRIMARY KEY(Company_Name) -- company names are unique and thus the primary key
)Engine=InnoDB;

-- Inserting rows into companies table
INSERT INTO companies 
VALUES ('A','Seattle',2007,'Seed','Startup',130843,'Retail'),
       ('B','New York',2007,'Series A','VC Firm',240400,'Mobile'),
	   ('C','Houston',2008,'Series C','Incubator',3523100,'Education'),
	   ('D','Dallas',2008,'Series A','Private',4000100,'Advertising'),
	   ('E','Atlanta',2009,'Acquired','Startup',1995302,'Games'),
	   ('F','Los Angeles',2009,'Seed','VC Firm',2995302,'Retail'),
	   ('G','Palo Alto',2010,'Series A','Incubator',3995302,'Mobile'),
	   ('H','Chicago',2010,'Series B','Private',9952402,'Education'),
	   ('I','Green Bay',2011,'Series C','Startup',99245302,'Advertising'),
	   ('J','Miami',2011,'Acquired','VC Firm',1245302,'Games');
	   


-- Create second table investments(company name, investor, investor ssn, amount, year invested)
-- The primary key is a composite of Company name and Investor
CREATE TABLE investments (
	Company_Name VARCHAR(50) NOT NULL, -- The name of the company that recieved an investment
	SSN INT, -- The SSN of the investor if they are an individual, companies will have a null ssn
	Investor VARCHAR(50) NOT NULL, -- The name of the investor who gave the investment
	Amount INT DEFAULT 0, -- The dollar amount of the investment
	Year_Invested INT NOT NULL, -- The year the investment was made
	PRIMARY KEY (Company_Name, Investor), -- The primary key is a composite of company name and investor
	FOREIGN KEY (Company_Name)
		REFERENCES companies(Company_Name) -- the company name is a primary key in the companies relation
)Engine=InnoDB;

-- Inserting rows into investments table
INSERT INTO investments 
VALUES ('A', NULL,'D',415,2014),
	   ('A', 11118,'Angel Gonzalez',2310,2014),
	   ('B', NULL,'D',28211,2014),
	   ('B', 11116,'Cody Castillo',28211,2014),
	   ('C', NULL,'D', 130843, 2014),
	   ('C', 11111,'Colton Davis', 130843, 2014),
	   ('D', 11111,'Colton Davis', 130843, 2014),
	   ('D', 11112,'Dom Hawkins', 130843, 2015),
	   ('A', NULL,'C', 415, 2014),
	   ('A', 11116,'Cody Castillo', 2310,	2014),
	   ('B', NULL,'C', 28211, 2014),
	   ('B', 11118,'Angel Gonzalez', 130843, 2014),
	   ('C', NULL,'B', 130843, 2014),
	   ('C', 11112,'Dom Hawkins', 130843, 2014),
	   ('D', NULL,'B', 130843, 2014),
	   ('D', NULL,'A', 130843, 2014);

-- Create third table founders(name, ssn, company name, position held, year left)
-- Primary key is Company_Name since each company only has one founder and thus
--	only shows up once
CREATE TABLE founders (
	Name VARCHAR(50) NOT NULL, -- The name of a founder
	SSN INT NOT NULL, -- the ssn of a founder
	Company_Name VARCHAR(50) NOT NULL, -- the name of the company founded
	Position_Held VARCHAR(50) NOT NULL, -- last position held by the founder at the company
	Year_Left INT,  -- the year they left the company
	PRIMARY KEY (Company_Name), -- company names are unique since they can only have 1 founder
	FOREIGN KEY (Company_Name)
		REFERENCES companies(Company_Name) -- references the company names from the companies relation
)Engine=InnoDB;

-- Inserting rows into founders table
INSERT INTO founders
VALUES ('Colton Davis', 11111, 'A', 'CFO', 2007),
	   ('Colton Davis', 11111, 'B', 'CEO', 2007),
	   ('Zayne Braun', 11113, 'C', 'CFO', 2008),
	   ('Zayne Braun', 11113, 'D', 'CEO', 2008),
	   ('Lainey Hobbs', 11115, 'E', 'COO', 2009),
	   ('Lainey Hobbs', 11115, 'F', 'CEO', 2009),
	   ('Chad Fields', 11117, 'G', 'COO', 2010),
	   ('Chad Fields', 11117, 'H', 'CF0', 2010),
	   ('Alexus Rivera', 11119, 'I', 'CFO', 2011),
	   ('Alexus Rivera', 11119, 'J', 'CEO', 2011);

-- Create fourth table individuals(name, ssn, last school, degree, company name, position, year entered)
-- Primary key is ssn, since each person has a unique social security number
CREATE TABLE individuals (
	Name VARCHAR(50), -- name of the person 
	SSN INT NOT NULL, -- guaranteed unique id for each person
	Last_School VARCHAR(50), -- name of the last school they atteneded
	Degree VARCHAR(50), -- the degree they earned 
	Company_Name VARCHAR(50) NOT NULL, -- name of company they are employed at
	Position VARCHAR(50), -- position at the company
	Year_Entered INT NOT NULL, -- year an individual joined the company 
	Year_Left INT, -- year they left the company (null if still there)
	PRIMARY KEY (SSN, Company_Name),  -- social security numbers are always unique
	FOREIGN KEY (Company_Name) -- references the companies company name
		REFERENCES companies(Company_Name)
)Engine=InnoDB;

-- Inserting rows into individuals table
INSERT INTO individuals
VALUES ('Colton Davis',11111,'UW','B.S. Business','A','CFO',2007, 2007),
	   ('Dom Hawkins',11112,'UW','B.S. Business','B','CEO', 2007, 2007),
	   ('Zayne Braun',11113,'WSU','B.S. Business','C','CFO', 2008, 2008),
	   ('Nikolas Crosby',11114,'WSU','B.S. Business','D','CEO',	2008, 2008),
	   ('Lainey Hobbs',11115,'GU','B.S. Business','E','COO', 2009, 2009),
	   ('Cody Castillo',11116,'GU','B.S. Business','F','CEO', 2009, 2009),
	   ('Chad Fields',11117,'WWU','B.S. Business','G','COO', 2010, 2010),
	   ('Angel Gonzalez',11118,'WWU','B.S. Business','H','CFO',	2010, 2010),
	   ('Alexus Rivera',11119,'WU','B.S. Business','I','CFO', 2011, 2011),
	   ('Todd Simons',11120,'WU','B.S. Business','J','CEO',	2011, 2011),
	   ('Jayce Cisneros',11121,'EWU','B.S. CS','A','Engineer',2012, 2014),
	   ('Meghan Moreno',11122,	'EWU','B.S. CS','B','Engineer',2012, 2014),
	   ('Colten Hampton',11123,'SU','B.S. CS','C','Engineer',2012, 2014),
	   ('Eleanor Butler',11124,'SU','B.S. CS','D','Engineer',2012, 2014),
	   ('Saul Spencer',11125,'UCLA','B.S. CS','E','Engineer',2012, 2014),
	   ('Bobby Newton',11126,'UCLA','B.S. CS','F','Engineer',2012, 2014),
	   ('Kyler Duarte',11127,'Stanford','B.S. CS','G','Engineer',2012, 2014),
	   ('Willie Aguirre',11128,'Stanford','B.S. CS','H','Engineer',2012, 2014),
	   ('Bernard Cooke',11129,'Harvard','B.S. CS','I','Engineer',2012, 2014),
	   ('Cade Phillips',11130,	'Harvard','B.S. CS','J','Engineer',2012, 2014),
	   ('John Wick', 11131,'UW', 'B.S. Business','A', 'Sales', 2012, NULL),
       ('Kevin Oliver',11132,'UW','B.S. Business','B', 'Sales', 2012, NULL),
	   ('James Monroe', 11133,	'WSU', 'B.S. Business',	'C', 'Sales', 2012, NULL),
       ('Adam McCarthy', 11134, 'WSU', 'B.S. Business', 'D', 'Sales', 2012, NULL),
	   ('Jane Doe', 11135,	'GU', 'B.S. Business','E', 'Sales', 2012, NULL),
	   ('Amy Michaels', 11136,	'GU', 'B.S. Business', 'F',	'Sales'	, 2012, NULL),
	   ('Katherine Vontrapp', 11137, 'WWU', 'B.S. Business', 'G', 'Sales', 2012, NULL),
	   ('Elizabeth James', 11138, 'WWU', 'B.S. Business', 'H',	'Sales', 2012, NULL),
	   ('Douglas Fir',	11139, 'WU', 'B.S. Business', 'I', 'Sales',	2012, NULL),
 	   ('Peter Cupp',	11140,	'WU', 'B.S. Business',	'J', 'Sales', 2012, NULL),
	   ('Quintin Brown', 11141, 'EWU', 'B.S. Business', 'A', 'Sales', 2013, 2016),
 	   ('Donovon McNabb', 11142, 'EWU', 'B.S. Business', 'B', 'Sales',	2013, 2016),
       ('Tom Riddle', 11143, 'SU', 'B.S. Business', 'C', 'Sales', 2013, 2016),
	   ('Andrew Elsasser',	11144, 'SU', 'B.S. Business', 'D', 'Sales',	2013, 2016),
 	   ('Ronald Mcdonald',	11145, 'UCLA', 'B.S. Business',	'E', 'Sales', 2013, 2016),
 	   ('Julius Carr',	11146,	'UCLA',	'B.S. Business', 'F', 'Sales', 2013, 2016),
	   ('Heidi Zimmerman',	11147, 'Stanford', 'B.S. Business',	'G', 'Sales', 2013, 2016),
	   ('Jay Green', 11148, 'WWU',	'B.S. Business', 'H', 'Sales',	2013, 2016),
	   ('Bruce Schneider',	11149,	'WWU',	'B.S. Business', 'I', 'Sales', 2013, 2016),
	   ('Lance Stevenson',	11150, 'WU', 'B.S. Business', 'J', 'Sales',	2013, 2016),
	   ('Levveon Bell',	11151, 'WWU','B.S. CS',	'A', 'Engineer', 2013, NULL),
	   ('Ryan Fitzpatrick', 11152, 'WWU','B.S. CS',	'B', 'Engineer', 2013, NULL),
	   ('Todd Gurley', 11153,	'WU','B.S. CS',	'C', 'Engineer', 2013, NULL),
	   ('Tom Brady', 11154,	'WU','B.S. CS',	'D', 'Engineer', 2013, NULL),
	   ('Kirk Cousins', 11155,	'EWU','B.S. CS', 'E', 'Engineer', 2013, NULL),
	   ('Eli Manning', 11156,	'EWU','B.S. CS', 'F', 'Engineer', 2013, NULL),
	   ('Aaron Rodgers', 11157,	'SU','B.S. CS',	'G', 'Engineer', 2013, NULL),
	   ('Antonio Brown', 11158,	'SU','B.S. CS',	'H', 'Engineer', 2013, NULL),
	   ('Pierre Garcon', 11159,	'UCLA',	'B.S. CS',	'I', 'Engineer', 2013, NULL),
	   ('Ryan Murphy', 11160,	'UCLA',	'B.S. CS',	'J', 'Engineer', 2013, NULL),
	   ('Colton Davis',11111,'UW','B.S. Business','J','CFO',2014, NULL),
	   ('Dom Hawkins',11112,'UW','B.S. Business','I','CEO', 2014, NULL),
	   ('Zayne Braun',11113,'WSU','B.S. Business','H','CFO', 2014, NULL),
	   ('Nikolas Crosby',11114,'WSU','B.S. Business','G','CEO',	2014, NULL),
	   ('Lainey Hobbs',11115,'GU','B.S. Business','F','COO', 2014, NULL),
	   ('Cody Castillo',11116,'GU','B.S. Business','E','CEO', 2014, NULL),
	   ('Chad Fields',11117,'WWU','B.S. Business','D','COO', 2014, NULL),
	   ('Angel Gonzalez',11118,'WWU','B.S. Business','C','CFO',	2014, NULL),
	   ('Alexus Rivera',11119,'WU','B.S. Business','B','CFO', 2014, NULL),
	   ('Todd Simons',11120,'WU','B.S. Business','A','CEO',	2014, NULL);



/*
============================================================================
							HW3 Queries
============================================================================
*/ 

-- 1. This query returns the names and city locations of all companies 
-- founded in a particular year 
SELECT Company_Name, City 
FROM companies
WHERE Year_Founded = 2009;

-- 2. This query returns the names of all companies in a particular area (field of work)
-- Note: I'm also returning the area alongside the names for the sake of making it easier 
-- to read
SELECT Company_Name, Area
FROM companies 
WHERE Area = 'Mobile';

-- 3. This query returns all companies founded by an individual, as well as the 
-- position they held and the year that individual left the company 
SELECT Name, Company_Name, Position_Held, Year_Left
FROM founders
WHERE Name = 'Chad Fields';

-- 4. This query finds all the employees in a particular company from a range of years, and also finds
-- that employees name and position last held at the company
SELECT Company_Name, Name, Position, Year_Entered
FROM individuals
WHERE Company_Name = 'C' AND Year_Entered > 2010 AND Year_Entered < 2013;

-- 5. This query returns all the names of and last degrees of individuals who last attended a particular school
SELECT DISTINCT Last_School, Name, Degree
FROM individuals
WHERE Last_School = 'GU';

-- 6. This query returns the names, amounts and years of investment for investors in a particular company
SELECT Investor, Amount, Year_Invested
FROM investments
WHERE Company_Name = 'B';

-- 7. This query returns all the companies which have invested in a particular company, as well as the amounts
-- and year they invested
SELECT Company_Name, Investor, Amount, Year_Invested
FROM investments
WHERE Company_Name = 'A' AND SSN IS NULL;

-- 8. This query returns the areas of the companies that an individual has worked for
SELECT Name, companies.Company_Name, Area
FROM companies, individuals
WHERE Name = 'Dom Hawkins' AND companies.Company_Name = individuals.Company_Name;

-- 9. This query returns all the names of companies, in at least two different areas
-- for example it returns all mobile companies and all retail companies
SELECT Company_Name, Area
FROM companies
WHERE Area = 'Mobile' OR Area = 'Retail';

-- 10. This query returns the names and company name of individuals who worked together
-- at the same company
SELECT a1.Name, a2.Name, a1.Company_Name
FROM individuals a1, individuals a2
WHERE 
a1.Company_Name = a2.Company_Name AND
a1.Name != a2.Name AND
a1.Year_Left > a2.Year_Entered OR 
a2.Year_Entered is NULL;