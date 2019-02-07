/* Display all states with area/population greater than/less than x */
SELECT state_name --, area or population
FROM state
WHERE --area or population > X

/* Display all cities with population greater than/less than x or by state */
SELECT name --, area or population
FROM city
WHERE --population > X or State = X

/* Display all political parties with membership greater than/less than x or by state */
SELECT party_name --, area or population
FROM politics
WHERE --membership > X

/* Display all landmarks with given type or by state */
SELECT lm_name
FROM landmark
WHERE --type = X or State = X

/* Displays the top X results from State ordered by area or population */
SELECT state_name --, area or population
FROM state
ORDER BY --area or population
LIMIT X;

/* Displays the top X results from State ordered by # of cities */
SELECT state, COUNT(*)
FROM city
GROUP BY state
ORDER BY COUNT(*) desc
LIMIT X;

/* Displays the top X results from State ordered by # of landmarks */
SELECT state, COUNT(*)
FROM landmark
GROUP BY state
ORDER BY COUNT(*) desc
LIMIT X;

/* Displays the top X cities by population */
SELECT name, population
FROM city
ORDER BY population desc
LIMIT X;

/* Displays top political party by # of members */
SELECT party_name
FROM politics
ORDER BY membership desc
LIMIT X;

/* Displays top political party by states led */
SELECT party1, COUNT(*)
FROM state_politics
GROUP BY party1
ORDER BY COUNT(*)
LIMIT X;

/* Diplay all political parties with their headquarters in a state they aren't leading. */
SELECT DISTINCT p.party_name
FROM state_politics sp JOIN politics p ON sp.party1 = p.abbr
	JOIN city c ON sp.state_name = c.state
WHERE p.headquarters != c.name;

/* Displays population densities of German States. */
SELECT state_name, population/area AS "Citizens/km^2"
FROM state
ORDER BY "Citizens/km^2" desc;

/* Display the political leaning of the different states */
SELECT sp.state_name, p.position
FROM state_politics sp JOIN politics p ON sp.party1 = p.abbr;

/* Displays the landmark density by state. */
SELECT s.state_name, COUNT(*)
FROM state s JOIN landmark l ON s.state_name = l.state
GROUP BY s.state_name
ORDER BY LDensity desc;

/* Proportion of each party's control of government and population */
SELECT p.party_name,
	(SELECT 100*SUM(bundesrat_votes)/(SELECT SUM(bundesrat_votes) FROM state_politics)
	 FROM state_politics sp
	 WHERE sp.party1 = p.abbr
	 GROUP BY sp.party1
	) AS Vote_Percent,
	(SELECT 100*membership/(SELECT SUM(population) FROM state)
	 FROM politics p2
	 WHERE p.party_name = p2.party_name
	) AS Pop_Percent
FROM politics p;

