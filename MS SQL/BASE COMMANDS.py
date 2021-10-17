import pyodbc
from CONFIG import Driver, MySQLServer, MyDatabase, Trusted_Connection

try:
    # Опрацювання виключень при під'єднанні до БД
    connection = pyodbc.connect(
        f'Driver={Driver}; '
        f'Server={MySQLServer}; '
        f'Database={MyDatabase}; '
        f'Trusted_Connection={Trusted_Connection}')

    print('Connection successful...')
    print('#' * 25)

    try:
        # Блок запитів та команд для роботи із БД

        with connection.cursor() as cursor:
            cursor.execute('SELECT [name], [course] FROM Table_1 ORDER BY [course] ASC')
            print(cursor.fetchall())
            connection.commit()

    except Exception as ex:
        print(ex)

    finally:
        connection.close()

except Exception as ex:
    print(f'Connection failed...\n{ex}')
