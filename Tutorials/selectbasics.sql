-- https://sqlzoo.net/wiki/SELECT_basics

/*
1.
The example uses a WHERE clause to show the population of 'France'. Note that strings (pieces of text that are data) should be in 'single quotes';

SELECT population FROM world
WHERE name = 'France'

Modify it to show the population of Germany
*/

SELECT population FROM world
WHERE name = 'Germany'

/*
2. Scandinavia
Checking a list The word IN allows us to check if an item is in a list. The example shows the name and population for the countries 'Brazil', 'Russia', 'India' and 'China'.

SELECT name, population FROM world
WHERE name IN ('Brazil', 'Russia', 'India', 'China');

Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
*/

SELECT name, population FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark')

/*
3. Just the right size
Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq. km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000. 

SELECT name, area FROM world
WHERE area BETWEEN 250000 AND 300000
*/

SELECT name, area FROM world
WHERE area BETWEEN 200000 AND 250000