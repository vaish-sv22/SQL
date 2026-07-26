-- INNER JOIN
-- 1. Display Game Name with Developer Name
SELECT g.game_id, g.title, d.developer_name
FROM Games g
INNER JOIN Developers d
ON g.developer_id = d.developer_id;

-- 2. Display Game Name with Category
SELECT g.title, c.category_name
FROM Games g
INNER JOIN Categories c
ON g.category_id = c.category_id;

-- 3. Display Purchase Details with User Name
SELECT p.purchase_id, u.username, p.amount_paid, p.purchase_date
FROM Purchases p
INNER JOIN Users u
ON p.user_id = u.user_id;

-- 4. Display Purchased Games
SELECT u.username, g.title, p.amount_paid
FROM Purchases p
INNER JOIN Users u
ON p.user_id = u.user_id
INNER JOIN Games g
ON p.game_id = g.game_id;

-- 5. Display Reviews with User and Game
SELECT u.username, g.title, r.rating, r.review
FROM Reviews r
INNER JOIN Users u
ON r.user_id = u.user_id
INNER JOIN Games g
ON r.game_id = g.game_id;

-- 6. Display Payments with Purchase Details
SELECT pay.payment_id, p.purchase_id, pay.payment_method, pay.payment_status, p.amount_paid
FROM Payments pay
INNER JOIN Purchases p
ON pay.purchase_id = p.purchase_id;

-- 7. Display Achievements with Game Name
SELECT a.achievement_name, g.title, a.points
FROM Achievements a
INNER JOIN Games g
ON a.game_id = g.game_id;

-- 8. Display User Achievements
SELECT u.username, a.achievement_name, a.points
FROM UserAchievements ua
INNER JOIN Users u
ON ua.user_id = u.user_id
INNER JOIN Achievements a
ON ua.achievement_id = a.achievement_id;

-- 9. Display Leaderboard
SELECT g.title, u.username, l.score, l.rank_position
FROM Leaderboards l
INNER JOIN Games g
ON l.game_id = g.game_id
INNER JOIN Users u
ON l.user_id = u.user_id;

-- 10. Display Game Sessions
SELECT u.username, g.title, gs.hours_played
FROM GameSessions gs
INNER JOIN Users u
ON gs.user_id = u.user_id
INNER JOIN Games g
ON gs.game_id = g.game_id;

-- LEFT JOIN --
-- 11. Show All Users and Their Purchases
SELECT u.username, p.purchase_id, p.amount_paid
FROM Users u
LEFT JOIN Purchases p
ON u.user_id = p.user_id;

-- 12. Show All Games and Reviews
SELECT g.title,r.rating, r.review
FROM Games g
LEFT JOIN Reviews r
ON g.game_id = r.game_id;

-- 13. Show Developers and Games
SELECT d.developer_name, g.title
FROM Developers d
LEFT JOIN Games g
ON d.developer_id = g.developer_id;

-- 14. Show Categories and Games
SELECT c.category_name, g.title
FROM Categories c
LEFT JOIN Games g
ON c.category_id = g.category_id;

-- 15. Show Users and Friends
SELECT u.username, f.friend_id
FROM Users u
LEFT JOIN Friends f
ON u.user_id = f.user_id;

-- RIGHT JOIN--
-- 16. Games with Developers
SELECT g.title, d.developer_name
FROM Games g
RIGHT JOIN Developers d
ON g.developer_id = d.developer_id;

-- 17. Games with Categories
SELECT g.title, c.category_name
FROM Games g
RIGHT JOIN Categories c
ON g.category_id = c.category_id;

-- 18. Purchases with Users
SELECT p.purchase_id, u.username
FROM Purchases p
RIGHT JOIN Users u
ON p.user_id = u.user_id;

-- CROSS JOIN -- 
-- 19. Every User with Every Category
SELECT u.username, c.category_name
FROM Users u
CROSS JOIN Categories c;

-- 20. Every Developer with Every Category
SELECT d.developer_name, c.category_name
FROM Developers d
CROSS JOIN Categories c;

-- SELF JOIN --
-- 21. Display Friends' Usernames
SELECT u1.username AS User_Name, u2.username AS Friend_Name
FROM Friends f
INNER JOIN Users u1
ON f.user_id = u1.user_id
INNER JOIN Users u2
ON f.friend_id = u2.user_id;

-- 22. Self Join Example
SELECT A.username, B.username
FROM Users A
JOIN Users B
ON A.user_id <> B.user_id
LIMIT 10;

-- FULL OUTER JOIN (MySQL Simulation) -- 
-- MySQL does not support FULL OUTER JOIN directly.

-- 23. 
SELECT u.username, p.purchase_id
FROM Users u
LEFT JOIN Purchases p
ON u.user_id = p.user_id
UNION
SELECT u.username, p.purchase_id
FROM Users u
RIGHT JOIN Purchases p
ON u.user_id = p.user_id;

-- Multiple Table JOIN --
-- 24. Purchase Report
SELECT u.username, g.title, d.developer_name, c.category_name, p.amount_paid
FROM Purchases p
INNER JOIN Users u
ON p.user_id=u.user_id
INNER JOIN Games g
ON p.game_id=g.game_id
INNER JOIN Developers d
ON g.developer_id=d.developer_id
INNER JOIN Categories c
ON g.category_id=c.category_id;

-- 25. Payment Report
SELECT u.username, g.title, pay.payment_method, pay.payment_status, p.amount_paid
FROM Payments pay
INNER JOIN Purchases p
ON pay.purchase_id=p.purchase_id
INNER JOIN Users u
ON p.user_id=u.user_id
INNER JOIN Games g
ON p.game_id=g.game_id;

-- 26. Review Report
SELECT u.username, g.title, r.rating, r.review
FROM Reviews r
INNER JOIN Users u
ON r.user_id=u.user_id
INNER JOIN Games g
ON r.game_id=g.game_id;

-- 27. Achievement Report
SELECT u.username, g.title, a.achievement_name, a.points
FROM UserAchievements ua
INNER JOIN Users u
ON ua.user_id=u.user_id
INNER JOIN Achievements a
ON ua.achievement_id=a.achievement_id
INNER JOIN Games g
ON a.game_id=g.game_id;

-- Aggregate with JOIN -- 
-- 28. Number of Games by Developer
SELECT d.developer_name, COUNT(g.game_id) AS Total_Games
FROM Developers d
LEFT JOIN Games g
ON d.developer_id=g.developer_id
GROUP BY d.developer_name;

-- 29. Total Revenue by Game
SELECT g.title, SUM(p.amount_paid) AS Revenue
FROM Games g
INNER JOIN Purchases p
ON g.game_id=p.game_id
GROUP BY g.title;

-- 30. Average Rating by Game
SELECT g.title, AVG(r.rating) AS Average_Rating
FROM Games g
INNER JOIN Reviews r
ON g.game_id=r.game_id
GROUP BY g.title;

-- 31. Number of Reviews per Game
SELECT g.title, COUNT(r.review_id) AS Reviews
FROM Games g
LEFT JOIN Reviews r
ON g.game_id=r.game_id
GROUP BY g.title;

-- 32. Total Hours Played per User
SELECT u.username, SUM(gs.hours_played) AS Hours_Played
FROM Users u
INNER JOIN GameSessions gs
ON u.user_id=gs.user_id
GROUP BY u.username;

-- Advanced JOIN --
-- 33. Highest Spending User
SELECT u.username, SUM(p.amount_paid) AS Total_Spent
FROM Users u
INNER JOIN Purchases p
ON u.user_id=p.user_id
GROUP BY u.username
ORDER BY Total_Spent DESC;

-- 34. Top Rated Games
SELECT g.title, AVG(r.rating) AS Rating
FROM Games g
INNER JOIN Reviews r
ON g.game_id=r.game_id
GROUP BY g.title
ORDER BY Rating DESC;

-- 35. Most Played Games
SELECT g.title, SUM(gs.hours_played) AS Total_Hours
FROM Games g
INNER JOIN GameSessions gs
ON g.game_id=gs.game_id
GROUP BY g.title
ORDER BY Total_Hours DESC;