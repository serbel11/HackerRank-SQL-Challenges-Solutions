WITH Num AS( SELECT *,
     ROW_NUMBER() OVER(PARTITION BY Occupation
                         ORDER BY Name, Occupation) as num
     FROM Occupations),
     
     NumD AS( SELECT *
     FROM Num
     WHERE Occupation = 'Doctor'),
     
     NumP AS( SELECT *
     FROM Num
     WHERE Occupation = 'Professor'),
     
     NumS AS( SELECT *
     FROM Num
     WHERE Occupation = 'Singer'),
     
     NumA AS( SELECT *
     FROM Num
     WHERE Occupation = 'Actor')
     

SELECT D.Name,
       P.Name,
       S.Name,
       A.Name    
FROM NumD AS D FULL OUTER JOIN NumP AS P ON D.num = P.num 
               FULL OUTER JOIN NumS AS S ON P.num = S.num 
               FULL OUTER JOIN NumA AS A ON S.num = A.num ;
