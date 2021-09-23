WITH num_hackers AS(
     SELECT submission_date,
            hacker_id,
            ROW_NUMBER() OVER(PARTITION BY hacker_id
                              ORDER BY submission_date) as row_num            
     FROM Submissions
     GROUP BY submission_date, hacker_id
),
calc_diff AS(
     SELECT *,
            ABS(DAY(submission_date) - row_num) as diff      
     FROM num_hackers
),
cnt_zeroes AS(
     SELECT *, COUNT(*) OVER(PARTITION BY hacker_id) AS cnt_zer
     FROM calc_diff
     WHERE diff = 0
),
max_subs_per_day AS(
     SELECT submission_date,
     hacker_id,
     COUNT(*) as subs_per_day
     FROM Submissions
     GROUP BY submission_date, hacker_id 
), 
rank_per_day AS(
     SELECT *,
            row_number() OVER (PARTITION BY submission_date
                        ORDER BY subs_per_day desc, hacker_id) as rank_per_day
     FROM max_subs_per_day
), 
unique_hackers AS(
     SELECT submission_date,
            COUNT(submission_date) as hackers_num
     FROM cnt_zeroes
     GROUP BY submission_date
)

SELECT unq.submission_date,
       unq.hackers_num,
       rnk.hacker_id,
       h.name
FROM unique_hackers as unq JOIN rank_per_day as rnk 
     ON unq.submission_date = rnk.submission_date AND rnk.rank_per_day = 1
     JOIN Hackers AS h 
     ON rnk.hacker_id = h.hacker_id
     
ORDER BY unq.submission_date