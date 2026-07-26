-- 1. View All Users
SELECT * FROM Users;

-- 2. View All Games
SELECT * FROM Games;

-- 3. View All Developers
SELECT * FROM Developers;

-- 4. View All Categories
SELECT * FROM Categories;

-- 5. Display Only Username and Email
SELECT username, email
FROM Users;

-- 6. Display Game Name and Price
SELECT title, price
FROM Games;

-- 7. Display Usernames Alphabetically
SELECT username
FROM Users
ORDER BY username;

-- 8. Display Games by Price (Lowest to Highest)
SELECT title, price
FROM Games
ORDER BY price ASC;

-- 9. Display Games by Price (Highest to Lowest)
SELECT title, price
FROM Games
ORDER BY price DESC;

-- 10. Find Users from India
SELECT * FROM Users
WHERE country = 'India';

-- 11. Find Games Costing More Than ₹2000
SELECT * FROM Games
WHERE price > 2000;

-- 12. Find Games Costing Less Than ₹1500
SELECT title, price
FROM Games
WHERE price < 1500;

-- 13. Find Games Released After 2022
SELECT * FROM Games
WHERE release_date > '2022-12-31';

-- 14. Find Games with Rating Greater Than 4.5
SELECT title, rating
FROM Games
WHERE rating > 4.5;

-- 15. Find Free Games
SELECT * FROM Games
WHERE price = 0;

-- 16. Find Users Having Wallet Balance Greater Than ₹1000
SELECT username, wallet_balance
FROM Users
WHERE wallet_balance > 1000;

-- 17. Find Users from USA or Canada
SELECT * FROM Users
WHERE country = 'USA'
OR country = 'Canada';

-- 18. Find Users NOT from USA
SELECT * FROM Users
WHERE country <> 'USA';

-- 19. Find Games Between ₹1000 and ₹3000
SELECT title, price
FROM Games
WHERE price
BETWEEN 1000 AND 3000;

-- 20. Find Games NOT Between ₹1000 and ₹3000
SELECT title, price
FROM Games
WHERE price NOT BETWEEN 1000 AND 3000;

-- 21. Find Users Born After 2000
SELECT username, date_of_birth
FROM Users
WHERE date_of_birth > '2000-01-01';

-- 22. Find Games Using LIKE
-- Games starting with C
SELECT * FROM Games
WHERE title LIKE 'C%';

-- 23. Games Ending with 't'
SELECT * FROM Games
WHERE title LIKE '%t';

-- 24. Games Containing "Ring"
SELECT * FROM Games
WHERE title LIKE '%Ring%';

-- 25. Users Whose Username Starts with 'a'
SELECT * FROM Users
WHERE username LIKE 'a%';

-- 26. Users Whose Email Ends with gmail.com
SELECT username, email
FROM Users
WHERE email LIKE '%gmail.com';

-- 27. Find Users from Multiple Countries (IN)
SELECT * FROM Users
WHERE country IN
('India','USA','Japan');

-- 28. Users NOT from Selected Countries
SELECT * FROM Users
WHERE country NOT IN
('India','USA');

-- 29. Display Top 5 Games
SELECT * FROM Games
LIMIT 5;

-- 30. Display First 3 Users
SELECT * FROM Users
LIMIT 3;

-- 31. Skip First 2 Games
SELECT * FROM Games
LIMIT 2,5;

-- 32. Display Unique Countries
SELECT DISTINCT country
FROM Users;

-- 33. Count Total Users
SELECT COUNT(*) AS Total_Users
FROM Users;

-- 34. Count Total Games
SELECT COUNT(*) AS Total_Games
FROM Games;

-- 35. Display Current Database
SELECT DATABASE();

-- 36. Display Current Date
SELECT CURDATE();

-- 37. Display Current Time
SELECT CURTIME();

-- 38. Display Current Date and Time
SELECT NOW();

-- 39. Rename Column Using Alias
SELECT username AS Player_Name,
       wallet_balance AS Wallet
FROM Users;

-- 40. Display Purchase Details
SELECT purchase_id,
       amount_paid,
       purchase_date
FROM Purchases;
