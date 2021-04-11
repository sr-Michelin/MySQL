-- Зв'язані таблиці

CREATE SCHEMA company;
 
 USE company;
 
 CREATE TABLE IF NOT EXISTS employee (
 employee_id INT AUTO_INCREMENT UNIQUE NOT NULL,
 employee_name VARCHAR(50) UNIQUE NOT NULL,
 employee_age INT NOT NULL,
 department_id INT NOT NULL
 );
 
 DESCRIBE employee;
 INSERT INTO employee (employee_name, employee_age, department_id) VALUES ('Vasya', 29, 4);
 SELECT employee_id AS ID, employee_name AS name, department_id as department FROM employee;
-- UPDATE employee SET department_id = 4 WHERE employee_id = 4;

 CREATE TABLE IF NOT EXISTS department(
 department_id INT UNIQUE NOT NULL AUTO_INCREMENT,
 department_name VARCHAR(20) NOT NULL
 );

INSERT INTO department(department_name) VALUES ('HR');
UPDATE department SET department_name = 'DB admin'
WHERE department_ID = 2;

SELECT * FROM department;

-- Взаємний зв'язок між таблицями (employee --> department)
ALTER TABLE employee -- змінити таблицю employee
ADD CONSTRAINT fk_employee_on_dept -- додається обмеження на fk_employee_on_dept
FOREIGN KEY (department_id) -- створення злвнішнього ключа
REFERENCES department (department_id); -- привязка злвнішнього ключа

-- вивід готової таблиці із двох зв'язаних
SELECT
employee.employee_id AS id, 
employee.employee_name AS name, 
employee_age AS age, 
department.department_name AS department 
FROM employee
INNER JOIN department ON department.department_id = employee.department_id  ORDER BY employee.employee_id ASC;

-- Взаємний зв'язок між таблицями (department --> employee)
ALTER TABLE department ADD COLUMN mgr_employee_id INT; -- додається стовпець mgr_employee_id у department для взаємного зв'язку

ALTER TABLE department
ADD CONSTRAINT fk_department_on_empl_mgl -- додається обмеження fk_department_on_empl_mgl
FOREIGN KEY (mgr_employee_id) -- зовнішній ключ mgr_employee_id
REFERENCES employee (employee_id); -- прив'язка до стовпця {employee_id} у employee

SELECT * FROM company.department;
SELECT * FROM company.employee;

