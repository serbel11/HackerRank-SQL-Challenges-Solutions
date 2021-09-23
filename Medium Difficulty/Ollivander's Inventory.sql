WITH wands_rating AS(
SELECT W.id as id,
       WP.age as age,
       W.coins_needed as coins,
       W.[power] as pow,
       ROW_NUMBER() OVER(
           PARTITION BY age, W.[power]
           ORDER BY W.coins_needed
       ) as row_num
FROM WANDS AS W INNER JOIN WANDS_PROPERTY AS WP
ON W.CODE = WP.CODE AND WP.is_evil = 0
)

SELECT id, age, coins, pow
FROM wands_rating
WHERE row_num = 1
ORDER BY pow DESC, age DESC;