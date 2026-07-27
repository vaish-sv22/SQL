-- 1. Create Index on Username
CREATE INDEX idx_username
ON Users(username);

-- 2. Create Index on Email
CREATE INDEX idx_email
ON Users(email);
-- Used for --
SELECT * FROM Users
WHERE email='alex@gmail.com';

-- 3. Create Index on Game Title
CREATE INDEX idx_game_title
ON Games(title);
-- Used for -- 
SELECT * FROM Games
WHERE title='Minecraft';

-- 4. Create Index on Game Price
CREATE INDEX idx_game_price
ON Games(price);
-- Used for --
SELECT * FROM Games
WHERE price > 2000;

-- 5. Create Index on Rating
CREATE INDEX idx_rating
ON Games(rating);
-- Used for --
SELECT * FROM Games
WHERE rating > 4.5;

-- 6. Create Composite Index
CREATE INDEX idx_country_wallet
ON Users(country, wallet_balance);
-- Used for --
SELECT * FROM Users
WHERE country='India'
AND wallet_balance > 500;

-- 7. Composite Index for Games
CREATE INDEX idx_price_rating
ON Games(price, rating);
-- Used for --
SELECT * FROM Games
WHERE price > 1000
AND rating > 4;

-- 8. Index for Purchases
CREATE INDEX idx_purchase_user
ON Purchases(user_id);
-- Used for --
SELECT * FROM Purchases
WHERE user_id = 1;

-- 9. Index for Game Purchases
CREATE INDEX idx_purchase_game
ON Purchases(game_id);

-- 10. Index for Reviews
CREATE INDEX idx_review_game
ON Reviews(game_id);

-- 11. Index for Reviews by User
CREATE INDEX idx_review_user
ON Reviews(user_id);

-- 12. Index for Leaderboards
CREATE INDEX idx_score
ON Leaderboards(score);
-- Used for --
SELECT * FROM Leaderboards
ORDER BY score DESC;

-- 13. Composite Index for Leaderboards
CREATE INDEX idx_game_score
ON Leaderboards(game_id, score);

-- 14. Index on Game Sessions
CREATE INDEX idx_session_user
ON GameSessions(user_id);

-- 15. Index on Login Time
CREATE INDEX idx_login_time
ON GameSessions(login_time);

-- UNIQUE INDEX --
-- 16. Unique Index on Developer Name
CREATE UNIQUE INDEX idx_unique_developer
ON Developers(developer_name);

-- This prevents duplicate developer names.
-- Show Indexes --
-- 17. Show Indexes in Users Table
SHOW INDEX
FROM Users;

-- 18. Show Indexes in Games Table
SHOW INDEX
FROM Games;

-- 19. Show Indexes in Purchases Table
SHOW INDEX
FROM Purchases;


-- 20.
SELECT * FROM Users
WHERE username='alex01';

-- 21.
SELECT * FROM Games
WHERE price > 2000;

-- 22.
SELECT * FROM Purchases
WHERE user_id=1;

-- 23.
SELECT * FROM Reviews
WHERE game_id=3;

-- Index with JOIN -- 
-- 24.
SELECT u.username,g.title
FROM Purchases p
INNER JOIN Users u
ON p.user_id=u.user_id
INNER JOIN Games g
ON p.game_id=g.game_id;

-- Index with ORDER BY --
-- 25.
SELECT * FROM Games
ORDER BY price;

-- 26.
SELECT * FROM Leaderboards
ORDER BY score DESC;

-- Index with GROUP BY -- 
-- 27.
SELECT game_id, COUNT(*)
FROM Purchases
GROUP BY game_id;

-- Drop Index --
-- 28.
DROP INDEX idx_login_time
ON GameSessions;

-- 29.
DROP INDEX idx_rating
ON Games;

-- Recreate Index --
CREATE INDEX idx_rating
ON Games(rating);

-- Index Information --
SHOW INDEX
FROM Leaderboards;

-- 30. Search User by Username
SELECT * FROM Users
WHERE username='alex01';

-- 31. Search Games Above ₹2500
SELECT * FROM Games
WHERE price>2500;

-- 32. Find Top Rated Games
SELECT * FROM Games
WHERE rating>=4.8;

-- 33. Find Purchases by User
SELECT * FROM Purchases
WHERE user_id=2;

-- 34. Review Search
SELECT * FROM Reviews
WHERE game_id=2;

-- 35. Sort Leaderboard
SELECT * FROM Leaderboards
ORDER BY score DESC;
