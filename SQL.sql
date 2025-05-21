# Задание 1
;

CREATE DATABASE users_adverts;

# date,user_id,view_adverts;

CREATE TABLE users (
date DATE,
user_id VARCHAR(100),
view_adverts INT
);

SELECT * FROM users;

# 1.1 Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице 
# в период с 2023-11-07 по 2023-11-15.
;

SELECT COUNT(DISTINCT user_id) 
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15' ;

# 1.2 Определите пользователя, который за весь период посмотрел наибольшее количество объявлений.
;

SELECT user_id, MAX(view_adverts)
FROM users
GROUP BY user_id
ORDER BY MAX(view_adverts) DESC
LIMIT 1;

# 1.3 Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, 
# но учитывайте только дни с более чем 500 уникальными пользователями.
;

SELECT date, AVG(view_adverts) AS avg_ad_views_per_user
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY avg_ad_views_per_user DESC
LIMIT 1;

# 1.4 Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. 
# Отсортировать LT по убыванию.


# мой запрос
SELECT
    IFNULL(
        (SELECT DISTINCT user_id
        FROM users
        ORDER BY user_id
        LIMIT 1 OFFSET 1
        ), null) as LT
FROM users
LIMIT 1;

# правильный запрос от кураторов

SELECT user_id, COUNT(DISTINCT(date)) AS LT
FROM users
GROUP BY user_id
ORDER BY LT DESC;



# 1.5 Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, 
# у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней
;
SELECT * FROM users;
SELECT user_id, AVG(view_adverts)
FROM users
GROUP BY user_id
HAVING COUNT (user_id) > 5
LIMIT 1;

# Задание №2
#Создайте новую базу данных mini_project. В этой базе данных будут 2 таблицы:
#1)     T_TAB1 – товары с описанием (тип товара, кол-во, сумма и продавец)
#2)     T_TAB2 – имена сотрудников, их возраст и заработная плата
#Структура и тип данных в каждой таблице выглядят следующим образом (строки в таблицы нужно добавить запросом):
;

CREATE DATABASE mini_project;
CREATE TABLE T_TAB1 
(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
goods_type VARCHAR(60),
quantity INT,
amount INT,
seller_name VARCHAR(50),
UNIQUE (id)
);

SELECT * FROM T_TAB1;

INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (1, 'MOBILE PHONE', 2, 400000, 'MIKE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (2, 'KEYBOARD', 1, 10000, 'MIKE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (3, 'MOBILE PHONE', 1, 50000, 'JANE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (4, 'MONITOR', 1, 110000, 'JOE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (5, 'MONITOR', 2, 80000, 'JANE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (6, 'MOBILE PHONE', 1, 130000, 'JOE');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (7, 'MOBILE PHONE', 1, 60000, 'ANNA');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (8, 'PRINTER', 1, 90000, 'ANNA');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (9, 'KEYBOARD', 2, 10000, 'ANNA');
INSERT INTO T_TAB1 (id, goods_type, quantity, amount, seller_name) VALUES (10, 'PRINTER', 1, 80000, 'MIKE');

CREATE TABLE T_TAB2 
(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
salary INT,
age INT,
UNIQUE (id)
);

SELECT * FROM T_TAB2;

INSERT INTO T_TAB2 (id, name, salary, age) VALUES (1, 'ANNA', 110000, 27);
INSERT INTO T_TAB2 (id, name, salary, age) VALUES (2, 'JANE', 80000, 25);
INSERT INTO T_TAB2 (id, name, salary, age) VALUES (3, 'MIKE', 120000, 25);
INSERT INTO T_TAB2 (id, name, salary, age) VALUES (4, 'JOE', 70000, 24);
INSERT INTO T_TAB2 (id, name, salary, age) VALUES (5, 'RITA', 120000, 29);

# 2.1 Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). 
# Какое количество уникальных категорий товаров вернёт запрос?
;

SELECT DISTINCT goods_type
FROM T_TAB1;

SELECT COUNT(DISTINCT goods_type) 
FROM T_TAB1;

# 2.2 Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. 
# Какое суммарное количество и суммарную стоимость вернул запрос?
;

SELECT SUM(quantity), SUM(amount)
FROM T_TAB1;

# 2.3 Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. 
# Какое кол-во сотрудников вернул запрос?
;

SELECT id, name
FROM T_TAB2
WHERE salary > 100000;

# 2.4 Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, 
# а также минимальную и максимальную заработную плату.
;

SELECT id, name, MIN(age), MAX(age), MIN(salary), MAX(salary)
FROM T_TAB2
GROUP BY id;

# 2.5 Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
;

SELECT goods_type, round(AVG(quantity), 1) AS avg_quantity
FROM T_TAB1
WHERE goods_type IN ('KEYBOARD', 'PRINTER')
GROUP BY goods_type;

# 2.6 Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров
;

SELECT DISTINCT seller_name, SUM(amount) AS sum_amount
FROM T_TAB1
GROUP BY seller_name;

# 2.7 Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, 
# стоимость товара, заработную плату и возраст сотрудника MIKE.
;

SELECT t.seller_name, t.goods_type, t.quantity, t.amount, tt.salary, tt.age
FROM T_TAB1 t
JOIN T_TAB2 tt
ON t.id = tt.id
GROUP BY t.id
HAVING t.seller_name = 'MIKE';

# 2.8 Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
;

SELECT tt.name, tt.age
FROM T_TAB2 tt
JOIN T_TAB1 t
ON tt.id = t.id
WHERE t.quantity IS NULL
GROUP BY tt.id;

# Ответ 0 сотрудников

# 2.9 Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? 
# Какое количество строк вернул запрос?
;

SELECT name, salary
FROM T_TAB2
WHERE age < 26;

# Ответ 3 строки


# 2.10 Сколько строк вернёт следующий запрос:
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';

# Ответ 0 строк

