-- 1. Users Table========

CREATE TABLE Users (
    
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(50) NOT NULL UNIQUE,

    email VARCHAR(100) NOT NULL UNIQUE,

    password VARCHAR(100) NOT NULL,

    country VARCHAR(50),

    date_of_birth DATE,

    account_created DATETIME DEFAULT CURRENT_TIMESTAMP,

    wallet_balance DECIMAL(10,2) DEFAULT 0.00,

    CHECK(wallet_balance >= 0)
);


-- 2. Developers Table =======

CREATE TABLE Developers (

    developer_id INT AUTO_INCREMENT PRIMARY KEY,

    developer_name VARCHAR(100) NOT NULL,

    country VARCHAR(50),

    founded_year YEAR
);

-- 3. Categories Table =========

CREATE TABLE Categories (

    category_id INT AUTO_INCREMENT PRIMARY KEY,

    category_name VARCHAR(50) UNIQUE NOT NULL
);

-- 4. Games Table =============

CREATE TABLE Games (

    game_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(100) NOT NULL,

    developer_id INT NOT NULL,

    category_id INT NOT NULL,

    release_date DATE,

    price DECIMAL(10,2) NOT NULL,

    rating DECIMAL(3,2) DEFAULT 0,

    FOREIGN KEY (developer_id)
        REFERENCES Developers(developer_id),

    FOREIGN KEY (category_id)
        REFERENCES Categories(category_id),

    CHECK(price >= 0),

    CHECK(rating BETWEEN 0 AND 5)
);

-- 5. Purchases Table ==========

CREATE TABLE Purchases (

    purchase_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    game_id INT NOT NULL,

    purchase_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    amount_paid DECIMAL(10,2),

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY(game_id)
        REFERENCES Games(game_id)
);

-- 6. Payments Table=======

CREATE TABLE Payments (

    payment_id INT AUTO_INCREMENT PRIMARY KEY,

    purchase_id INT UNIQUE,

    payment_method ENUM
    (
        'Credit Card',
        'Debit Card',
        'UPI',
        'PayPal'
    ),

    payment_status ENUM
    (
        'Pending',
        'Completed',
        'Failed'
    ) DEFAULT 'Pending',

    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(purchase_id)
        REFERENCES Purchases(purchase_id)
);

-- 7. Reviews Table ========

CREATE TABLE Reviews (

    review_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    game_id INT,

    rating INT,

    review TEXT,

    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY(game_id)
        REFERENCES Games(game_id),

    CHECK(rating BETWEEN 1 AND 5)
);

-- 8. Achievements Table =====

CREATE TABLE Achievements (

    achievement_id INT AUTO_INCREMENT PRIMARY KEY,

    game_id INT,

    achievement_name VARCHAR(100),

    points INT DEFAULT 10,

    FOREIGN KEY(game_id)
        REFERENCES Games(game_id)
);

-- 9. UserAchievements Table =========

CREATE TABLE UserAchievements (

    user_achievement_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    achievement_id INT,

    unlocked_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY(achievement_id)
        REFERENCES Achievements(achievement_id)
);

-- 10. Friends Table =======

CREATE TABLE Friends (

    friendship_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    friend_id INT,

    friendship_date DATE,

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY(friend_id)
        REFERENCES Users(user_id)
);

-- 11. Leaderboards Table =========

CREATE TABLE Leaderboards (

    leaderboard_id INT AUTO_INCREMENT PRIMARY KEY,

    game_id INT,

    user_id INT,

    score INT,

    rank_position INT,

    FOREIGN KEY(game_id)
        REFERENCES Games(game_id),

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id)
);

-- 12. GameSessions Table ===========

CREATE TABLE GameSessions (

    session_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT,

    game_id INT,

    login_time DATETIME,

    logout_time DATETIME,

    hours_played DECIMAL(5,2),

    FOREIGN KEY(user_id)
        REFERENCES Users(user_id),

    FOREIGN KEY(game_id)
        REFERENCES Games(game_id)
);

-- Verify Tables =======

SHOW TABLES;

-- View Table Structure ======

DESCRIBE Users;

DESCRIBE Games;

DESCRIBE Purchases;

-- Check Database =======

SHOW DATABASES;

USE GamingPlatformDB;

SELECT DATABASE();
