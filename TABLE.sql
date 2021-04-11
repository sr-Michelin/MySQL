-- ОСНОВНІ SQL-ОПЕРАЦІЇ 

-- # СТВОРЕННЯ
-- створення нової БД
CREATE SCHEMA IF NOT EXISTS coolcopany -- створення нової схеми
DEFAULT character SET cp1251 -- кодування
COLLATE cp1251_ukrainian_ci; -- правила пошуку тексту, ci - чутливий до регістру

-- перехід до певної БД
USE coolcompany;

-- створення таблиці
CREATE TABLE IF NOT EXISTS students (
student_id	INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
student_name VARCHAR(50) NOT NULL,
student_city VARCHAR(30) NOT NULL,
student_course INT NOT NULL
);

-- # ВИВІД
-- вивід шаблону таблиці
DESCRIBE students;

-- # ВИДАЛЕННЯ
-- видалення таблиці
DROP TABLE students;
-- видалення даних таблиці, unsafe
DELETE FROM students WHERE student_name = 'Mike';
-- видалення усіх даних, safe
TRUNCATE TABLE students;

-- # ЗМІНА 
-- зміна вже готової таблиці
ALTER TABLE student RENAME TO students;
ALTER TABLE students ADD student_birth date;
ALTER TABLE students DROP COLUMN student_birth;
ALTER TABLE students CHANGE student_course student_courses INT NOT NULL;
ALTER TABLE students MODIFY COLUMN student_name VARCHAR(60); -- модифкація без видаення 

-- введення нових даних
INSERT INTO students (student_name, student_city, student_course) VALUES ('Petro Sapriyanchuk', 'Lviv', '4'); 

-- зміна вже існючих значень таблиці
UPDATE students SET student_name = 'Mike Shevchenko', student_city = 'Lviv' WHERE student_id = 1;
UPDATE students SET student_course = 5 WHERE student_city = 'Lviv';

-- # ВІДОБРАЖЕННЯ ЗА УМОВИ
-- вибір даних та їх віображення
SELECT * FROM students;

-- логіка
SELECT student_name, student_course FROM students WHERE NOT student_name = 'Mike Shevchenko' AND NOT student_course IS NULL;

-- сортування ASC|DESC
SELECT * FROM students ORDER BY student_course, student_name ASC;

-- вибір за певною кількістю рядків
SELECT * FROM students where NOT student_course IS NULL LIMIT 2;

-- вибір рядків за максимальними і мінімальними значеннями
SELECT MIN(student_course) as smallest_course FROM students;
-- ident SELECT smallest_course = MIN(student_course) FROM students;
SELECT MAX(student_course) as largest_course FROM students;

-- SQL Count (), AVG () и Sum ()
SELECT COUNT(student_course) FROM students where student_course >=5; -- кількість рядків за певної умови
SELECT AVG(student_course) FROM students; -- середнє значення вибраного цифрового стопця
SELECT SUM(student_course) FROM students; -- "...очевидно же"

-- оператор LiKE - вибір за параметрами тексту 
SELECT * FROM students WHERE student_name LIKE 'a%'; -- якщо починається на "а"
SELECT * FROM students WHERE student_name LIKE '%a'; -- якщо закінчується на "а"
SELECT * FROM students WHERE student_name LIKE '%or%'; -- якщо містить "or"
SELECT * FROM students WHERE student_name LIKE 'a_%_%'; -- якщо починається на "а" і більше трьох символів
SELECT * FROM students WHERE student_name LIKE 'a%o'; -- якщо починається на "а" і закінчується на "о"
SELECT * FROM students WHERE student_name LIKE '[bsp]%'; -- якщо починається на "b", або "s", або "p"
SELECT * FROM students WHERE student_name LIKE '[A-Z]%'; -- якщо починається на літери з проміжку A-Z
SELECT * FROM students WHERE student_name LIKE '[!bsp]%'; -- якщо НЕ починається на "b", або "s", або "p"

-- IN - якщо стовпець в (приймає означене значення)
SELECT * FROM students WHERE student_course IN (4,5);

-- BETWEEN, AND - значення між , .. і
SELECT * FROM students WHERE student_course BETWEEN 4 AND 5;

-- Aliases (student_name --> name)
SELECT student_name as name FROM students;

-- JOIN (зєднання) - для прикладу... (ДОРОБИТИ)
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;

-- UNION(обєднання двох SELECT) [ALL - для повторюючих елементів]
SELECT student_name FROM students UNION ALL SELECT student_course FROM students;

-- GROUP BY (групування)
SELECT * FROM students GROUP BY student_name;

-- HAVING (WHERE не може використовуватися з агрегатними функціями)
-- SQL дозволяє привести кілька записів таблиці до деякого єдиного значення
SELECT * FROM students HAVING COUNT(student_course) > 1;

-- EXISTS  (повертає значення true, якщо вкладений запит повертає одну або кілька записів)
SELECT student_name FROM students WHERE EXISTS (SELECT student_name FROM students WHERE student_course < 5);

-- Any , ALL  - тут ясно
SELECT * FROM students WHERE student_id = ALL (SELECT student_id  FROM students WHERE student_id = 1);
