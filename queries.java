"SELECT state_name, population FROM state WHERE population > " + num + ";"

"SELECT state_name, population FROM state WHERE population < " + num + ";"

"SELECT name, population FROM city WHERE population < " + num + ";"

"SELECT name, population FROM city WHERE population > " + num + ";"

"SELECT party_name, membership FROM politics WHERE membership > " + num + ";"

"SELECT lm_name, state FROM landmark WHERE type = \"" + type + "\";"

"SELECT lm_name, type FROM landmark WHERE state = \"" + state + "\";"

"SELECT state_name, population FROM state ORDER BY population desc LIMIT " + num + ";"

"SELECT state, COUNT(*) FROM city GROUP BY state ORDER BY COUNT(*) desc LIMIT " + num + ";"

"SELECT state, COUNT(*) FROM landmark GROUP BY state ORDER BY COUNT(*) desc LIMIT " + num + ";"

"SELECT name, population FROM city ORDER BY population desc LIMIT " + num + ";"

"SELECT party_name, membership FROM politics ORDER BY membership desc LIMIT " + num + ";"

"SELECT party1, COUNT(*) FROM state_politics GROUP BY party1 ORDER BY COUNT(*) desc LIMIT " + num + ";"



