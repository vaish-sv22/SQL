-- ACID Properties
-- Property	    Description
-- Atomicity	Either all operations succeed or none do.
-- Consistency	Database always remains valid.
-- Isolation	Concurrent transactions don't interfere with each other.
-- Durability	Committed data is permanently saved.

-- 1. Basic Transaction
START TRANSACTION;
UPDATE Users
SET wallet_balance = wallet_balance - 100
WHERE user_id = 1;
UPDATE Users
SET wallet_balance = wallet_balance + 100
WHERE user_id = 2;
COMMIT;

-- 2. Transaction with ROLLBACK
START TRANSACTION;
UPDATE Users
SET wallet_balance = wallet_balance - 500
WHERE user_id = 1;
ROLLBACK;

-- 3. Transaction with SAVEPOINT
START TRANSACTION;
UPDATE Users
SET wallet_balance = wallet_balance - 200
WHERE user_id = 1;
SAVEPOINT WalletUpdated;
UPDATE Games
SET price = price + 500
WHERE game_id = 2;
ROLLBACK TO WalletUpdated;
COMMIT;

-- 4. Multiple SAVEPOINTS
START TRANSACTION;
SAVEPOINT A;
UPDATE Users
SET wallet_balance = wallet_balance + 100;
SAVEPOINT B;
UPDATE Games
SET price = price + 200;
ROLLBACK TO B;
COMMIT;

-- 5. Release SAVEPOINT
START TRANSACTION;
SAVEPOINT TestPoint;
UPDATE Users
SET wallet_balance = wallet_balance + 50
WHERE user_id = 3;
RELEASE SAVEPOINT TestPoint;
COMMIT;

-- COMMON TABLE EXPRESSIONS (CTEs)
-- 6. Display Expensive Games
WITH ExpensiveGames AS
(
SELECT *
FROM Games
WHERE price>2000
)
SELECT *
FROM ExpensiveGames;

-- 7. Premium Users
WITH PremiumUsers AS
(
SELECT * FROM Users
WHERE wallet_balance>1500
)
SELECT *
FROM PremiumUsers;

-- 8. Revenue Report
WITH Revenue AS
(
SELECT game_id, SUM(amount_paid) Revenue
FROM Purchases
GROUP BY game_id
)
SELECT * FROM Revenue;

-- 9. Average Ratings
WITH Ratings AS
(
SELECT game_id, AVG(rating) Rating
FROM Reviews
GROUP BY game_id
)
SELECT * FROM Ratings;

-- 10. Join with CTE
WITH Revenue AS
(
SELECT game_id, SUM(amount_paid) Revenue
FROM Purchases
GROUP BY game_id
)
SELECT g.title, Revenue
FROM Revenue
JOIN Games g
ON Revenue.game_id=g.game_id;

-- 11. Multiple CTEs -- 
WITH Revenue AS
(
SELECT game_id, SUM(amount_paid) Revenue
FROM Purchases
GROUP BY game_id
),
Ratings AS
(
SELECT game_id, AVG(rating) Rating
FROM Reviews
GROUP BY game_id
)
SELECT g.title, Revenue, Rating
FROM Games g
LEFT JOIN Revenue
ON g.game_id=Revenue.game_id
LEFT JOIN Ratings
ON g.game_id=Ratings.game_id;

-- Recursive CTE --
-- 12. Generate Numbers 1–10
WITH RECURSIVE Numbers AS
(
SELECT 1 AS num
UNION ALL
SELECT num+1
FROM Numbers
WHERE num<10
)
SELECT * FROM Numbers;

-- 13. Countdown
WITH RECURSIVE CountDown AS
(
SELECT 10 AS Number
UNION ALL
SELECT Number-1
FROM CountDown
WHERE Number>1
)
SELECT * FROM CountDown;

-- WINDOW FUNCTIONS -- 
-- 14. ROW_NUMBER()
SELECT title, price,
ROW_NUMBER() OVER
(
ORDER BY price DESC
)
AS RowNo
FROM Games;

-- 15. RANK()
SELECT title, rating,
RANK()
OVER
(
ORDER BY rating DESC
)
AS Ranking
FROM Games;

-- 16. DENSE_RANK()
SELECT title, rating,
DENSE_RANK()
OVER
(
ORDER BY rating DESC
)
AS DenseRanking
FROM Games;

-- 17. NTILE()
SELECT title, price,
NTILE(4)
OVER
(
ORDER BY price
)
AS Price_Group
FROM Games;

-- 18. LAG()
SELECT title, price,
LAG(price)
OVER
(
ORDER BY price
)
AS PreviousPrice
FROM Games;

-- 19. LEAD()
SELECT title, price,
LEAD(price)
OVER
(
ORDER BY price
)
AS NextPrice
FROM Games;

-- 20. FIRST_VALUE()
SELECT title, price,
FIRST_VALUE(price)
OVER
(
ORDER BY price DESC
)
AS HighestPrice
FROM Games;

-- 21. LAST_VALUE()
SELECT title, price,
LAST_VALUE(price)
OVER
(
ORDER BY price
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING
)
AS LowestPrice
FROM Games;

-- 22. Running Total
SELECT purchase_id, amount_paid, SUM(amount_paid)
OVER
(
ORDER BY purchase_id
)
AS RunningTotal
FROM Purchases;

-- 23. Moving Average
SELECT purchase_id, amount_paid, AVG(amount_paid)
OVER
(
ORDER BY purchase_id
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
)
AS MovingAverage
FROM Purchases;

-- 24. Highest Spending Users
SELECT u.username, SUM(p.amount_paid) TotalSpent,
RANK()
OVER
(
ORDER BY SUM(p.amount_paid) DESC
)
AS SpendingRank
FROM Users u
JOIN Purchases p
ON u.user_id=p.user_id
GROUP BY u.username;

-- 25. Most Played Users
SELECT u.username, SUM(gs.hours_played) Hours,
ROW_NUMBER()
OVER
(
ORDER BY SUM(gs.hours_played) DESC
)
AS Position
FROM Users u
JOIN GameSessions gs
ON u.user_id=gs.user_id
GROUP BY u.username;

-- 26. Top Rated Games
SELECT title, rating,
DENSE_RANK()
OVER
(
ORDER BY rating DESC
)
AS RankNo
FROM Games;

-- 27. Revenue Ranking
SELECT g.title, SUM(p.amount_paid) Revenue,
RANK()
OVER
(
ORDER BY SUM(p.amount_paid) DESC
)
AS RevenueRank
FROM Games g
JOIN Purchases p
ON g.game_id=p.game_id
GROUP BY g.title;

-- 28. Partition By Country
SELECT username, country, wallet_balance,
RANK()
OVER
(
PARTITION BY country
ORDER BY wallet_balance DESC
)
AS CountryRank
FROM Users;

-- 29. Partition By Game
SELECT game_id, user_id, score,
ROW_NUMBER()
OVER
(
PARTITION BY game_id
ORDER BY score DESC
)
AS Position
FROM Leaderboards;

-- 30. Final Dashboard Query
WITH Revenue AS
(
SELECT game_id, SUM(amount_paid) Revenue
FROM Purchases
GROUP BY game_id
)
SELECT g.title, g.rating, Revenue,
DENSE_RANK()
OVER
(
ORDER BY Revenue DESC
)
AS RevenueRank
FROM Games g
LEFT JOIN Revenue
ON g.game_id=Revenue.game_id;

-- SHOW TRANSACTIONS (Session Status)
SHOW VARIABLES LIKE 'autocommit';

-- Enable Autocommit
SET autocommit=1;

-- Disable Autocommit
SET autocommit=0;

