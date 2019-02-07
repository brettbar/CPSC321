-- germanyDB.sql
-- This file populates germanyDB with the base set of tables
-- Data sources are listed with their respective tables.


DROP TABLE IF EXISTS state_politics;
DROP TABLE IF EXISTS landmark;
DROP TABLE IF EXISTS politics;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS state;

-- The states of the FRG
-- https://en.wikipedia.org/wiki/States_of_Germany
CREATE TABLE state (
	state_name VARCHAR(50),
	capital VARCHAR(50), 
	area INT,
	population INT,
	PRIMARY KEY (state_name)
)engine=InnoDB;

-- Top 79 cities in Germany by population as of 2015
-- https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population
CREATE TABLE city (
	name VARCHAR(50),
	state VARCHAR(50),
	population INT,
	PRIMARY KEY (name),
	FOREIGN KEY (state)
		REFERENCES state (state_name)
)engine=InnoDB;

-- All major political parties in the FRG
-- https://en.wikipedia.org/wiki/List_of_political_parties_in_Germany
CREATE TABLE politics (
	party_name VARCHAR(100),
	abbr VARCHAR(50),
	leader VARCHAR(50),
	membership INT,
	headquarters VARCHAR(50),
	position VARCHAR (50),
	PRIMARY KEY (abbr),
	FOREIGN KEY (headquarters)
		REFERENCES city (name)
)engine=InnoDB;

-- Most prominent german landmarks
-- https://en.wikipedia.org/wiki/Category:Landmarks_in_Germany
CREATE TABLE landmark (
	type ENUM('castle', 'cathedral', 'mountain', 'monument', 'park'),
	lm_name VARCHAR(50), 
	state VARCHAR(50),
	PRIMARY KEY (lm_name),
	FOREIGN KEY (state)
		REFERENCES state(state_name)
)engine=InnoDB;

-- Breakdown of politics of german states
-- https://en.wikipedia.org/wiki/States_of_Germany
CREATE TABLE state_politics (
	state_name VARCHAR(50),
	party1 VARCHAR(50),
	party2 VARCHAR(50),
	bundesrat_votes INT,
	PRIMARY KEY (state_name),
	FOREIGN KEY (state_name)
		REFERENCES state(state_name),
	FOREIGN KEY (party1)
		REFERENCES politics(abbr),
	FOREIGN KEY (party2)
		REFERENCES politics(abbr)
)engine=InnoDB;

INSERT INTO state 
VALUES 
	("Baden-Wurttemberg", "Stuttgart", 35752, 10755000),
	("Bavaria", "Munich", 70552, 12542000),
	("Berlin", "Berlin", 892, 3469000),
	("Brandenburg", "Potsdam", 29479, 2500000),
	("Bremen", "Bremen", 419, 661000),
	("Hamburg", "Hamburg", 755, 1788000),
	("Hesse", "Wiesbaden", 21115, 6066000),
	("Lower Saxony", "Hanover", 47609, 7914000),	
	("Mecklenburg-Vorpommern", "Schwerin", 23180, 1639000),
	("North Rhine-Westphalia", "Dusseldorf", 34085, 17837000),
	("Rhineland-Palatinate", "Mainz", 19853, 4052803),
	("Saarland", "Saarbrucken", 2569, 1018000),
	("Saxony", "Dresden", 18416, 4143000),
	("Saxony-Anhalt", "Magdeburg", 20446, 2331000),
	("Schleswig-Holstein", "Kiel", 15799, 2833000),
	("Thuringia", "Erfurt", 16172, 2231000);

INSERT INTO city 
VALUES
	("Berlin", 	"Berlin", 3520031),
	("Hamburg", "Hamburg", 1787408),
	("Munich", "Bavaria", 1450381),
	("Cologne",	"North Rhine-Westphalia", 1060582),
	("Frankfurt am Main", "Hesse", 732688),
	("Stuttgart", "Baden-Wurttemberg", 623738),
	("Dusseldorf", "North Rhine-Westphalia", 612178),
	("Dortmund", "North Rhine-Westphalia", 586181),
	("Essen", "North Rhine-Westphalia", 582624),
	("Leipzig", "Saxony", 560472),
	("Bremen", "Bremen", 557464),
	("Dresden", "Saxony", 543825),
	("Hanover",	"Lower Saxony",	532163),
	("Nuremberg", "Bavaria", 509975),
	("Duisburg", "North Rhine-Westphalia", 491231),
	("Bochum", "North Rhine-Westphalia", 364742),
	("Wuppertal", "North Rhine-Westphalia", 350046),
	("Bielefeld", "North Rhine-Westphalia",	333090),		
	("Bonn", "North Rhine-Westphalia", 318809),
	("Munster", "North Rhine-Westphalia", 310039),
	("Karlsruhe", "Baden-Wurttemberg", 307755),
	("Mannheim", "Baden-Wurttemberg", 305780),
	("Augsburg", "Bavaria",	286374),
	("Wiesbaden", "Hesse", 276218),
	("Gelsenkirchen", "North Rhine-Westphalia", 260368),
	("Monchengladbach", "North Rhine-Westphalia", 259996),
	("Braunschweig", "Lower Saxony", 251364),
	("Chemnitz", "Saxony", 248645),
	("Kiel", "Schleswig-Holstein", 246306),
	("Aachen", "North Rhine-Westphalia", 245885),
	("Halle", "Saxony-Anhalt", 236991),
	("Magdeburg", "Saxony-Anhalt", 235723),
	("Freiburg im Breisgau", "Baden-Wurttemberg", 226393),
	("Krefeld", "North Rhine-Westphalia", 225144),
	("Lubeck", "Schleswig-Holstein", 216253),
	("Oberhausen", "North Rhine-Westphalia", 210934),
	("Erfurt", "Thuringia", 210118),
	("Mainz", "Rhineland-Palatinate", 209779),
	("Rostock", "Mecklenburg-Vorpommern", 206011),
	("Kassel", "Hesse", 197984),
	("Hagen", "North Rhine-Westphalia",	189044),
	("Hamm", "North Rhine-Westphalia", 179397),
	("Saarbrucken",	"Saarland",	178151),
	("Mulheim an der Ruhr", "North Rhine-Westphalia", 169278),
	("Potsdam",	"Brandenburg",	167745),
	("Ludwigshafen am Rhein", "Rhineland-Palatinate", 164718),
	("Oldenburg", "Lower Saxony", 163830),
	("Leverkusen", "North Rhine-Westphalia", 163487),
	("Osnabruck", "Lower Saxony", 162403),
	("Solingen", "North Rhine-Westphalia", 158726),
	("Heidelberg", "Baden-Wurttemberg",	156267),
	("Herne", "North Rhine-Westphalia",	155851),
	("Neuss", "North Rhine-Westphalia",	155414),
	("Darmstadt", "Hesse", 155353),
	("Paderborn", "North Rhine-Westphalia",	148126),
	("Regensburg", "Bavaria", 145465),
	("Ingolstadt", "Bavaria", 132438),
	("Wurzburg", "Bavaria",	124873),
	("Furth", "Bavaria", 124171),
	("Wolfsburg", "Lower Saxony", 124045),
	("Offenbach am Main", "Hesse", 123734),
	("Ulm", "Baden-Wurttemberg", 122636),
	("Heilbronn", "Baden-Wurttemberg",	122567),
	("Pforzheim", "Baden-Wurttemberg",	122247),
	("Gottingen", "Lower Saxony",	118914),
	("Bottrop",	"North Rhine-Westphalia",	117143),
	("Trier", "Rhineland-Palatinate",	114914),
	("Recklinghausen", "North Rhine-Westphalia",	114330),
	("Reutlingen", "Baden-Wurttemberg",	114310),
	("Bremerhaven",	"Bremen",	114025),
	("Koblenz",	"Rhineland-Palatinate",	112586),
	("Bergisch Gladbach", "North Rhine-Westphalia",	111366),
	("Jena", "Thuringia",	109527),
	("Remscheid", "North Rhine-Westphalia",	109499),
	("Erlangen", "Bavaria",	108336),
	("Moers", "North Rhine-Westphalia",	104529),
	("Siegen", "North Rhine-Westphalia",	102355),
	("Hildesheim", "Lower Saxony",	101667),
	("Salzgitter", "Lower Saxony",	101079);

INSERT INTO politics 
VALUES
	("Christian Democratic Union of Germany", "CDU", "Annegret Kramp-Karrenbauer", 425910, "Berlin", "Center-right"),
	("Social Democratic Party of Germany", "SPD", "Andrea Nahles", 457700, "Berlin", "Center-left"),
	("Alternative for Germany", "AfD", "Jorg Meuthen", 33500, "Berlin", "Right-wing"),
	("Free Democratic Party", "FDP", "Christian Lindner", 65000, "Berlin", "Center"),
	("The Left", "LINKE", "Kafja Kipping", 62000, "Berlin", "Left-wing"),
	("The Greens", "GRUNE", "Annalena Baerbock", 70000, "Berlin", "Center-left"),
	("Christian Social Union in Bavaria", "CSU", "Horst Seehofer", 141000, "Munich", "Center-right"),
	("The Blue Party", "B", "Michael Muster", NULL, "Berlin", "Right-wing"),
	("Liberal Conservative Reformers", "LKR", "Bernd Kolmel", 2000, NULL, "Center-right"),
	("Ecological Democratic Party", "ODP", "Christoph Raabs", 6400, "Wurzburg", "Center-right"),
	("Die PARTEI", "Die PARTEI", "Martin Sonneborn", 29500, "Berlin", "Apolitical"),
	("Pirate Party Germany", "PIRATEN", "Carsten Sawosch", 11680, "Berlin", "Syncretic"),
	("National Democratic Party of Germany", "NPD", "Frank Franz", NULL, "Berlin", "Far-right");


INSERT INTO landmark
VALUES
	('cathedral', "Aachen Cathedral", "North Rhine-Westphalia"),
	('castle', "Alt-Scharfeneck Castle", "Rhineland-Palatinate"),
	('castle', "Altdahn Castle", "Rhineland-Palatinate"),
	('castle', "Battenberg Castle", "Rhineland-Palatinate"),
	('monument', "Bavaria statue", "Bavaria"),
	('monument', "Befreiungshalle", "Bavaria"),
	('park', "Bergpark Wilhelmshohe", "Hesse"),
	('castle', "Bramberg Castle", "Bavaria"),
	('castle', "Brennhausen", "Bavaria"),
	('castle', "Schloss Buchenau", "Hesse"),
	('cathedral', "Cologne Cathedral", "North Rhine-Westphalia"),
	('park', "Dessau-Worlitz Garden Realm", "Saxony-Anhalt"),
	('castle', "Drachenfels Castle (Wasgau)", "Rhineland-Palatinate"),
	('castle', "Ehrenbreitstein Fortress", "Rhineland-Palatinate"),
	('castle', "Elisabethenburg Palace", "Thuringia"),
	('castle', "Eltz Castle", "Rhineland-Palatinate"),
	('castle', "Frankenberg Castle (Aachen)", "North Rhine-Westphalia"),
	('castle', "Giebichenstein Castle", "Saxony-Anhalt"),
	('cathedral', "Gustav Adolf Stave Church", "Lower Saxony"),
	('castle', "Hambach Castle", "Rhineland-Palatinate"),
	('cathedral', "St. Johannis Harvestehude", "Hamburg"),
	('cathedral', "St. Michael's Church", "Hamburg"),
	('cathedral', "St. Nicholas' Church", "Hamburg"),
	('monument', "Hermannsdenkmal", "North Rhine-Westphalia"),
	('castle', "Hohenzollern Castle", "Baden-Wurttemberg"),
	('castle', "Holstentor", "Schleswig-Holstein"),
	('castle', "Hornberg Castle (Neckarzimmern)", "Baden-Wurttemberg"),
	('cathedral', "Mainz Cathedral", "Rhineland-Palatinate"),
	('cathedral', "Worms Cathedral", "Rhineland-Palatinate"),
	('cathedral', "Speyer Cathedral", "Rhineland-Palatinate"),
	('cathedral', "Frankfurt Cathedral", "Hesse"),
	('cathedral', "Bamberg Cathedral", "Bavaria"),
	('cathedral', "Magdeburg Cathedral", "Saxony-Anhalt"),
	('cathedral', "Konigslutter Cathedral", "Lower Saxony"),
	('park', "Karlsaue", "Hesse"),
	('castle', "King's House on Schachen", "Bavaria"),
	('mountain', "Krayenberg", "Thuringia"),
	('castle', "Krayenburg", "Thuringia"),
	('castle', "Lichtenberg Castle (Palatinate)", "Rhineland-Palatinate"),
	('castle', "Lichtenstein Castle (Wurttemberg)", "Baden-Wurttemberg"),
	('castle', "Lissingen Castle", "Rhineland-Palatinate"),
	('castle', "Madenburg Castle", "Rhineland-Palatinate"),
	('castle', "Marienberg Fortress", "Bavaria"),
	('castle', "Mespelbrunn Castle", "Bavaria"),
	('park', "Muskau Park", "Saxony"),
	('castle', "Neuleiningen Castle", "Rhineland-Palatinate"),
	('castle', "Neuschwanstein Castle", "Bavaria"),
	('monument', "Niederwalddenkmal", "Hesse"),
	('castle', "Old Castle (Stuttgart)", "Baden-Wurttemberg"),
	('castle', "Pfalzgrafenstein Castle", "Rhineland-Palatinate"),
	('castle', "Ponttor", "North Rhine-Westphalia"),
	('castle', "Quedlinburg", "Saxony-Anhalt"),
	('mountain', "Rammelsberg", "Lower Saxony"),
	('castle', "Rheinfels Castle", "Rhineland-Palatinate"),
	('castle', "Rietburg", "Rhineland-Palatinate"),
	('castle', "Rotenhan Castle", "Bavaria"),
	('castle', "Steinsberg Castle", "Baden-Wurttemberg"),
	('castle', "Trifels Castle", "Rhineland-Palatinate"),
	('cathedral', "Ulm Minster", "Baden-Wurttemberg"),
	('castle', "Wartburg", "Thuringia"),
	('castle', "Wegelnburg", "Rhineland-Palatinate"),
	('castle', "Weikersheim Castle", "Baden-Wurttemberg"),
	('cathedral', "Wieskirche", "Bavaria"),
	('castle', "Wildenstein Castle (Leibertingen)", "Baden-Wurttemberg");

INSERT INTO state_politics
VALUES
	("Baden-Wurttemberg", "GRUNE", "CDU", 6),
	("Bavaria", "CSU", NULL, 6),
	("Berlin", "SPD", "LINKE", 4),
	("Brandenburg", "SPD", "LINKE", 4),
	("Bremen", "SPD", "GRUNE", 3),
	("Hamburg", "SPD", "GRUNE", 3),
	("Hesse", "CDU", "GRUNE", 5),
	("Lower Saxony", "SPD", "CDU", 6),
	("Mecklenburg-Vorpommern", "SPD", "CDU", 3),
	("North Rhine-Westphalia", "CDU", "FDP", 6),
	("Rhineland-Palatinate", "SPD", "FDP", 4),
	("Saarland", "CDU", "SPD", 3),
	("Saxony", "CDU", "SPD", 4),
	("Saxony-Anhalt", "CDU", "SPD", 4),
	("Schleswig-Holstein", "CDU", "GRUNE", 4),
	("Thuringia", "LINKE", "SPD", 4);




		



