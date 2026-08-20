USE GamingPlatformDB;

-- 1. Insert Categories =====
INSERT INTO Categories (category_name) VALUES
('Action'),
('Adventure'),
('RPG'),
('Racing'),
('Sports'),
('Simulation'),
('Strategy'),
('Puzzle');

-- 2. Insert Developers =====
INSERT INTO Developers (developer_name, country, founded_year) VALUES
('Valve', 'USA', 1996),
('Rockstar Games', 'USA', 1998),
('Ubisoft', 'France', 1986),
('EA Sports', 'USA', 1982),
('Mojang Studios', 'Sweden', 2009),
('CD Projekt Red', 'Poland', 2002),
('Epic Games', 'USA', 1991),
('Epic Games', 'USA', 1991),
('FromSoftware', 'Japan', 1986);

-- 3. Insert Users =========
INSERT INTO Users
(username, email, password, country, date_of_birth, wallet_balance)
VALUES
('alex01','alex@gmail.com','alex123','USA','1999-05-10',1200.50),
('emma22','emma@gmail.com','emma123','Canada','2000-07-15',850.00),
('john99','john@gmail.com','john123','UK','1998-11-20',450.75),
('olivia07','olivia@gmail.com','olivia123','Australia','2001-01-05',2000.00),
('liam88','liam@gmail.com','liam123','India','1997-03-18',950.50),
('sophia11','sophia@gmail.com','sophia123','Germany','2002-09-12',600.00),
('noah55','noah@gmail.com','noah123','Japan','1999-06-30',1450.25),
('ava77','ava@gmail.com','ava123','Brazil','2001-08-21',780.00);

-- 4. Insert Games =========
INSERT INTO Games
(title, developer_id, category_id, release_date, price, rating)
VALUES
('Counter Strike 2',1,1,'2023-09-27',1499.00,4.8),
('Grand Theft Auto V',2,1,'2015-04-14',1999.00,4.9),
('Assassins Creed Mirage',3,2,'2023-10-05',2499.00,4.6),
('FIFA 24',4,5,'2023-09-29',3499.00,4.4),
('Minecraft',5,6,'2011-11-18',1299.00,4.9),
('Cyberpunk 2077',6,3,'2020-12-10',2999.00,4.5),
('Fortnite',7,1,'2017-07-21',0.00,4.7),
('Elden Ring',8,3,'2022-02-25',3999.00,5.0);

-- 5. Insert Purchases ======
INSERT INTO Purchases
(user_id, game_id, amount_paid)
VALUES
(1,2,1999.00),
(1,5,1299.00),
(2,1,1499.00),
(2,7,0.00),
(3,4,3499.00),
(4,8,3999.00),
(5,3,2499.00),
(6,6,2999.00),
(7,5,1299.00),
(8,2,1999.00);

-- 6. Insert Payments =======
INSERT INTO Payments
(purchase_id,payment_method,payment_status)
VALUES
(1,'UPI','Completed'),
(2,'Credit Card','Completed'),
(3,'Debit Card','Completed'),
(4,'PayPal','Completed'),
(5,'UPI','Completed'),
(6,'Credit Card','Completed'),
(7,'Debit Card','Pending'),
(8,'UPI','Completed'),
(9,'PayPal','Completed'),
(10,'Credit Card','Completed');

-- 7. Insert Reviews ==============
INSERT INTO Reviews
(user_id,game_id,rating,review)
VALUES
(1,2,5,'Amazing open world game'),
(2,1,5,'Best multiplayer experience'),
(3,4,4,'Very realistic football game'),
(4,8,5,'Masterpiece'),
(5,3,4,'Great graphics'),
(6,6,4,'Improved after updates'),
(7,5,5,'Perfect sandbox game'),
(8,2,5,'Still one of the best games');

-- 8. Insert Achievements ============
INSERT INTO Achievements
(game_id,achievement_name,points)
VALUES
(1,'First Blood',20),
(2,'Master Driver',50),
(3,'Hidden Assassin',40),
(4,'World Champion',60),
(5,'Diamond Miner',30),
(6,'Night City Legend',70),
(7,'Victory Royale',80),
(8,'Elden Lord',100);

-- 9. Insert UserAchievements ==========
INSERT INTO UserAchievements
(user_id,achievement_id)
VALUES
(1,2),
(2,1),
(3,4),
(4,8),
(5,3),
(6,6),
(7,5),
(8,2);

-- 10. Insert Friends ==============
INSERT INTO Friends
(user_id,friend_id,friendship_date)
VALUES
(1,2,'2024-01-10'),
(1,3,'2024-02-15'),
(2,4,'2024-03-12'),
(3,5,'2024-04-18'),
(4,6,'2024-05-20'),
(5,7,'2024-06-05'),
(6,8,'2024-06-15'),
(7,1,'2024-07-01');

-- 11. Insert Leaderboards =========
INSERT INTO Leaderboards
(game_id,user_id,score,rank_position)
VALUES
(1,2,9850,1),
(2,1,9500,2),
(5,7,9200,3),
(8,4,9000,4),
(6,6,8800,5),
(3,5,8600,6),
(4,3,8500,7),
(7,8,8400,8);

-- 12. Insert Game Sessions==== 
INSERT INTO GameSessions
(user_id,game_id,login_time,logout_time,hours_played)
VALUES
(1,2,'2025-01-01 10:00:00','2025-01-01 13:00:00',3.00),
(2,1,'2025-01-02 14:00:00','2025-01-02 16:30:00',2.50),
(3,4,'2025-01-03 18:00:00','2025-01-03 20:00:00',2.00),
(4,8,'2025-01-04 11:00:00','2025-01-04 15:00:00',4.00),
(5,3,'2025-01-05 09:30:00','2025-01-05 11:00:00',1.50),
(6,6,'2025-01-06 17:00:00','2025-01-06 20:00:00',3.00),
(7,5,'2025-01-07 08:00:00','2025-01-07 10:30:00',2.50),
(8,2,'2025-01-08 19:00:00','2025-01-08 22:00:00',3.00);

-- Verify the Data=======
SELECT * FROM Categories;
SELECT * FROM Developers;
SELECT * FROM Users;
SELECT * FROM Games;
SELECT * FROM Purchases;
SELECT * FROM Payments;
SELECT * FROM Reviews;
SELECT * FROM Achievements;
SELECT * FROM UserAchievements;
SELECT * FROM Friends;
SELECT * FROM Leaderboards;
SELECT * FROM GameSessions;

-- Check Row Counts ========
SELECT COUNT(*) AS TotalUsers FROM Users;
SELECT COUNT(*) AS TotalGames FROM Games;
SELECT COUNT(*) AS TotalPurchases FROM Purchases;
SELECT COUNT(*) AS TotalReviews FROM Reviews;
