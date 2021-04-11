-- створення нової БД
CREATE SCHEMA if not exists coolcopany -- створення нової схеми
DEFAULT character set cp1251 -- кодування
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

-- вивід шаблону таблиці
DESCRIBE students;

-- видалення таблиці
DROP TABLE students;
-- видалення даних таблиці, unsafe
DELETE FROM students WHERE  student_name = 'Mike';
-- видалення усіх даних, unsafe
DELETE FROM students; 

-- зміна вже готової таблиці
ALTER TABLE student RENAME TO students;
ALTER TABLE students ADD age INT;
ALTER TABLE students DROP COLUMN age;
ALTER TABLE students CHANGE student_course student_courses INT NOT NULL;

-- введення нових даних
INSERT INTO students (student_name, student_city, student_course) VALUES ('Petro Sapriyanchuk', 'Lviv', '4'); 

-- зміна вже існючих значень таблиці
UPDATE students SET student_name = 'Mike Shevchenko', student_city = 'Lviv' WHERE student_id = 1;
UPDATE students SET student_course = 5 WHERE student_city = 'Lviv';

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
SELECT MAX(student_course) as largest_course FROM students;
-- SQL Count (), AVG () и Sum ()
SELECT COUNT(student_course) FROM students where student_course >=5; -- кількість рядків за певної умови
SELECT AVG(student_course) FROM students; -- середнє значення вибраного цифрового стопця
SELECT SUM(student_course) FROM students; -- "...очевидно же"

