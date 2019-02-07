-- Brett Barinaga
-- CPSC 321
-- 10/15/2018
-- HW5


/*===========================================================================================
								1. Creating the Tables
============================================================================================*/
-- Dropping tables if they already exist
DROP VIEW IF EXISTS assoc_borders;
DROP TABLE IF EXISTS border;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS province;
DROP TABLE IF EXISTS country;

-- Table for Countries consisting of their codes, names, gross domestic product per capita, and inflation rates
CREATE TABLE country (
	code CHAR(2) NOT NULL, -- Code for the particular country (e.g., "US", "GB", "DE" etc.)
	country_name TEXT, -- Name of the country (e.g., United States of America)
	gdp INT, -- Gross domestic product per capita (e.g., 46,900 per person)
	inflation FLOAT(2,1), -- Inflation rate of the country in a percentage (e.g., 3.8 percent)
	PRIMARY KEY (code) -- Country codes are unique
)engine=InnoDB;


/* Inserting values into country table */
INSERT INTO country
VALUES ("AA", 	"Austrian Austria", 	99519,	2.0),
       ("BB", 	"Belgian Belgium", 		88091,	9.0),
       ("CC", 	"Canadian Canada", 		54778,	5.0),
       ("DD", 	"Danish Denmark",		51746,	5.0),
       ("EE", 	"Estonian Estonia", 	83243,	4.0),
       ("FF", 	"French France", 		72833,	7.0),
       ("GG", 	"German Germany", 		44076,	7.0),
       ("HH", 	"Hungarian Hungary", 	88552,	3.0),
       ("II", 	"Italian Italy", 		37885,	0.0),
       ("JJ", 	"Japanese Japan", 		45236,	8.0);

-- Table for Provinces (states in the US); consist of their names, countries, and areas (in km2)
CREATE TABLE province (
	province_name VARCHAR(50) NOT NULL, -- Name of the Province or State (e.g., Quebec, Oregon, Bavaria etc)
	country CHAR(2) NOT NULL, -- Code of the country in which the province exists (e.g., "DE" for Bavaria, or "US" for Oregon)
	area INT, -- Area of the province in square kilometers
	PRIMARY KEY (province_name, country), -- Composite key of country and province, since each province can have only one country
	FOREIGN KEY (country)
		REFERENCES country(code) -- The country code is a foreign key to Country.code
)engine=InnoDB;

/* Inserting values into province table */
INSERT INTO province
VALUES ("PA",	"AA",	35507),
	   ("PB",	"BB",	62355),
       ("PC",	"CC",	183782),
       ("PD",	"DD",	195068),
       ("PE",	"EE",	47524),
       ("PF",	"FF",	56424),
       ("PG",	"GG",	166579),
       ("PH",	"HH",	84258),
       ("PI",	"II",	33823),
       ("PJ",	"JJ",	80090),
       ("PK",	"AA",	16275),
       ("PL",	"BB",	158411),
       ("PM",	"CC",	87577),
       ("PN",	"DD",	156543),
       ("PO",	"EE",	175759),
       ("PP",	"FF",	124836),
       ("PQ",	"GG",	14636),
       ("PR",	"HH",	184980),
       ("PS",	"II",	27276),
       ("PT",	"JJ",	12333);

/*Table for cities consisting of their names, provinces, countries, and population*/
CREATE TABLE city (
	city_name VARCHAR(50) NOT NULL, -- Name of the city (e.g., New York, Moscow, Berlin)
	province VARCHAR(50) NOT NULL, -- Name of the Province or State (e.g., Quebec, Oregon, Bavaria etc)
	country CHAR(2) NOT NULL, -- Code of the country in which the city exists (e.g., "DE" for Dresden, or "US" for Austin)
	population INT,   -- Population of the city
	PRIMARY KEY (city_name, province, country), -- Composite key of country and province, since each city can be in only one province

	-- Province and country are foreign keys to province.province_name and province.country respectively
	FOREIGN KEY (province, country)
		REFERENCES province(province_name, country)
)engine=InnoDB;

/* Inserting values into city table */
INSERT INTO city
VALUES ("CA",	"PA",	"AA",	1455706),
		("CB",	"PB",	"BB",	468532),
       ("CC",	"PC",	"CC",	1795710),
       ("CD",	"PD",	"DD",	1672945),
       ("CE",	"PE",	"EE",	1775294),
       ("CF",	"PF",	"FF",	1601991),
       ("CG",	"PG",	"GG",	1400385),
       ("CH",	"PH",	"HH",	1754216),
       ("CI",	"PI",	"II",	148944),
       ("CJ",	"PJ",	"JJ",	1529635),
       ("CK",	"PK",	"AA",	1329770),
       ("CL",	"PL",	"BB",	1268945),
       ("CA",	"PM",	"CC",	549129),
       ("CN",	"PN",	"DD",	253689),
       ("CO",	"PO",	"EE",	1812455),
       ("CP",	"PP",	"FF",	874313),
       ("CQ",	"PQ",	"GG",	1840524),
       ("CR",	"PR",	"HH",	177242),
       ("CS",	"PS",	"II",	1484829),
       ("CT",	"PT",	"JJ",	950074),
       ("FA", "PA",  "AA",  13123),
       ("FB", "PA",  "AA",  4121),
       ("FC", "PC",  "CC",  231),
       ("FD", "PC",  "CC",  14223),
       ("FE", "PE",  "EE",  5221),
       ("FF", "PE",  "EE",  14221),
       ("LG", "PG",  "GG",  1312),
       ("FH", "PG",  "GG",  13123),
       ("FI", "PI",  "II",  1344),
       ("FJ", "PJ",  "JJ",  12341),
       ("FK", "PK",  "AA",  34211),
       ("FL", "PL",  "BB",  3421),
       ("FM", "PM",  "CC",  131542),
       ("FN", "PN",  "DD",  4564),
       ("FO", "PO",  "EE",  45641),
       ("FP", "PP",  "FF",  1324),
       ("FQ", "PQ",  "GG",  464),
       ("FR", "PR",  "HH",  56478),
       ("FS", "PS",  "II",  4651),
       ("FT", "PT",  "JJ",  7867),
       ("GA", "PA",  "AA",  13123),
       ("HA", "PA",  "AA",  13123),
       ("GG", "PG",  "GG",  1312),
       ("FG", "PG",  "GG",  13123),
       ("JG", "PG",  "GG",  1312),
       ("IG", "PG",  "GG",  13123),
       ("IA", "PA",  "AA",  13123);



-- Table for Borders between countries with their border lengths (in km)
CREATE TABLE border (
	country1 CHAR(2) NOT NULL, -- Code for the first particular country (e.g., "US", "GB", "DE" etc.)
	country2 CHAR(2) NOT NULL, -- Code for the second particular country (e.g., "US", "GB", "DE" etc.)
	border_length INT, -- Length of the border in km between country1 and country2
	PRIMARY KEY (country1, country2), -- there can be only 1 set of comparisons between two countries
	FOREIGN KEY (country1) 
		REFERENCES country(code), -- both country1 and country2 are foreign keys to country.code

	FOREIGN KEY (country2) 
		REFERENCES country(code) -- both country1 and country2 are foreign keys to country.code
)engine=InnoDB;

/* Inserting values into border table */
INSERT INTO border
VALUES ("AA",	"BB",	1017),
       ("BB",	"CC",	1718),
       ("CC",	"DD",	1474),
       ("DD",	"EE",	437),
       ("EE",	"FF",	2000),
       ("FF",	"GG",	1748),
       ("GG",	"HH",	1148),
       ("HH",	"II",	546),
       ("II",	"JJ",	1417),
       ("AA",	"CC",	1017),
       ("BB",	"DD",	1718),
       ("CC",	"EE",	1474),
       ("DD",	"FF",	437),
       ("EE",	"GG",	2000),
       ("FF",	"HH",	1748),
       ("GG",	"II",	1148),
       ("HH",	"JJ",	546),
       ("II",	"AA",	1417);



/*===========================================================================================
					Queries and Related Questions
============================================================================================*/



/*
1. Describe what the purpose of the following query is and write an equivalent query using the
“JOIN ON” syntax. Note that when describing the query, don’t recite the SQL; instead, state the
intent of the query.
*/
   /*
   This query gives unique provinces and their respective areas, that have at least one city of 
   over 1000 people.
   */

   SELECT DISTINCT p.province_name, p.area
   FROM province p JOIN city c ON c.province = p.province_name 
   WHERE c.population > 1000;

/*
2. Describe what the purpose of the following query is and write an equivalent query using the
“JOIN USING” syntax.
*/
   /*
   This query gives the name and country of a city who shares its name with a city in a different
   country, but has a larger population. (For example Paris France has a bigger population than
   Paris Texas, USA)
   */
   
   SELECT c1.city_name, c1.country
   FROM city c1 JOIN city c2 ON c1.city_name = c2.city_name
   WHERE c1.country != c2.country AND c1.population > c2.population;


/*
3. Write an SQL query that finds the GDP, inflation, and total population of each country. Let a
country’s population be the total population of all cities in that country.
*/

   SELECT c.code, c.inflation, SUM(ci.population)
   FROM country c, city ci
   WHERE c.code = ci.country
   GROUP BY ci.country;

/*
4. Write an SQL query to find the name, area, and total population of provinces with a population
over 1,000,000 people. Let the population of a province be the total population of each city in the
province.
*/
   SELECT p.province_name, p.area, SUM(c.population)
   FROM province p, city c
   WHERE c.province = p.province_name
   GROUP BY c.province;
/*
5. Write an SQL query that orders countries by their size in terms of the number of cities they
have.
*/
   SELECT DISTINCT c.code, COUNT(ci.city_name)
   FROM country c, city ci 
   WHERE ci.country = c.code
   GROUP BY c.code
   ORDER BY COUNT(*);

/*
6. Write an SQL query that orders countries by their total area. Let a country’s area be the sum
of each of its provinces’ areas.
*/
	SELECT c.code, SUM(p.area)
	FROM country c, province p
	WHERE c.code = p.country
	GROUP BY c.code 
	ORDER BY SUM(p.area);

/*
7. Write an SQL query that finds countries containing one or more provinces with at least 5 cities.
Your query should report the name of each country at most once.
*/
	SELECT DISTINCT c.code, p.province_name, COUNT(ci.city_name)
	FROM country c, province p, city ci 
	WHERE c.code = p.country AND c.code = ci.country AND ci.country = p.country
	GROUP BY p.province_name
	HAVING COUNT(ci.city_name) >= 5;

/*
8. Write a view called assoc borders that “completes” the borders relation such that if a row (c1,
c2, len) is in borders, then both (c1, c2, len) and (c2, c1, len) is in assoc borders. In other
words, the assoc borders relation is the associative version of the borders relation.
*/
	CREATE VIEW assoc_borders AS 
		(SELECT *
		FROM border)
		UNION
		(SELECT country2, country1, border_length
		FROM border);

	SELECT * FROM assoc_borders; -- for the sake of seeing output

/*
9. Write an SQL query that finds for each country, the average GDP and inflation of each of its
bordering countries. Your query should return the countries ordered by (from lowest to highest)
the average GDP followed by the average inflation of their bordering countries. Note you should
use your assoc borders relation in your query.
*/

	SELECT a.country1, AVG(c2.gdp), AVG(c2.inflation)
	FROM assoc_borders a, country c1, country c2
	WHERE a.country1 = c1.code AND
		  a.country2 = c2.code 
	GROUP BY a.country1
	ORDER BY AVG(c2.gdp), AVG(c2.inflation);


