-- 1. Count Total Users
SELECT COUNT(*) AS Total_Users
FROM Users;

-- 2. Count Total Games
SELECT COUNT(*) AS Total_Games
FROM Games;

-- 3. Count Total Developers
SELECT COUNT(*) AS Total_Developers
FROM Developers;

-- 4. Count Total Purchases
SELECT COUNT(*) AS Total_Purchases
FROM Purchases;

-- 5. Count Total Reviews
SELECT COUNT(*) AS Total_Reviews
FROM Reviews;

-- 6. Total Revenue
SELECT SUM(amount_paid) AS Total_Revenue
FROM Purchases;

-- 7. Average Game Price
SELECT AVG(price) AS Average_Game_Price
FROM Games;

-- 8. Highest Game Price
SELECT MAX(price) AS Highest_Game_Price
FROM Games;

-- 9. Lowest Game Price
SELECT MIN(price) AS Lowest_Game_Price
FROM Games;

-- 10. Highest Wallet Balance
SELECT MAX(wallet_balance) AS Highest_Wallet
FROM Users;

-- 11. Lowest Wallet Balance
SELECT MIN(wallet_balance) AS Lowest_Wallet
FROM Users;

-- 12. Average Wallet Balance
SELECT AVG(wallet_balance) AS Average_Wallet
FROM Users;

-- 13. Total Wallet Balance of All Users
SELECT SUM(wallet_balance) AS Total_Wallet_Balance
FROM Users;

-- 14. Highest Review Rating
SELECT MAX(rating) AS Highest_Rating
FROM Reviews;

-- 15. Average Review Rating
SELECT AVG(rating) AS Average_Rating
FROM Reviews;

-- GROUP BY --
-- 16. Number of Users in Each Country
SELECT country,
       COUNT(*) AS Total_Users
FROM Users
GROUP BY country;

-- 17. Total Games in Each Category
SELECT category_id,
       COUNT(*) AS Total_Games
FROM Games
GROUP BY category_id;

-- 18. Average Price in Each Category
SELECT category_id,
       AVG(price) AS Average_Price
FROM Games
GROUP BY category_id;

-- 19. Maximum Game Price in Each Category
SELECT category_id,
       MAX(price) AS Highest_Price
FROM Games
GROUP BY category_id;

-- 20. Minimum Game Price in Each Category
SELECT category_id,
       MIN(price) AS Lowest_Price
FROM Games
GROUP BY category_id;

-- 21. Total Revenue Per Game
SELECT game_id,
       SUM(amount_paid) AS Revenue
FROM Purchases
GROUP BY game_id;

-- 22. Number of Purchases Per User
SELECT user_id,
       COUNT(*) AS Purchases
FROM Purchases
GROUP BY user_id;

-- 23. Total Hours Played by Each User
SELECT user_id,
       SUM(hours_played) AS Hours_Played
FROM GameSessions
GROUP BY user_id;

-- 24. Average Hours Played by User
SELECT user_id,
       AVG(hours_played) AS Average_Hours
FROM GameSessions
GROUP BY user_id;

-- 25. Highest Score for Each Game
SELECT game_id,
       MAX(score) AS Highest_Score
FROM Leaderboards
GROUP BY game_id;

-- 26. Number of Reviews Per Game
SELECT game_id,
       COUNT(*) AS Review_Count
FROM Reviews
GROUP BY game_id;

-- 27. Average Rating Per Game
SELECT game_id,
       AVG(rating) AS Average_Rating
FROM Reviews
GROUP BY game_id;

-- 28. Total Achievement Points Per Game
SELECT game_id,
       SUM(points) AS Total_Points
FROM Achievements
GROUP BY game_id;

-- 29. Total Games Developed by Each Developer
SELECT developer_id,
       COUNT(*) AS Games_Developed
FROM Games
GROUP BY developer_id;

-- 30. Number of Friends Per User
SELECT user_id,
       COUNT(friend_id) AS Friends_Count
FROM Friends
GROUP BY user_id;

-- HAVING Clause --
-- 31. Countries Having More Than One User
SELECT country,
       COUNT(*) AS Total_Users
FROM Users
GROUP BY country
HAVING COUNT(*) > 1;

-- 32. Games Generating Revenue Above ₹2000
SELECT game_id,
       SUM(amount_paid) AS Revenue
FROM Purchases
GROUP BY game_id
HAVING SUM(amount_paid) > 2000;

-- 33. Users with More Than One Purchase
SELECT user_id,
       COUNT(*) AS Purchase_Count
FROM Purchases
GROUP BY user_id
HAVING COUNT(*) > 1;

-- 34. Games with Average Review Rating Above 4.5
SELECT game_id,
       AVG(rating) AS Average_Rating
FROM Reviews
GROUP BY game_id
HAVING AVG(rating) > 4.5;

-- 35. Categories with Average Price Above ₹2000
SELECT category_id,
       AVG(price) AS Average_Price
FROM Games
GROUP BY category_id
HAVING AVG(price) > 2000;

-- 36. Developers Having More Than One Game
SELECT developer_id,
       COUNT(*) AS Total_Games
FROM Games
GROUP BY developer_id
HAVING COUNT(*) > 1;

-- (With the current sample data, this may return no rows until you add more games for the same developer)--

-- 37. Users Playing More Than 2 Hours
SELECT user_id,
       SUM(hours_played) AS Total_Hours
FROM GameSessions
GROUP BY user_id
HAVING SUM(hours_played) > 2;

-- 38. Games with Highest Score Above 9000
SELECT game_id,
       MAX(score) AS Highest_Score
FROM Leaderboards
GROUP BY game_id
HAVING MAX(score) > 9000;

-- 39. Achievement Points Greater Than 50
SELECT game_id,
       SUM(points) AS Total_Points
FROM Achievements
GROUP BY game_id
HAVING SUM(points) > 50;

-- 40. Countries with Average Wallet Balance Above ₹1000
SELECT country,
       AVG(wallet_balance) AS Average_Wallet
FROM Users
GROUP BY country
HAVING AVG(wallet_balance) > 1000;

-- Top 5 Most Expensive Games
SELECT title,
       price
FROM Games
ORDER BY price DESC
LIMIT 5;

-- Top 3 Highest Wallet Balances
SELECT username,
       wallet_balance
FROM Users
ORDER BY wallet_balance DESC
LIMIT 3;

-- Total Money Spent by All Users
SELECT SUM(amount_paid) AS Total_Spent
FROM Purchases;

-- Average Hours Played Across All Sessions
SELECT AVG(hours_played) AS Average_Hours
FROM GameSessions;
