-- ЗВ'ЯЗОК МІЖ ДВОМА ТАБЛИЦЯМИ ЧЕРЕЗ ТРЕТЮ 
-- Складений первиний ключ (комбінація двох або більше полів)
-- Первинний композитний ключ є унікальим, тому зв'язки не порушуються при новому їх введені (є застереження)

CREATE DATABASE IF NOT EXISTS ANIMAL_BIRD_FRIENDSHIP;
USE ANIMAL_BIRD_FRIENDSHIP;

CREATE TABLE IF NOT EXISTS animal(
animal_id INT PRIMARY KEY AUTO_INCREMENT,
animal_type_ID INT,
animal_name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS bird(
bird_id INT PRIMARY KEY AUTO_INCREMENT,
bird_name VARCHAR(50)
);

-- введення даних
INSERT INTO animal(animal_name) VALUES ('Олень');
INSERT INTO animal(animal_name) VALUES ('Жаба');
INSERT INTO animal(animal_name) VALUES ('Слон');

INSERT INTO bird(bird_name) VALUES ('Журавель');
INSERT INTO bird(bird_name) VALUES ('Страус');
INSERT INTO bird(bird_name) VALUES ('Курка');

-- створення третьої таблиці (зв'язок між двома попередніми)
CREATE TABLE IF NOT EXISTS animal_bird_relationship(
animal_id INT, 
bird_id INT, 
PRIMARY KEY(animal_id, bird_id)
);

-- присвоєння зв'язку між таблицями animal і bird через animal_bird_relationship
INSERT INTO animal_bird_relationship VALUES (2,3);
-- перевірка даного зв'язку
SELECT animal_id as ANIMAL, bird_id as BIRD FROM animal_bird_relationship;