-- 1. Display All Users
DELIMITER $$
CREATE PROCEDURE GetAllUsers()
BEGIN
    SELECT * FROM Users;
END $$

DELIMITER ;
-- to Run
CALL GetAllUsers();

-- 2. Display All Games
DELIMITER $$
CREATE PROCEDURE GetAllGames()
BEGIN
    SELECT * FROM Games;
END $$
DELIMITER ;
-- to Run
CALL GetAllGames();

-- 3. Find User by ID (IN Parameter)
DELIMITER $$
CREATE PROCEDURE GetUserById
(
    IN p_user_id INT
)
BEGIN
SELECT * FROM Users
WHERE user_id = p_user_id;
END $$
DELIMITER ;
-- to Run
CALL GetUserById(3);

-- 4. Find Game by ID
DELIMITER $$
CREATE PROCEDURE GetGameById
(
IN p_game_id INT
)
BEGIN
SELECT * FROM Games
WHERE game_id=p_game_id;
END $$
DELIMITER ;
-- to Run
CALL GetGameById(5);

-- 5. Games Above Given Price
DELIMITER $$
CREATE PROCEDURE GamesAbovePrice
(
IN p_price DECIMAL(10,2)
)
BEGIN
SELECT * FROM Games
WHERE price>p_price;
END $$
DELIMITER ;
-- to Run
CALL GamesAbovePrice(2000);

-- 6. Users by Country
DELIMITER $$
CREATE PROCEDURE UsersByCountry
(
IN p_country VARCHAR(50)
)
BEGIN
SELECT * FROM Users
WHERE country=p_country;
END $$
DELIMITER ;
-- to Run
CALL UsersByCountry('India');

-- 7. Purchases of a User
DELIMITER $$
CREATE PROCEDURE UserPurchases
(
IN p_user INT
)
BEGIN
SELECT p.purchase_id, g.title, p.amount_paid, p.purchase_date
FROM Purchases p
INNER JOIN Games g
ON p.game_id=g.game_id
WHERE p.user_id=p_user;
END $$
DELIMITER ;
-- to Run
CALL UserPurchases(1);

-- 8. Reviews of a Game
DELIMITER $$
CREATE PROCEDURE GameReviews
(
IN p_game INT
)
BEGIN
SELECT u.username, r.rating, r.review
FROM Reviews r
INNER JOIN Users u
ON r.user_id=u.user_id
WHERE r.game_id=p_game;
END $$
DELIMITER ;
-- to Run
CALL GameReviews(2);

-- 9. Total Revenue (OUT Parameter)
DELIMITER $$
CREATE PROCEDURE TotalRevenue
(
OUT total DECIMAL(10,2)
)
BEGIN
SELECT SUM(amount_paid)
INTO total
FROM Purchases;
END $$
DELIMITER ;
-- tp Run
CALL TotalRevenue(@Revenue);
SELECT @Revenue;

-- 10. Count Total Users (OUT)
DELIMITER $$
CREATE PROCEDURE TotalUsers
(
OUT Total INT
)
BEGIN
SELECT COUNT(*)
INTO Total
FROM Users;
END $$
DELIMITER ;
-- to Run
CALL TotalUsers(@Users);
SELECT @Users;

-- 11. Count Games (OUT)
DELIMITER $$
CREATE PROCEDURE TotalGames
(
OUT Games INT
)
BEGIN
SELECT COUNT(*)
INTO Games
FROM Games;
END $$
DELIMITER ;
-- to Run
CALL TotalGames(@Games);
SELECT @Games;

-- 12. Highest Game Price
DELIMITER $$
CREATE PROCEDURE HighestPrice
(
OUT Price DECIMAL(10,2)
)
BEGIN
SELECT MAX(price)
INTO Price
FROM Games;
END $$
DELIMITER ;
-- to Run
CALL HighestPrice(@Highest);
SELECT @Highest;

-- 13. INOUT Parameter Example
DELIMITER $$
CREATE PROCEDURE DoubleWallet
(
INOUT amount DECIMAL(10,2)
)
BEGIN
SET amount = amount * 2;
END $$
DELIMITER ;
-- to Run
SET @Balance=500;
CALL DoubleWallet(@Balance);
SELECT @Balance;

-- 14. IF ELSE Example
DELIMITER $$
CREATE PROCEDURE CheckGamePrice
(
IN p_price DECIMAL(10,2)
)
BEGIN
IF p_price>3000 THEN
SELECT 'Premium Game';
ELSE
SELECT 'Budget Game';
END IF;
END $$
DELIMITER ;
-- to Run
CALL CheckGamePrice(3500);
CALL CheckGamePrice(1000);

-- 15. CASE Statement
DELIMITER $$
CREATE PROCEDURE PaymentStatus
(
IN Status VARCHAR(20)
)
BEGIN
CASE Status
WHEN 'Completed'
THEN SELECT 'Payment Successful';
WHEN 'Pending'
THEN SELECT 'Payment Pending';
WHEN 'Failed'
THEN SELECT 'Payment Failed';
ELSE
SELECT 'Unknown Status';
END CASE;
END $$
DELIMITER ;
-- to Run
CALL PaymentStatus('Completed');

-- 16. Total Revenue by Game
DELIMITER $$
CREATE PROCEDURE RevenueByGame()
BEGIN
SELECT g.title,
SUM(p.amount_paid) Revenue
FROM Games g
LEFT JOIN Purchases p
ON g.game_id=p.game_id
GROUP BY g.title;
END $$
DELIMITER ;
-- to Run
CALL RevenueByGame();

-- 17. Top Rated Games
DELIMITER $$
CREATE PROCEDURE TopRatedGames()
BEGIN
SELECT * FROM Games
ORDER BY rating DESC;
END $$
DELIMITER ;
-- to Run
CALL TopRatedGames();

-- 18. Most Played Users
DELIMITER $$
CREATE PROCEDURE MostPlayedUsers()
BEGIN
SELECT u.username, SUM(gs.hours_played) TotalHours
FROM Users u
INNER JOIN GameSessions gs
ON u.user_id=gs.user_id
GROUP BY u.username
ORDER BY TotalHours DESC;
END $$
DELIMITER ;
-- to Run
CALL MostPlayedUsers();

-- 19. Leaderboard Report
DELIMITER $$
CREATE PROCEDURE LeaderboardReport()
BEGIN
SELECT g.title, u.username, l.score, l.rank_position
FROM Leaderboards l
INNER JOIN Games g
ON l.game_id=g.game_id
INNER JOIN Users u
ON l.user_id=u.user_id
ORDER BY l.rank_position;
END $$
DELIMITER ;
-- to Run
CALL LeaderboardReport();

-- 20. Drop Procedure
DROP PROCEDURE IF EXISTS LeaderboardReport;

-- 21. Show All Procedures
SHOW PROCEDURE STATUS
WHERE Db='GamingPlatformDB';

-- 22. Show Procedure Definition
SHOW CREATE PROCEDURE GetAllUsers;

