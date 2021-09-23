WITH CHALLENGES_CREATED AS(
SELECT DISTINCT H.HACKER_ID AS id,
       H.NAME AS name,
       COUNT(C.CHALLENGE_ID) OVER(
            PARTITION BY H.HACKER_ID
            ORDER BY H.NAME
       ) as count_chal
FROM HACKERS AS H INNER JOIN CHALLENGES AS C
ON H.HACKER_ID = C.HACKER_ID
),
CHALLENGES_CREATED_RNK AS(
    SELECT id, name, count_chal,
           COUNT(id) OVER(
           PARTITION BY count_chal) AS repeat_num
    FROM CHALLENGES_CREATED
)

SELECT id, name, count_chal
FROM CHALLENGES_CREATED_RNK
WHERE count_chal = (SELECT MAX(count_chal) FROM CHALLENGES_CREATED_RNK)
      OR repeat_num = 1
ORDER BY count_chal desc, id