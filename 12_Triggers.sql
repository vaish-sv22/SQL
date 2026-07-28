-- First step is to Create Audit Log Table
-- This table stores all important activities.
CREATE TABLE AuditLog
(
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    action_type VARCHAR(20),
    record_id INT,
    description VARCHAR(255),
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BEFORE INSERT Trigger -- 
-- 1. Prevent Negative Wallet Balance
DELIMITER $$
CREATE TRIGGER trg_before_insert_user
BEFORE INSERT 
ON Users
FOR EACH ROW
BEGIN
IF NEW.wallet_balance < 0 THEN
SET NEW.wallet_balance = 0;
END IF;
END $$
DELIMITER ;
-- to test
INSERT INTO Users (username,email,password,country,wallet_balance)
VALUES ('testuser', 'test@gmail.com', '12345', 'India', -500);

-- AFTER INSERT Trigger -- 
-- 2. Log New User
DELIMITER $$
CREATE TRIGGER trg_after_insert_user
AFTER INSERT
ON Users
FOR EACH ROW
BEGIN
INSERT INTO AuditLog (table_name, action_type, record_id, description)
VALUES ('Users', 'INSERT', NEW.user_id, CONCAT('New User Added : ',NEW.username));
END $$
DELIMITER ;
-- to test
INSERT INTO Users (username,email,password,country,wallet_balance)
VALUES ('john123', 'john@gmail.com', '123', 'USA', 500);
-- to check Log
SELECT * FROM AuditLog;

-- BEFORE UPDATE Trigger -- 
-- 3. Prevent Negative Price
DELIMITER $$
CREATE TRIGGER trg_before_update_game
BEFORE UPDATE
ON Games
FOR EACH ROW
BEGIN
IF NEW.price<0 THEN
SET NEW.price=OLD.price;
END IF;
END $$
DELIMITER ;
-- to test
UPDATE Games
SET price=-500
WHERE game_id=1;

-- AFTER UPDATE Trigger -- 
-- 4. Log Price Change
DELIMITER $$
CREATE TRIGGER trg_after_update_game
AFTER UPDATE
ON Games
FOR EACH ROW
BEGIN
INSERT INTO AuditLog (table_name, action_type, record_id, description)
VALUES ('Games', 'UPDATE', NEW.game_id, CONCAT('Price Changed from ', OLD.price, ' to ', NEW.price ));
END $$
DELIMITER ;
-- to test
UPDATE Games
SET price=3500
WHERE game_id=1;

-- BEFORE DELETE Trigger -- 
-- 5. Prevent Admin User Deletion
DELIMITER $$
CREATE TRIGGER trg_before_delete_user
BEFORE DELETE
ON Users
FOR EACH ROW
BEGIN
IF OLD.user_id=1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Admin cannot be deleted';
END IF;
END $$
DELIMITER ;
-- to test
DELETE FROM Users
WHERE user_id=1;

-- AFTER DELETE Trigger -- 
-- 6. Log Deleted User
DELIMITER $$
CREATE TRIGGER trg_after_delete_user
AFTER DELETE
ON Users
FOR EACH ROW
BEGIN
INSERT INTO AuditLog (table_name, action_type, record_id, description)
VALUES ('Users', 'DELETE', OLD.user_id, CONCAT('Deleted User ',OLD.username));
END $$
DELIMITER ;

-- Trigger on Purchases --
-- 7. Deduct Wallet Balance Automatically
DELIMITER $$
CREATE TRIGGER trg_purchase_wallet
AFTER INSERT
ON Purchases
FOR EACH ROW
BEGIN
UPDATE Users
SET wallet_balance=
wallet_balance-NEW.amount_paid
WHERE user_id=NEW.user_id;
END $$
DELIMITER ;
-- to test
INSERT INTO Purchases (user_id,game_id,amount_paid,purchase_date)
VALUES (2,1,500,CURDATE());
-- to check 
SELECT username, wallet_balance
FROM Users
WHERE user_id=2;

-- Trigger on Reviews -- 
-- 8. Update Average Rating
DELIMITER $$
CREATE TRIGGER trg_review_rating
AFTER INSERT
ON Reviews
FOR EACH ROW
BEGIN
UPDATE Games
SET rating=
( 
SELECT AVG(rating)
FROM Reviews
WHERE game_id=NEW.game_id
)
WHERE game_id=NEW.game_id;
END $$
DELIMITER ;

-- Trigger on Leaderboard -- 
-- 9. Log New Score
DELIMITER $$
CREATE TRIGGER trg_score_log
AFTER INSERT
ON Leaderboards
FOR EACH ROW
BEGIN
INSERT INTO AuditLog (table_name, action_type, record_id, description)
VALUES ('Leaderboards', 'INSERT', NEW.leaderboard_id, CONCAT('Score : ', NEW.score ));
END $$
DELIMITER ;

-- Trigger on Payments --
-- 10. Log Payment
DELIMITER $$
CREATE TRIGGER trg_payment_log
AFTER INSERT
ON Payments
FOR EACH ROW
BEGIN
INSERT INTO AuditLog (table_name, action_type, record_id, description)
VALUES ('Payments', 'INSERT', NEW.payment_id, CONCAT('Payment ', NEW.payment_method ));
END $$
DELIMITER ;

-- Show Triggers -- 
SHOW TRIGGERS;

-- Trigger Definition -- 
SHOW CREATE TRIGGER trg_after_insert_user;

-- Drop Trigger --
DROP TRIGGER IF EXISTS trg_payment_log;

-- Insert User --
INSERT INTO Users (username,email,password,country,wallet_balance)
VALUES('player10', 'player10@gmail.com', '123', 'India', 1200);

-- Update Game Price --
UPDATE Games
SET price=2500
WHERE game_id=2;

-- Delete User --
DELETE FROM Users
WHERE user_id=8;

-- Check Logs --
SELECT * FROM AuditLog
ORDER BY action_time DESC;

-- Count Logs --
SELECT COUNT(*)
FROM AuditLog;

-- TRIGGER EXECUTION ORDER -- 

-- INSERT OPERATION --
INSERT
   │
   ▼
BEFORE INSERT
   │
   ▼
Row Inserted
   │
   ▼
AFTER INSERT

-- UPDATE OPERATION -- 
UPDATE
   │
   ▼
BEFORE UPDATE
   │
   ▼
Row Updated
   │
   ▼
AFTER UPDATE

-- DELETE OPERATION -- 
DELETE
   │
   ▼
BEFORE DELETE
   │
   ▼
Row Deleted
   │
   ▼
AFTER DELETE

