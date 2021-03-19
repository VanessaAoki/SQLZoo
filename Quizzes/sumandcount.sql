-- https://sqlzoo.net/wiki/SUM_and_COUNT_Quiz

-- 1. Select the statement that shows the sum of population of all countries in 'Europe' 

c.
SELECT SUM(population) FROM bbc WHERE region = 'Europe'

-- 2. Select the statement that shows the number of countries with population smaller than 150000 

a.
SELECT COUNT(name) FROM bbc WHERE population < 150000

-- 3. Select the list of core SQL aggregate functions 

d.
AVG(), COUNT(), MAX(), MIN(), SUM()

-- 4. Select the result that would be obtained from the following code: 

e.
No result due to invalid use of the WHERE function

-- 5. Select the statement that shows the average population of 'Poland', 'Germany' and 'Denmark' 

b.
SELECT AVG(population) FROM bbc WHERE name IN ('Poland', 'Germany', 'Denmark')

-- 6. Select the statement that shows the medium population density of each region 

e.
SELECT region, SUM(population)/SUM(area) AS density FROM bbc GROUP BY region

-- 7. Select the statement that shows the name and population density of the country with the largest population 

d.
SELECT name, population/area AS density FROM bbc WHERE population = (SELECT MAX(population) FROM bbc)

-- 8. Pick the result that would be obtained from the following code: 

d.
Table-D
Americas	732240
Middle East	13403102
South America	17740392
South Asia	9437710