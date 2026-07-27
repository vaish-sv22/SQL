-- Syntax
CREATE VIEW view_name AS
SELECT column1, column2
FROM table_name;

-- 1. View All Users
CREATE VIEW View_All_Users AS
SELECT user_id, username, email, country, wallet_balance
FROM Users;
-- View Data
SELECT * FROM View_All_Users;

-- 2. View All Games
CREATE VIEW View_All_Games AS
SELECT game_id, title, price, rating
FROM Games;
-- View Data --
SELECT * FROM View_All_Games;

-- 4. View Free Games
CREATE VIEW Free_Games AS
SELECT game_id, title, price
FROM Games
WHERE price = 0;
-- View Data --
SELECT * FROM Free_Games;

-- 5. User Purchase History
CREATE VIEW User_Purchase_History AS
SELECT u.user_id, u.username, g.title, p.amount_paid, p.purchase_date
FROM Purchases p
INNER JOIN Users u
ON p.user_id = u.user_id
INNER JOIN Games g
ON p.game_id = g.game_id;
-- View Data --
SELECT * FROM User_Purchase_History;

-- 6. Payment Report
CREATE VIEW Payment_Report AS
SELECT u.username, g.title, pay.payment_method, pay.payment_status, p.amount_paid
FROM Payments pay
INNER JOIN Purchases p
ON pay.purchase_id = p.purchase_id
INNER JOIN Users u
ON p.user_id = u.user_id
INNER JOIN Games g
ON p.game_id = g.game_id;
-- View Data --
SELECT * FROM Payment_Report;

-- 7. Review Report
CREATE VIEW Review_Report AS
SELECT u.username, g.title, r.rating, r.review, r.review_date
FROM Reviews r
INNER JOIN Users u
ON r.user_id = u.user_id
INNER JOIN Games g
ON r.game_id = g.game_id;
-- View Data --
SELECT * FROM Review_Report;

-- 8. Achievement Report
CREATE VIEW Achievement_Report AS
SELECT u.username, g.title, a.achievement_name, a.points
FROM UserAchievements ua
INNER JOIN Users u
ON ua.user_id = u.user_id
INNER JOIN Achievements a
ON ua.achievement_id = a.achievement_id
INNER JOIN Games g
ON a.game_id = g.game_id;
-- View Data --
SELECT * FROM Achievement_Report;

-- 9. Leaderboard View
CREATE VIEW Leaderboard_View AS
SELECT g.title, u.username, l.score,l.rank_position
FROM Leaderboards l
INNER JOIN Games g
ON l.game_id = g.game_id
INNER JOIN Users u
ON l.user_id = u.user_id;
-- View Data --
SELECT * FROM Leaderboard_View;

-- 10. Game Session Report
CREATE VIEW Game_Session_Report AS
SELECT u.username, g.title, gs.login_time, gs.logout_time, gs.hours_played
FROM GameSessions gs
INNER JOIN Users u
ON gs.user_id = u.user_id
INNER JOIN Games g
ON gs.game_id = g.game_id;
-- View Data --
SELECT * FROM Game_Session_Report;

-- Aggregate Views --
-- 11. Revenue by Game
CREATE VIEW Revenue_By_Game AS
SELECT g.title,
SUM(p.amount_paid) AS Total_Revenue
FROM Games g
LEFT JOIN Purchases p
ON g.game_id = p.game_id
GROUP BY g.title;
-- View Data --
SELECT * FROM Revenue_By_Game;

-- 12. Games by Developer
CREATE VIEW Games_By_Developer AS
SELECT d.developer_name, COUNT(g.game_id) AS Total_Games
FROM Developers d
LEFT JOIN Games g
ON d.developer_id = g.developer_id
GROUP BY d.developer_name;
-- View Data --
SELECT * FROM Games_By_Developer;

-- 13. Reviews Per Game
CREATE VIEW Reviews_Per_Game AS
SELECT g.title, COUNT(r.review_id) AS Total_Reviews
FROM Games g
LEFT JOIN Reviews r
ON g.game_id = r.game_id
GROUP BY g.title;
-- View Data --
SELECT * FROM Reviews_Per_Game;

-- 14. Average Rating Per Game
CREATE VIEW Average_Game_Rating AS
SELECT g.title, AVG(r.rating) AS Average_Rating
FROM Games g
LEFT JOIN Reviews r
ON g.game_id = r.game_id
GROUP BY g.title;
-- View Data -- 
SELECT * FROM Average_Game_Rating;

-- 15. Total Play Time Per User
CREATE VIEW User_Play_Time AS
SELECT u.username, SUM(gs.hours_played) AS Total_Hours
FROM Users u
LEFT JOIN GameSessions gs
ON u.user_id = gs.user_id
GROUP BY u.username;
-- View Data -- 
SELECT * FROM User_Play_Time;

-- CREATE OR REPLACE VIEW --
-- Suppose we want to include the user's email in the View_All_Users view.
CREATE OR REPLACE VIEW View_All_Users AS
SELECT user_id, username, email, country, wallet_balance, account_created
FROM Users;
-- View Data -- 
SELECT * FROM View_All_Users;

-- SHOW ALL VIEWS --
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- View Definition --
SHOW CREATE VIEW Revenue_By_Game;

-- Drop a View --
DROP VIEW IF EXISTS Free_Games;

-- Querying Multiple Views -- 
-- Revenue with Ratings
SELECT rbg.title, rbg.Total_Revenue, agr.Average_Rating
FROM Revenue_By_Game rbg
JOIN Average_Game_Rating agr
ON rbg.title = agr.title;

-- Premium Games Report
SELECT pg.title, pg.price, agr.Average_Rating
FROM Premium_Games pg
LEFT JOIN Average_Game_Rating agr
ON pg.title = agr.title;

-- Find Games with Revenue Above ₹2000
SELECT * FROM Revenue_By_Game
WHERE Total_Revenue > 2000;

-- Top 5 Most Played Users
SELECT * FROM User_Play_Time
ORDER BY Total_Hours DESC
LIMIT 5;

-- Top Rated Games
SELECT * FROM Average_Game_Rating
ORDER BY Average_Rating DESC;

-- Top Revenue Games
SELECT * FROM Revenue_By_Game
ORDER BY Total_Revenue DESC;
