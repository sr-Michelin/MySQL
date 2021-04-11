USE coolcompany;

CREATE TABLE IF NOT EXISTS users(
user_id	INT PRIMARY KEY,
user_name VARCHAR(50) UNIQUE NOT NULL,
user_birth DATE NOT NULL,
user_weight DECIMAL(5,2) NOT NULL,
user_entry_date TIMESTAMP(0),
user_photo BLOB 
);

DESCRIBE users;
SELECT * FROM users;