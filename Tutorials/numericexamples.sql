-- https://sqlzoo.net/wiki/NSS_Tutorial

/*
1. Check out one row
The example shows the number who responded for:

  question 1
  at 'Edinburgh Napier University'
  studying '(8) Computer Science'

Show the the percentage who STRONGLY AGREE
*/

SELECT A_STRONGLY_AGREE
FROM nss
WHERE question = 'Q01'
AND institution = 'Edinburgh Napier University'
AND subject = '(8) Computer Science'

-- 2. Calculate how many agree or strongly agree
-- Show the institution and subject where the score is at least 100 for question 15. 

SELECT institution, subject
FROM nss
WHERE question = 'Q15'
AND score >= 100

-- 3. Unhappy Computer Students
-- Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15' 

SELECT institution, score
FROM nss
WHERE question = 'Q15'
AND score < 50
AND subject = '(8) Computer Science'

/*
4. More Computing or Creative Students?
Show the subject and total number of students who responded to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'. 

HINT: You will need to use SUM over the response column and GROUP BY subject
*/

SELECT subject, SUM(response)
FROM nss
WHERE question = 'Q22'
AND (subject = '(8) Computer Science' OR subject = '(H) Creative Arts and Design')
GROUP BY subject

/*
5. Strongly Agree Numbers
Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects '(8) Computer Science' and '(H) Creative Arts and Design'.

HINT: The A_STRONGLY_AGREE column is a percentage. To work out the total number of students who strongly agree you must multiply this percentage by the number who responded (response) and divide by 100 - take the SUM of that. 
*/ 

SELECT subject, SUM(response * A_STRONGLY_AGREE / 100)
FROM nss
WHERE question = 'Q22'
AND (subject = '(8) Computer Science' OR subject = '(H) Creative Arts and Design')
GROUP BY subject

/*
6. Strongly Agree, Percentage
Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' show the same figure for the subject '(H) Creative Arts and Design'.

Use the ROUND function to show the percentage without decimal places. 
*/

SELECT subject, ROUND(SUM(response * A_STRONGLY_AGREE/100) / SUM(response) * 100) 
FROM nss
WHERE question = 'Q22'
AND (subject = '(8) Computer Science' OR subject = '(H) Creative Arts and Design')
GROUP BY subject

/*
7. Scores for Institutions in Manchester
Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.

The column score is a percentage - you must use the method outlined above to multiply the percentage by the response and divide by the total response. Give your answer rounded to the nearest whole number. 
*/

SELECT institution, ROUND(SUM(response * score/100) / SUM(response) * 100) 
FROM nss
WHERE question = 'Q22'
AND (institution LIKE '%Manchester%')
GROUP BY institution

-- 8. Number of Computing Students in Manchester
-- Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'. 

SELECT institution, 
SUM(sample), 
SUM(CASE 
  WHEN subject='(8) Computer Science' 
  THEN sample
  ELSE 0 END) 
FROM nss
WHERE question='Q01' 
AND (institution LIKE '%Manchester%') 
GROUP BY institution