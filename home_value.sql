-- get number of unique zip codes and group by state
SELECT state, COUNT(DISTINCT zip_code)
FROM home_value
GROUP BY state;

-- get a list of all years
SELECT DISTINCT(SUBSTR(date, 1, 4)) AS 'year'
FROM home_value;

-- get a list of years and months: most recent data is form November 2018
SELECT DISTINCT date
FROM home_value
ORDER BY date DESC;

-- median home value for the most recent month by state in descending order
SELECT state, value
FROM home_value
WHERE date = '2018-11'
GROUP BY state
ORDER BY value DESC;

-- average home value for 2017 state in descending order
SELECT state, ROUND(AVG(value)) AS 'average value'
FROM home_value
WHERE SUBSTR(date,1,4) = '2017'
GROUP BY state
ORDER BY 2 DESC;

-- average home value for 2007 state in descending order
SELECT state, ROUND(AVG(value)) AS 'average value'
FROM home_value
WHERE SUBSTR(date,1,4) = '2007'
GROUP BY state
ORDER BY 2 DESC;

-- average home value for 1997 state in descending order
SELECT state, ROUND(AVG(value)) AS 'average value'
FROM home_value
WHERE SUBSTR(date,1,4) = '1997'
GROUP BY state
ORDER BY 2 DESC;

-- percent change in average yearly home value from 2007 to 2017
WITH
start_year AS (
	SELECT
		state,
		AVG(value) AS 'start_value'
	FROM home_value
	WHERE SUBSTR(date,1,4) = '2007'
	GROUP BY 1
),

end_year AS (
	SELECT
		state,
		AVG(value) AS 'end_value'
	FROM home_value
	WHERE SUBSTR(date,1,4) = '2017'
	GROUP BY 1
),

combine AS (
	SELECT start_year.state, start_value, end_value
	FROM start_year
	JOIN end_year
		ON start_year.state = end_year.state
)

SELECT state, ROUND(100*(end_value - start_value)/start_value) AS 'percent change'
FROM combine
ORDER BY 2 DESC;

-- percent change in average yearly home value from 1997 to 2017
WITH
start_year AS (
	SELECT
		state,
		AVG(value) AS 'start_value'
	FROM home_value
	WHERE SUBSTR(date,1,4) = '1997'
	GROUP BY 1
),

end_year AS (
	SELECT
		state,
		AVG(value) AS 'end_value'
	FROM home_value
	WHERE SUBSTR(date,1,4) = '2017'
	GROUP BY 1
),

combine AS (
	SELECT start_year.state, start_value, end_value
	FROM start_year
	JOIN end_year
		ON start_year.state = end_year.state
)

SELECT state, ROUND(100*(end_value - start_value)/start_value) AS 'percent change'
FROM combine
ORDER BY 2 DESC;


/* Based on this information I would invest in real estate in DC, because it has the largest percentage increase in average home value from 1997 to 2017 and the second largest from 2007 to 2017.  Therefore DC has a long and stable trend of growth, making it a relatively safe bet for investers.
An argument could be made to invest in North Dakota instead because it has the largest percentage increase from 2007 to 2017.
However in our most recent data (November 2018), DC has the 5th heighest median home value while North Dakota has the 37th.
Because of this, if we have enough money to invest in real estate in DC we stand to make much more than we could in North Dakota. */
