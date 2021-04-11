USE coolcompany;

CREATE TABLE IF NOT EXISTS users(
user_id	INT PRIMARY KEY AUTO_INCREMENT ,
user_name VARCHAR(50) UNIQUE NOT NULL,
user_birth DATE NOT NULL,
user_weight DECIMAL(5,2) NOT NULL,
user_entry_date TIMESTAMP(0),
user_photo BLOB 
);

DROP TABLE users;
DESCRIBE users;
SELECT * FROM users;

INSERT INTO users (user_name, user_birth, user_weight) VALUES ('Mike Shevchenko', '1998-11-04', 90);

