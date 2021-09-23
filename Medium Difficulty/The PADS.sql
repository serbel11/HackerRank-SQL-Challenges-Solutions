SELECT CONCAT(name, '(', substring(occupation, 1, 1), ')')
FROM OCCUPATIONS 
ORDER BY name

SELECT CONCAT('There are a total of ', COUNT(name), ' ', lower(occupation), 's.')
FROM OCCUPATIONS 
GROUP BY occupation
ORDER BY COUNT(name)