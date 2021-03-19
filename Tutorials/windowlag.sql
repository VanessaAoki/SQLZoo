-- https://sqlzoo.net/wiki/Window_LAG

/*
1. Introducing the covid table
The example uses a WHERE clause to show the cases in 'Italy' in March.

SELECT name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

Modify the query to show data from Spain
*/

SELECT name, DAY(whn), confirmed, deaths, recovered
FROM covid
WHERE name = 'spain'
AND MONTH(whn) = 3
ORDER BY whn

/*
2. Introducing the LAG function
The LAG function is used to show data from the preceding row or the table. When lining up rows the data is partitioned by country name and ordered by the data whn. That means that only data from Italy is considered.

Modify the query to show confirmed for the day before.
Note on LAG with MySQL

There is a bug in MySQL that means that it reports an error when using SQL_MODE='ONLY_FULL_GROUP_BY'- this is the default for the rest of SQLZoo and needs to be turned off for this tutorial. https://jira.mariadb.org/browse/MDEV-17785
*/

SELECT name, DAY(whn), confirmed, LAG(confirmed, 1) 
OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

/*
3. Number of new cases
The number of confirmed case is cumulative - but we can use LAG to recover the number of new cases reported for each day.

Show the number of new cases for each day, for Italy, for March.
*/

SELECT name, DAY(whn), confirmed -LAG(confirmed, 1) 
OVER (PARTITION BY name ORDER BY whn) AS 'new cases'
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

/*
4. Weekly changes
The data gathered are necessarily estimates and are inaccurate. However by taking a longer time span we can mitigate some of the effects.

You can filter the data to view only Monday's figures WHERE WEEKDAY(whn) = 0.

Show the number of new cases in Italy for each week - show Monday only.
*/

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), confirmed - LAG(confirmed, 1) 
OVER (PARTITION BY name ORDER BY whn) AS 'new cases'
FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn

/*
5. LAG using a JOIN
You can JOIN a table using DATE arithmetic. This will give different results if data is missing.

Show the number of new cases in Italy for each week - show Monday only.

In the sample query we JOIN this week tw with last week lw using the DATE_ADD function. 
*/

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), tw.confirmed - lw.confirmed AS 'new cases'
FROM covid tw LEFT JOIN covid lw ON DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn

/*
6. RANK()
The query shown shows the number of confirmed cases together with the world ranking for cases.

United States has the highest number, Spain is number 2...

Notice that while Spain has the second highest confirmed cases, Italy has the second highest number of deaths due to the virus.

Include the ranking for the number of deaths in the table.
*/

SELECT name, confirmed, 
RANK() OVER (ORDER BY confirmed DESC) rc,
deaths,
RANK() OVER (ORDER BY deaths DESC) rc
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

/*
7. Infection rate
The query shown includes a JOIN t the world table so we can access the total population of each country and calculate infection rates (in cases per 100,000).

Show the infect rate ranking for each country. Only include countries with a population of at least 10 million.
*/

SELECT world.name, ROUND(100000*confirmed/population,0) AS infect,
RANK() OVER(ORDER BY confirmed/population) AS rank
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' 
AND population > 10000000
ORDER BY population DESC

-- 8. Turning the corner
-- For each country that has had at last 1000 new cases in a single day, show the date of the peak number of new cases.

-- ??