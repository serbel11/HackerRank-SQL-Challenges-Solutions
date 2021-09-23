WITH is_start_end AS (
     SELECT 
       ISNULL(DATEDIFF(day, LAG(end_date) OVER (ORDER BY start_date), start_date), 1) as is_start,
       *,
       ISNULL(DATEDIFF(day, end_date, LEAD(start_date) OVER (ORDER BY start_date)), 1) as is_end
     FROM Projects),
    
    start_end_without_zeroes AS(
        SELECT *
        FROM is_start_end
        WHERE is_start + is_end <> 0
    ),    

start_or_end as (SELECT start_date,
    CASE
       WHEN (is_start > 0 AND is_end = 0)
            THEN lead(end_date) OVER (ORDER BY start_date)
       WHEN (is_start > 0 AND is_end > 0)
            THEN end_date   
            ELSE NULL
       END as end_q
    FROM start_end_without_zeroes)

select *
FROM start_or_end 
WHERE end_q is not null
ORDER BY DATEDIFF(day, end_q, start_date) desc, start_date