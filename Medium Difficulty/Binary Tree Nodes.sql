SELECT N,
    CASE 
        WHEN P is NULL THEN 'Root'
        WHEN (N IN(SELECT P FROM BST)) THEN 'Inner'
        ELSE 'Leaf'
    END AS type_node
FROM BST
ORDER BY N