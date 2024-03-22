# Data Cleaning and Exploratory Data Analysis project

# Data Cleaning

SELECT *
FROM world_life_expectancy
;

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

SELECT *
FROM(
	SELECT Row_ID,
	CONCAT(Country, Year),
	row_number() OVER(PARTITION BY CONCAT(Country, Year) 
    ORDER BY CONCAT (Country, YEAR)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM (
	SELECT Row_ID,
	CONCAT(Country, Year),
	row_number() OVER(PARTITION BY CONCAT(Country, Year) 
    ORDER BY CONCAT (Country, YEAR)) as Row_Num
	FROM world_life_expectancy
	) AS Row_table
WHERE Row_Num > 1)
;

SELECT *
FROM world_life_expectancy
WHERE Status = ''
;

SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <> ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing' 
;


SELECT *
FROM world_life_expectancy
WHERe Country = 'United States Of America'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed' 
;

SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
#WHERE `Life expectancy` = ''
;

SELECT t1.country, t1.Year, t1.`Life expectancy`, 
t2.country, t2.Year, t2.`Life expectancy`,
t3.country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) /2,1)
WHERE t1.`Life expectancy` = ''
;

