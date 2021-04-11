CREATE SCHEMA company;
 
 USE company;
 
 CREATE TABLE IF NOT EXISTS employee (
 employee_id INT AUTO_INCREMENT UNIQUE NOT NULL,
 employee_name VARCHAR(50) UNIQUE NOT NULL,
 employee_age INT NOT NULL,
 department_id INT NOT NULL
 );
 
 DESCRIBE employee;
 INSERT INTO employee (employee_name, employee_age, department_id) VALUES ('Ivan', 21, 1);
 SELECT employee_name AS name, employee_department as department FROM employee;

 CREATE TABLE IF NOT EXISTS department(
 department_id INT UNIQUE NOT NULL AUTO_INCREMENT,
 department_name VARCHAR(20) NOT NULL
 );

INSERT INTO department(department_name) VALUES ('Developer');
UPDATE department SET department_name = 'DB admin' WHERE department_ID = 2;
SELECT * FROM department;

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
