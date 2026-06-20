CREATE DATABASE international_debt_analysis;
Use international_debt_analysis;

-- ============================================================
-- BASIC QUERIES
-- ============================================================

-- 1. Retrieve all distinct country names from the dataset.
SELECT DISTINCT country_name
FROM countries;

-- 2. Count the total number of countries available.
SELECT COUNT(*) AS total_countries
FROM countries;

-- 3. Find the total number of indicators present.
SELECT COUNT(*) AS total_indicators
FROM indicators;

-- 4. Display the first 10 records of the dataset.
SELECT *
FROM debt_data
LIMIT 10;

-- 5. Calculate the total global debt.
SELECT SUM(value) AS total_global_debt
FROM debt_data;

-- 6. List all unique indicator names.
SELECT DISTINCT indicator_name
FROM indicators;

-- 7. Find the number of records for each country.
SELECT c.country_name,
       COUNT(*) AS total_records
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_records DESC;

-- 8. Display all records where debt is greater than 1 billion USD.
SELECT *
FROM debt_data
WHERE value > 1000000000;

-- 9. Find the minimum, maximum, and average debt values.
SELECT MIN(value) AS minimum_debt,
       MAX(value) AS maximum_debt,
       AVG(value) AS average_debt
FROM debt_data;

-- 10. Count total number of records in the dataset.
SELECT COUNT(*) AS total_records
FROM debt_data;


-- ============================================================
-- INTERMEDIATE QUERIES
-- ============================================================

-- 11. Find the total debt for each country.
SELECT c.country_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_debt DESC;

-- 12. Display the top 10 countries with the highest total debt.
SELECT c.country_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_debt DESC
LIMIT 10;

-- 13. Find the average debt per country.
SELECT c.country_name,
       AVG(d.value) AS average_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY average_debt DESC;

-- 14. Calculate total debt for each indicator.
SELECT i.indicator_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN indicators i
ON d.series_code = i.series_code
GROUP BY i.indicator_name
ORDER BY total_debt DESC;

-- 15. Identify the indicator contributing the highest total debt.
SELECT i.indicator_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN indicators i
ON d.series_code = i.series_code
GROUP BY i.indicator_name
ORDER BY total_debt DESC
LIMIT 1;

-- 16. Find the country with the lowest total debt.
SELECT c.country_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_debt ASC
LIMIT 1;

-- 17. Calculate total debt for each country and indicator combination.
SELECT c.country_name,
       i.indicator_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
JOIN indicators i
ON d.series_code = i.series_code
GROUP BY c.country_name,
         i.indicator_name
ORDER BY c.country_name;

-- 18. Count how many indicators each country has.
SELECT c.country_name,
       COUNT(DISTINCT d.series_code) AS total_indicators
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_indicators DESC;

-- 19. Display countries whose total debt is above the global average.
SELECT country_name,
       total_debt
FROM
(
     SELECT c.country_name,
            SUM(d.value) AS total_debt
     FROM debt_data d
     JOIN countries c
     ON d.country_code = c.country_code
     GROUP BY c.country_name
) x
WHERE total_debt >
(
     SELECT AVG(country_total)
     FROM
     (
          SELECT SUM(value) AS country_total
          FROM debt_data
          GROUP BY country_code
     ) y
);

-- 20. Rank countries based on total debt (highest to lowest).
SELECT c.country_name,
       SUM(d.value) AS total_debt,
       RANK() OVER
       (
           ORDER BY SUM(d.value) DESC
       ) AS debt_rank
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name;


-- ============================================================
-- ADVANCED QUERIES
-- ============================================================

-- 21. Find the top 5 indicators contributing most to global debt.
SELECT i.indicator_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN indicators i
ON d.series_code = i.series_code
GROUP BY i.indicator_name
ORDER BY total_debt DESC
LIMIT 5;

-- 22. Calculate percentage contribution of each country to total global debt.
SELECT c.country_name,
       ROUND(
             SUM(d.value) * 100 /
             (SELECT SUM(value)
              FROM debt_data),
             2
       ) AS contribution_percentage
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY contribution_percentage DESC;

-- 23. Identify the top 3 countries for each indicator based on debt.
SELECT *
FROM
(
     SELECT i.indicator_name,
            c.country_name,
            SUM(d.value) AS total_debt,
            DENSE_RANK() OVER
            (
                PARTITION BY i.indicator_name
                ORDER BY SUM(d.value) DESC
            ) AS ranking
     FROM debt_data d
     JOIN countries c
     ON d.country_code = c.country_code
     JOIN indicators i
     ON d.series_code = i.series_code
     GROUP BY i.indicator_name,
              c.country_name
) x
WHERE ranking <= 3;

-- 24. Find the difference between maximum and minimum debt for each country.
SELECT c.country_name,
       MAX(d.value) - MIN(d.value) AS debt_difference
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY debt_difference DESC;

-- 25. Create a view for the top 10 countries with highest debt.
CREATE VIEW top10_countries AS
SELECT c.country_name,
       SUM(d.value) AS total_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_debt DESC
LIMIT 10;

-- To view the created view
SELECT *
FROM top10_countries;

-- 26. Categorize countries into High Debt, Medium Debt and Low Debt.
SELECT c.country_name,
       SUM(d.value) AS total_debt,
       CASE
           WHEN SUM(d.value) >= 1000000000000 THEN 'High Debt'
           WHEN SUM(d.value) >= 100000000000 THEN 'Medium Debt'
           ELSE 'Low Debt'
       END AS debt_category
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
ORDER BY total_debt DESC;

-- 27. Use window functions to calculate cumulative debt per country.
SELECT c.country_name,
       d.year,
       d.value,
       SUM(d.value) OVER
       (
           PARTITION BY c.country_name
           ORDER BY d.year
       ) AS cumulative_debt
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code;

-- 28. Find indicators where average debt is higher than overall average debt.
SELECT i.indicator_name,
       AVG(d.value) AS average_indicator_debt
FROM debt_data d
JOIN indicators i
ON d.series_code = i.series_code
GROUP BY i.indicator_name
HAVING AVG(d.value) >
(
      SELECT AVG(value)
      FROM debt_data
);

-- 29. Identify countries contributing more than 5% of global debt.
SELECT c.country_name,
       ROUND(
             SUM(d.value) * 100 /
             (SELECT SUM(value)
              FROM debt_data),
             2
       ) AS contribution_percentage
FROM debt_data d
JOIN countries c
ON d.country_code = c.country_code
GROUP BY c.country_name
HAVING contribution_percentage > 5
ORDER BY contribution_percentage DESC;

-- 30. Find the most dominant indicator (highest contribution) for each country.
SELECT *
FROM
(
     SELECT c.country_name,
            i.indicator_name,
            SUM(d.value) AS total_debt,
            ROW_NUMBER() OVER
            (
                PARTITION BY c.country_name
                ORDER BY SUM(d.value) DESC
            ) AS rn
     FROM debt_data d
     JOIN countries c
     ON d.country_code = c.country_code
     JOIN indicators i
     ON d.series_code = i.series_code
     GROUP BY c.country_name,
              i.indicator_name
) x
WHERE rn = 1;