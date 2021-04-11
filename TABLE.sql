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

-- зміна вже готової таблиці
ALTER TABLE student RENAME TO students;
ALTER TABLE students ADD age INT;
ALTER TABLE students DROP COLUMN age;
ALTER TABLE students CHANGE student_course student_courses INT NOT NULL;

-- введення нових даних
INSERT INTO students (student_name, student_city, student_course) VALUES ('Mike Shevchenko', 'Lviv', '5'); 

-- вибір даних та їх віображення
SELECT * FROM students;
-- логіка
SELECT student_name, student_course FROM students WHERE NOT student_name = 'Mike Shevchenko' AND student_city ='Lviv';
-- сортування 
SELECT * FROM students ORDER BY student_course, student_name;





