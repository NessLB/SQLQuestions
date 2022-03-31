USE world;

-- 1) Using COUNT, get the number of cities in the USA.
SELECT COUNT(name) FROM city WHERE countrycode = "USA";

-- 2) Find out the population and life expectancy for people in Argentina.
SELECT name, population, lifeexpectancy FROM country WHERE name = "Argentina";

-- 3) Using IS NOT NULL, ORDER BY, and LIMIT, which country has the highest life expectancy?
SELECT country.name, LifeExpectancy FROM country 
WHERE LifeExpectancy IS NOT NULL
ORDER BY LifeExpectancy DESC LIMIT 1;

-- 4) Using JOIN ... ON, find the capital city of Spain.
SELECT name FROM city
WHERE id = (
	SELECT DISTINCT(capital) FROM city
	JOIN country ON city.countrycode = country.code
	WHERE country.code = "ESP");

-- 5) Using JOIN ... ON, list all the languages spoken in the Southeast Asia region.
SELECT DISTINCT(countrylanguage.language) FROM countrylanguage
JOIN country ON countrylanguage.countrycode = country.code
WHERE country.region = "Southeast Asia";

-- 6) Using a single query, list 25 cities around the world that start with the letter F.
SELECT city.name FROM city WHERE city.name LIKE "F%" LIMIT 25;

-- 7) Using COUNT and JOIN ... ON, get the number of cities in China.
SELECT COUNT(city.name) FROM city
JOIN country ON city.countrycode = country.code
WHERE country.code = "CHN";

-- 8) Using IS NOT NULL, ORDER BY, and LIMIT, which country has the lowest population? Discard non-zero populations.
SELECT country.name, population FROM country 
WHERE population > 0
ORDER BY population ASC LIMIT 1;

-- 9) Using aggregate functions, return the number of countries the database contains.
SELECT COUNT(code) FROM country;

-- 10) What are the top ten largest countries by area?
SELECT country.name, surfacearea FROM country ORDER BY surfacearea DESC LIMIT 10;

-- 11) List the five largest cities by population in Japan.
SELECT city.name, population FROM city 
WHERE countrycode = "JPN"
ORDER BY population DESC LIMIT 5;

-- 12) List the names and country codes of every country with Elizabeth II as its Head of State. You will need to fix the mistake first!
SELECT country.name, country.code FROM country WHERE headofstate = "Elisabeth II";

-- 13) List the top ten countries with the smallest population-to-area ratio. Discard any countries with a ratio of 0.
SELECT name, population/surfacearea AS density FROM country
WHERE population/surfacearea > 0
ORDER BY density LIMIT 10;

-- 14) List every unique world language.
SELECT DISTINCT(language) FROM countrylanguage;

-- 15) List the names and GNP of the world's top 10 richest countries.
SELECT country.name, gnp FROM country ORDER BY gnp DESC LIMIT 10;

-- 16) List the names of, and number of languages spoken by, the top ten most multilingual countries.
CREATE VIEW countrylang AS
	SELECT * FROM country AS c
	JOIN countrylanguage AS cl ON c.code = cl.countrycode;

SELECT name, COUNT(language) AS no_of_lang FROM countrylang
GROUP BY name
ORDER BY no_of_lang DESC LIMIT 10;

-- 17) List every country where over 50% of its population can speak German.
SELECT country.name FROM country
JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE language = "German" AND percentage > 50.0;

-- 18) Which country has the worst life expectancy? Discard zero or null values.
SELECT country.name, lifeexpectancy FROM country 
WHERE lifeexpectancy != 0 OR lifeexpectancy != NULL
ORDER BY lifeexpectancy ASC LIMIT 1;

-- 19) List the top three most common government forms.
SELECT governmentform, COUNT(governmentform) AS gfcount FROM country
GROUP BY governmentform
ORDER BY gfcount DESC LIMIT 3;

-- 20) How many countries have gained independence since records began?
SELECT COUNT(country.name) FROM country WHERE indepyear > 10;