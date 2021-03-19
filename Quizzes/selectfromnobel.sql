-- https://sqlzoo.net/wiki/Nobel_Quiz

-- 1. Pick the code which shows the name of winner's names beginning with C and ending in n 

e.
SELECT winner FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n'

-- 2. Select the code that shows how many Chemistry awards were given between 1950 and 1960 

c.
SELECT COUNT(subject) FROM nobel
WHERE subject = 'Chemistry'
AND yr BETWEEN 1950 and 1960

-- 3. Pick the code that shows the amount of years where no Medicine awards were given 

b.
SELECT COUNT(DISTINCT yr) FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

/*
4. Select the result that would be obtained from the following code:

SELECT subject, winner FROM nobel WHERE winner LIKE 'Sir%' AND yr LIKE '196%'
*/

c.
Medicine	Sir John Eccles
Medicine	Sir Frank Macfarlane Burnet

-- 5. Select the code which would show the year when neither a Physics or Chemistry award was given 

c.
SELECT yr FROM nobel
WHERE yr NOT IN(SELECT yr 
FROM nobel
WHERE subject IN ('Chemistry','Physics'))

-- 6. Select the code which shows the years when a Medicine award was given but no Peace or Literature award was 

c.
SELECT DISTINCT yr
FROM nobel
WHERE subject='Medicine' 
AND yr NOT IN(SELECT yr FROM nobel 
WHERE subject='Literature')
AND yr NOT IN (SELECT yr FROM nobel
WHERE subject='Peace')

/*
7. Pick the result that would be obtained from the following code:

SELECT subject, COUNT(subject) 
FROM nobel 
WHERE yr ='1960' 
GROUP BY subject
*/

d.
Chemistry	  1
Literature	1
Medicine	  2
Peace	      1
Physics	    1