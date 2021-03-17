-- This tutorial looks at how we can use SELECT statements within SELECT statements to perform more complex queries. 

-- 1. Bigger than Russia
-- List each country name where the population is larger than that of 'Russia'. 

SELECT name 
FROM world
WHERE population > (SELECT population FROM world WHERE name='Russia')

-- 2. Richer than UK
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name 
FROM world
WHERE gdp/population > ( SELECT gdp/population FROM world WHERE name = 'United Kingdom' ) AND continent = 'Europe'

-- 3. Neighbours of Argentina and Australia
-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE continent = 'Oceania' OR continent = 'South America'
ORDER BY name

-- 4. Between Canada and Poland
-- Which country has a population that is more than Canada but less than Poland? Show the name and the population.

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') 
AND population < (SELECT population FROM world WHERE name = 'Poland')

-- 5. Percentages of Germany
-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name,
   CONCAT(ROUND(100 * population/(SELECT population FROM world WHERE name='Germany'), 0),'%')
FROM world
WHERE continent='Europe'

-- 6. Bigger than every country in Europe
-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0)