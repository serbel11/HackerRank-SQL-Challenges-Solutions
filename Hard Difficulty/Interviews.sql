WITH cont_chal AS (
    SELECT col.contest_id AS contest_id,
           chal.challenge_id AS challenge_id
    FROM Challenges AS chal JOIN Colleges AS col
         ON chal.college_id = col.college_id
),
v_chal AS (
    SELECT challenge_id,
           sum(total_views) AS total_views,
           sum(total_unique_views) AS total_unique_views           
    FROM view_stats
    GROUP BY challenge_id        
),
s_chal AS(
    SELECT challenge_id,
           sum(total_submissions) AS total_submissions,
           sum(total_accepted_submissions) AS total_accepted_submissions
    FROM submission_stats
    GROUP BY challenge_id      
)

SELECT DISTINCT c.contest_id,
       c.hacker_id,
       c.name,
       sum(s.total_submissions),
       sum(s.total_accepted_submissions),
       sum(v.total_views),
       sum(v.total_unique_views)
FROM Contests AS c join cont_chal AS cc 
     ON cc.contest_id = c.contest_id
     LEFT JOIN s_chal AS s
     ON s.challenge_id = cc.challenge_id
     LEFT JOIN v_chal AS v
     ON v.challenge_id = cc.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
ORDER BY c.contest_id
         