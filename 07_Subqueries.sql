-- Single Row Subqueries --
-- 1. Find the Most Expensive Game
SELECT * FROM Games
WHERE price = (SELECT MAX(price)
FROM Games
);

-- 2. Find the Cheapest Game 
SELECT * FROM Games
WHERE price = (SELECT MIN(price)
FROM Games
);

-- 3. Find Users with the Highest Wallet Balance 
SELECT * FROM Users
WHERE wallet_balance = (SELECT MAX(wallet_balance)
FROM Users
);

-- 4. Find Games Above Average Price 
SELECT * FROM Games
WHERE price >
(
    SELECT AVG(price)
    FROM Games
);

-- 5. Find Users Below Average Wallet Balance
SELECT * FROM Users
WHERE wallet_balance <
(
    SELECT AVG(wallet_balance)
    FROM Users
);

-- Multi Row Subqueries --
-- 6. Users Who Purchased Games
SELECT * FROM Users
WHERE user_id IN
(
    SELECT user_id
    FROM Purchases
);

-- 7. Users Who Never Purchased Any Game
SELECT * FROM Users
WHERE user_id NOT IN
(
    SELECT user_id
    FROM Purchases
);

-- 8. Games That Have Reviews
SELECT * FROM Games
WHERE game_id IN
(
    SELECT game_id
    FROM Reviews
);

-- 9. Games Without Reviews
SELECT * FROM Games
WHERE game_id NOT IN
(
    SELECT game_id
    FROM Reviews
);

-- 10. Developers Who Developed Games
SELECT * FROM Developers
WHERE developer_id IN
(
    SELECT developer_id
    FROM Games
);

-- EXISTS -- 
-- 11. Users Who Made Purchases
SELECT * FROM Users u
WHERE EXISTS
(
    SELECT 1
    FROM Purchases p
    WHERE u.user_id = p.user_id
);

-- 12. Games Purchased by At Least One User
SELECT * FROM Games g
WHERE EXISTS
(
    SELECT 1
    FROM Purchases p
    WHERE g.game_id = p.game_id
);

-- 13. Users Who Wrote Reviews
SELECT * FROM Users u
WHERE EXISTS
(
    SELECT 1
    FROM Reviews r
    WHERE u.user_id = r.user_id
);

-- NOT EXISTS --
-- 14. Users Without Purchases
SELECT * FROM Users u
WHERE NOT EXISTS
(
    SELECT 1
    FROM Purchases p
    WHERE u.user_id = p.user_id
);

-- 15. Games Never Purchased
SELECT * FROM Games g
WHERE NOT EXISTS
(
    SELECT 1
    FROM Purchases p
    WHERE g.game_id = p.game_id
);

-- ANY --
-- 16. Games Costlier Than At Least One Game
SELECT * FROM Games
WHERE price >
ANY
(
    SELECT price
    FROM Games
);

-- 17. Users With Wallet Greater Than Any Wallet Below ₹1000
SELECT * FROM Users
WHERE wallet_balance >
ANY
(
    SELECT wallet_balance
    FROM Users
    WHERE wallet_balance < 1000
);

-- ALL --
-- 18. Game With Highest Price Using ALL
SELECT * FROM Games
WHERE price >= ALL
(
    SELECT price
    FROM Games
);

-- 19. Highest Wallet Balance Using ALL
SELECT * FROM Users
WHERE wallet_balance >= ALL
(
    SELECT wallet_balance
    FROM Users
);

-- Correlated Subqueries --
-- 20. Users Spending Above Their Own Average Purchase
SELECT * FROM Purchases p1
WHERE amount_paid >
(
    SELECT AVG(amount_paid)
    FROM Purchases p2
    WHERE p1.user_id = p2.user_id
);

-- 21. Games Rated Above Overall Average
SELECT * FROM Reviews r
WHERE rating >
(
    SELECT AVG(rating)
    FROM Reviews
);

-- 22. Users With More Than One Purchase
SELECT * FROM Users u
WHERE
(
    SELECT COUNT(*)
    FROM Purchases p
    WHERE u.user_id = p.user_id
) > 1;

-- 23. Developers Having Multiple Games
SELECT * FROM Developers d
WHERE
(
    SELECT COUNT(*)
    FROM Games g
    WHERE d.developer_id = g.developer_id
) > 1;

-- (May return no rows with the current sample data) --
-- Nested Subqueries --

-- 24. Users Who Purchased the Most Expensive Game
SELECT * FROM Users
WHERE user_id IN
(
    SELECT user_id
    FROM Purchases
    WHERE game_id =
    (
        SELECT game_id
        FROM Games
        WHERE price =
        (
            SELECT MAX(price)
            FROM Games
        )
    )
);

-- 25. Highest Rated Purchased Game
SELECT * FROM Games
WHERE game_id IN
(
    SELECT game_id
    FROM Purchases
)
AND rating =
(
    SELECT MAX(rating)
    FROM Games
);

-- Subquery in SELECT --
-- 26. Display Game With Total Purchases
SELECT title,
(
SELECT COUNT(*)
FROM Purchases p
WHERE p.game_id = g.game_id
) AS Purchase_Count
FROM Games g;

-- 27. Display User With Purchase Count
SELECT username,
(
SELECT COUNT(*)
FROM Purchases p
WHERE p.user_id = u.user_id
) AS Purchases
FROM Users u;

-- 28. Display Developer With Number of Games
SELECT developer_name,
(
SELECT COUNT(*)
FROM Games g
WHERE g.developer_id=d.developer_id
) AS Total_Games
FROM Developers d;

-- Subquery in FROM --
-- 29. Average Purchase Amount
SELECT AVG(Total)
FROM
(
SELECT amount_paid AS Total
FROM Purchases
) PurchaseAmount;

-- 30. Highest Wallet Balance
SELECT MAX(Wallet)
FROM
(
SELECT wallet_balance AS Wallet
FROM Users
) UserWallet;

-- 31. Users Spending More Than Average
SELECT * FROM Users
WHERE user_id IN
(
SELECT user_id
FROM Purchases
GROUP BY user_id
HAVING SUM(amount_paid) >
(
SELECT AVG(amount_paid)
FROM Purchases
)
);

-- 32. Games Purchased More Than Once
SELECT * FROM Games
WHERE game_id IN
(
SELECT game_id
FROM Purchases
GROUP BY game_id
HAVING COUNT(*) > 1
);

-- 33. Most Purchased Game
SELECT * FROM Games
WHERE game_id=
(
SELECT game_id
FROM Purchases
GROUP BY game_id
ORDER BY COUNT(*) DESC
LIMIT 1
);

-- 34. Highest Revenue Game
SELECT *
FROM Games
WHERE game_id=
(
SELECT game_id
FROM Purchases
GROUP BY game_id
ORDER BY SUM(amount_paid) DESC
LIMIT 1
);

-- 35. Users With Highest Number of Purchases
SELECT * FROM Users
WHERE user_id IN
(
SELECT user_id
FROM Purchases
GROUP BY user_id
HAVING COUNT(*)=
(
SELECT MAX(PurchaseCount)
FROM
(
SELECT COUNT(*) AS PurchaseCount
FROM Purchases
GROUP BY user_id
) X
)
);
