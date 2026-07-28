-- Function Syntax
DELIMITER $$
CREATE FUNCTION function_name(parameters)
RETURNS datatype
DETERMINISTIC
BEGIN

   -- SQL Statements
   RETURN value;
END $$
DELIMITER ;

-- 1. Add GST to Game Price
DELIMITER $$
CREATE FUNCTION AddGST(price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN price + (price * 0.18);
END $$
DELIMITER ;
-- to Run
SELECT title, price, AddGST(price) AS Price_With_GST
FROM Games;

-- 2. Discount Calculator
DELIMITER $$
CREATE FUNCTION DiscountPrice(price DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN price - (price * 0.10);
END $$
DELIMITER ;
-- to Run
SELECT title, price,DiscountPrice(price)
FROM Games;

-- 3. Wallet Bonus
DELIMITER $$
CREATE FUNCTION WalletBonus(balance DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
RETURN balance + 500;
END $$
DELIMITER ;
-- to Run
SELECT
username,
wallet_balance,
WalletBonus(wallet_balance)
FROM Users;

-- 4. Full Email
DELIMITER $$
CREATE FUNCTION EmailDomain(mail VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
RETURN SUBSTRING_INDEX(mail,'@',-1);
END $$
DELIMITER ;
-- to Run
SELECT username, email, EmailDomain(email)
FROM Users;

-- 5. Username Length
DELIMITER $$
CREATE FUNCTION UserNameLength(name VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
RETURN LENGTH(name);
END $$
DELIMITER ;
-- to Run
SELECT username, UserNameLength(username)
FROM Users;

-- 6. Current Year
DELIMITER $$
CREATE FUNCTION CurrentYear()
RETURNS INT
DETERMINISTIC
BEGIN
RETURN YEAR(CURDATE());
END $$
DELIMITER ;
-- to Run
SELECT CurrentYear();

-- 7. Using Functions in WHERE
SELECT username, wallet_balance
FROM Users
WHERE Membership(wallet_balance)='Gold';

-- 8. Using Functions in ORDER BY
SELECT title, price, AddGST(price)
FROM Games
ORDER BY AddGST(price) DESC;

-- 9. Using Functions in GROUP BY
SELECT PriceCategory(price), COUNT(*)
FROM Games
GROUP BY PriceCategory(price);

-- 10. Nested Functions
SELECT username, Membership(WalletBonus(wallet_balance))
FROM Users;

-- 11. Drop Function
DROP FUNCTION IF EXISTS WalletBonus;

-- 12. Show Functions
SHOW FUNCTION STATUS
WHERE Db='GamingPlatformDB';

-- 13. Show Function Definition
SHOW CREATE FUNCTION AddGST;

-- 14. Game Category
DELIMITER $$
CREATE FUNCTION PriceCategory(price DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
IF price>=3000 THEN
RETURN 'Premium';
ELSEIF price>=1500 THEN
RETURN 'Standard';
ELSE
RETURN 'Budget';
END IF;
END $$
DELIMITER ;
-- to Run
SELECT title,price, PriceCategory(price)
FROM Games;

-- 15. Rating Grade
DELIMITER $$
CREATE FUNCTION RatingGrade(r DECIMAL(3,2))
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
IF r>=4.8 THEN
RETURN 'A';
ELSEIF r>=4.5 THEN
RETURN 'B';
ELSEIF r>=4 THEN
RETURN 'C';
ELSE
RETURN 'D';
END IF;
END $$
DELIMITER ;
-- to Run
SELECT title, rating, RatingGrade(rating)
FROM Games;

-- 16. Total Purchase Amount of a User
DELIMITER $$
CREATE FUNCTION UserTotalPurchase(uid INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
DECLARE total DECIMAL(10,2);
SELECT IFNULL(SUM(amount_paid),0)
INTO total
FROM Purchases
WHERE user_id=uid;
RETURN total;
END $$
DELIMITER ;
-- to Run
SELECT username, UserTotalPurchase(user_id)
FROM Users;

-- 17. Number of Purchases
DELIMITER $$
CREATE FUNCTION PurchaseCount(uid INT)
RETURNS INT
READS SQL DATA
BEGIN
DECLARE total INT;
SELECT COUNT(*) INTO total
FROM Purchases
WHERE user_id=uid;
RETURN total;
END $$
DELIMITER ;
-- to Run
SELECT username, PurchaseCount(user_id)
FROM Users;

-- 18. Average Rating of Game
DELIMITER $$
CREATE FUNCTION AverageGameRating(gid INT)
RETURNS DECIMAL(3,2)
READS SQL DATA
BEGIN
DECLARE avgRating DECIMAL(3,2);
SELECT AVG(rating)
INTO avgRating
FROM Reviews
WHERE game_id=gid;
RETURN avgRating;
END $$
DELIMITER ;
-- to Run
SELECT title, AverageGameRating(game_id)
FROM Games;

-- 19. Number of Reviews
DELIMITER $$
CREATE FUNCTION ReviewCount(gid INT)
RETURNS INT
READS SQL DATA
BEGIN
DECLARE cnt INT;
SELECT COUNT(*) INTO cnt
FROM Reviews
WHERE game_id=gid;
RETURN cnt;
END $$
DELIMITER ;
-- to Run
SELECT title, ReviewCount(game_id)
FROM Games;

-- 20. Total Hours Played
DELIMITER $$
CREATE FUNCTION TotalHours(uid INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
DECLARE hrs DECIMAL(10,2);
SELECT IFNULL(SUM(hours_played),0)
INTO hrs
FROM GameSessions
WHERE user_id=uid;
RETURN hrs;
END $$
DELIMITER ;
-- to Run
SELECT username,TotalHours(user_id)
FROM Users;

-- 21. Age Calculator
DELIMITER $$
CREATE FUNCTION CalculateAge(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
RETURN TIMESTAMPDIFF(YEAR,dob,CURDATE());
END $$
DELIMITER ;
-- to Run
SELECT username, CalculateAge(date_of_birth)
FROM Users;

-- 22. Membership Status
DELIMITER $$
CREATE FUNCTION Membership(balance DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
CASE
WHEN balance>=2000 THEN
RETURN 'Platinum';
WHEN balance>=1000 THEN
RETURN 'Gold';
WHEN balance>=500 THEN
RETURN 'Silver';
ELSE
RETURN 'Bronze';
END CASE;
END $$
DELIMITER ;
-- to Run
SELECT username, wallet_balance, Membership(wallet_balance)
FROM Users;

