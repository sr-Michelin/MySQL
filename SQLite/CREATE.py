import sqlite3
import pandas as pd

with sqlite3.connect('data.db') as con:
    curs = con.cursor()

    # con.commit() # для зміни у БД

    # Створення таблиці
    curs.execute('CREATE TABLE IF NOT EXISTS train('
                 'id INT PRIMARY KEY AUTOINCREMENT,'
                 'name TEXT NOT NULL,'
                 'course INT NOT NULL CHECK (course BETWEEN 0 AND 6));')

    # Створення таблиці ssh(стипендій)
    curs.execute('CREATE TABLE IF NOT EXISTS ssh('
                 'id INT PRIMARY KEY AUTOINCREMENT,'
                 'sh INT NOT NULL);')

    curs.execute('CREATE TABLE IF NOT EXISTS ssh_new('
                 'id INT PRIMARY KEY AUTOINCREMENT,'
                 'sh INT NOT NULL);')

    # Введення даних
    # curs.execute('INSERT INTO train(id, name, course) VALUES(9, "Kata", 5)')
    # curs.execute('INSERT INTO ssh(id, sh) VALUES(1, 1770), (2, 1770), (3, 0), (4, 0), (5,0), (6, 0), (7, 0)')

    # Видалення даних
    curs.execute('DELETE FROM train WHERE id IS Null;')

    # Вивід запиту у консоль
    curs.execute('SELECT DISTINCT * FROM train;')
    print("DISTINCT: ", curs.fetchall())

    # Агрегування ф-ціями для чиселних колонок
    curs.execute('SELECT avg(id) AS avg_id, avg(course) AS avg_c FROM train')
    print("Aggregate: ", curs.fetchall())

    # Виділення певних строк
    curs.execute('SELECT * FROM train LIMIT 3')
    print("LIMIT: ", curs.fetchall())

    # SELECT DISTINCT [columns] - вивід унікальних значень таблиці

    # WHERE [condition] - умова виводу
    # GROUP BY [column] - групування записів у таблиці (під час виводу)
    # ORDER BY [column] ASC|DESC - сортування за колонкою(-ами) у напрямку зростання чи спадання

    # Оновлення існуючих записів у таблиці з первною умовою (без неї усі записи стануть одинаковими)
    curs.execute('UPDATE train SET name = "Mike Sh" WHERE name = "Mike"')
    # con.commit() # для зміни у БД

    # LIKE Operator - пошук спеціальних символів та їх косбінацій у текстах колонок
    # 'a%' - start with "a"
    # '%a' - end with "a"
    # '%or%' - have "or" in any position
    # '_r%' - have "r" in the second position
    # 'a_%' - start with "a" and are at least 2 characters in length
    # 'a%o' - start with "a" and ends with "o"
    curs.execute('SELECT name FROM train WHERE name LIKE "M%h";')
    print("LIKE: ", curs.fetchall())

    # IN Operator - як у Пітоні
    curs.execute('SELECT * FROM train WHERE name IN ("Mike Sh", "Taras", "Vanya")')
    print("IN: ", curs.fetchall())

    # JOINs - входження таблиць. Для троьох та більше працює вкладення.
    # # INNER JOIN - спільна область для двох таблиць
    curs.execute('SELECT train.name, train.course, ssh.sh FROM train INNER JOIN ssh ON train.id=ssh.id')
    print('INNER JOIN:', curs.fetchall())
    # # LEFT JOIN - повна ліва (зазначена першою) таблиця і співпадаючі дані із правої
    curs.execute('SELECT train.name, train.course, ssh.sh FROM train LEFT JOIN ssh ON train.id=ssh.id')
    print('LEFT JOIN:', curs.fetchall())
    # # RIGHT JOIN - повна права таблиця і співпадаючі дані із лівої
    # curs.execute('SELECT train.name, train.course, ssh.sh FROM train RIGHT JOIN ssh ON train.id=ssh.id')
    # print('RIGHT JOIN:', curs.fetchall())
    # # FULL JOIN - усі дані
    # curs.execute('SELECT train.name, train.course, ssh.sh FROM train FULL JOIN ssh ON train.id=ssh.id')
    # print('FULL JOIN:', curs.fetchall())

    # UNION - оператор поєднання вибірок
    curs.execute('SELECT COUNT(*) FROM train as CNT_tr UNION SELECT COUNT(*) FROM ssh as CNT_ssh')
    print('UNION:', curs.fetchall())

    # WHERE EXIST - поаертає True якщо вкладений запит повертає один і більше записів
    curs.execute('SELECT * FROM train WHERE EXISTS (SELECT * FROM ssh)')
    print('EXIST:', curs.fetchall())

    # SELECT INTO - копіювання даних із таблиці в іншу. Не працює у SQLite
    # curs.execute('SELECT * INTO ssh_new FROM ssh')
    # curs.execute('INSERT INTO ssh_new SELECT * FROM ssh')
    curs.execute('SELECT * FROM ssh_new')
    print('SELECT INTO:', curs.fetchall())

    # CREATE PROCEDURE - сторення процедур (інструкцій для виконання). Теж не для SQLite3.
    # curs.execute('CREATE PROCEDURE p AS [SELECT * FROM train] GO;')

    # КОМЕНТАР "--SELECT ALL", /*SELECT ALL*/ - тут все ясно та очевидно =)

    # CREATE/DROP DATABASE [name] - теж ясно

    # TRUNCATE TABLE [table_name] - видалення усіх записів (без колнок). Не для SQLite3

    # ALTER TABLE використовується для додавання, видалення або зміни стовпців в існуючій таблиці
    # curs.execute('ALTER TABLE [table_name] ADD [column_name] datatype;') - додавання колонок
    # curs.execute('ALTER TABLE [table_name] DROP [column_name];') - видалення колонок
    # curs.execute('ALTER TABLE [table_name] MODIFY COLUMN [column_name] datatype;')-зміна типу колонки. Не для SQLite3
    # curs.execute('ALTER TABLE [table_name] ADD PRIMARY KEY (id);') - додавання унікального ключа до т-ці

    # constraint - обмеження даних при створенні/зміні таблиці
    # # NOT NULL - Гарантує, що стовпець не може мати нульовезначення
    # # INDEX - Використовується для створення і отримання даних з бази даних дуже швидко
    # # DEFAULT - Задає значення за замовчуванням для стовпця, якщо значення не вказано
    # # PRIMARY KEY - Комбінація ненульового і унікального. Однозначно ідентифікує кожен рядок в таблиці
    # # UNIQUE - Гарантує, що всі значення в стовпці розрізняються

    # CREATE INDEX - для прискорення пошуку
    # CREATE INDEX index_name ON [table_name] (column1, column2, ...);
    # CREATE UNIQUE INDEX index_name ON [table_name] (column1, column2, ...); - без повторень

    # rowid - поле для SQLite3, що вказує на номер рядка
    # У AUTOINCREMENT ключовому слові нав'язує додатковий процесор, пам'ять, дисковий простір,
    # і диск I / O накладних витрат і слід уникати , а то й суворо необхідно.

    # CASE - оператор умови (виводиться окремою колонкою)
    C = 'SELECT train.name, train.course, ' \
        'CASE ' \
        'WHEN train.course >=5 THEN 1 ' \
        'ELSE 0 ' \
        'END AS "IS_MAG?" ' \
        'FROM train ' \
        'ORDER BY course DESC'

    curs.execute(C)
    print('CASE: ', curs.fetchall())

    # Оператори заміни
    # # REPLACE - строкова проста заміна
    curs.execute('SELECT REPLACE ("ABCA", "A", 1)')
    print('REPLACE: ', curs.fetchall())
    # # CAST(expression-AS-type_name) - заміна типу подачі даних колонки
    curs.execute("SELECT CAST('10.100,1223' AS DECIMAL(10,3))")
    print('CAST: ', curs.fetchall())

    #   -----------------------------------------------------------------------------------------------------------------
    # Вивід через бібліотеку Pandas
    print('\n', pd.read_sql('SELECT * FROM train ORDER BY course DESC', con=con))

    print('\n', pd.read_sql('SELECT COUNT(id) AS count, avg(id) AS avg_id, avg(course) AS avg_c FROM train', con=con))

    print('\n', pd.read_sql(sql='SELECT train.name, train.course, ssh.sh FROM train INNER JOIN ssh ON train.id=ssh.id',
                            con=con).describe().T)

    print('\n', pd.read_sql(sql='SELECT COUNT(*) FROM train as CNT_tr UNION SELECT COUNT(*) FROM ssh as CNT_ssh',
                            con=con))

    print('\n', pd.read_sql(sql=C, con=con).T)
