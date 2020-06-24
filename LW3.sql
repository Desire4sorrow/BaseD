--INSERT(Включение) 
--1.1. Без указания списка полей.
INSERT INTO stadium VALUES ('Moskow', 100, 10000, 'winter');
--1.2. С указанием списка полей.
INSERT INTO perfomance (date, duration, start_position, type) 
VALUES ('2020-12-12', '00:21:32.1111111', 5, 'public');
--1.3. С чтением значения из другой таблицы.
INSERT INTO sportsman(id_perfomance, id_sportsman_on_competition) SELECT id_perfomance, id_sportsman_on_competition FROM perfomance, sportsman_on_competition;

--DELETE(удаление записей) 
--2.1. Всех записей.
DELETE stadium;
--2.2. По условию. 
DELETE FROM perfomance WHERE type = 'public';
--2.3. Очистить таблицу.
TRUNCATE TABLE perfomance;

--UPDATE(дополнение, изменения в уже существующих записях)
--3.1. Всех записей.
UPDATE competition SET location = 'Moskow';
--3.2. По условию обновляя атрибут.
UPDATE competition SET name = 'Championship' WHERE location = 'Kazan';
--3.3. По условию обновляя несколько атрибутов.
UPDATE competition SET name = 'Championship', location = 'Kazan' WHERE date = '2020-12-12';

--SELECT 
--4.1. С определенным набором извлекаемых атрибутов.
SELECT first_name, last_name, gender FROM sportsman;
--4.2. Со всеми атрибутами в таблице. 
SELECT * FROM sportsman;
--4.3. С условием по атрибуту. 
SELECT * FROM sportsman WHERE first_name = 'Иван';

--SELECT ORDER BY + TOP(LIMIT)
--5.1. С сортировкой по возрастанию ASC + ограничение вывода количества записей.
SELECT TOP 3 sportsman_on_competition ORDER BY position ASC;
--5.2. С сортировкой по убыванию DESC.
SELECT * FROM sportsman_on_competition ORDER BY position DESC;
--5.3. С сортировкой по двум атрибутам + ограничение вывода количества записей.
SELECT TOP 4 * FROM sportsman_on_competition ORDER BY start_number, position DESC;
--5.4. С сортировкой по первому атрибуту, из списка извлекаемых, относительная позиция.
SELECT * FROM sportsman_on_competition ORDER BY 1 DESC;

--Работа с датами. Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME.
--6.1. WHERE по искомой дате. 
SELECT * FROM competition WHERE date = '2020-12-12';
--6.2. Извлечь только год из таблицы.
SELECT YEAR(date) FROM competition;

--SELECT GROUP BY с функциями агрегации.
--7.1. MINIMUM 
SELECT id_sportsman_on_competition, MIN(position) AS min_amount FROM sportsman_on_competition GROUP BY id_sportsman_on_competition;
--7.2. MAXIMUM
SELECT id_sportsman_on_competition, MAX(position) AS max_position FROM sportsman_on_competition GROUP BY id_sportsman_on_competition;
--7.3. AVG - среднее значение столбца в таблице 
SELECT id_stadium, AVG(capacity) AS avg_capacity FROM stadium GROUP BY id_stadium;
--7.4. SUM 
SELECT id_stadium, SUM(capacity) AS sum_capacity FROM stadium GROUP BY id_stadium;
--7.5. COUNT - количество значений
SELECT specialization, COUNT(placement) AS count_placement FROM stadium GROUP BY specialization;

--SELECT GROUP BY + HAVING
--8.1. 3 запроса с GROUP BY + HAVING
SELECT fist_name, COUNT(age) AS count_age FROM sportsman GROUP BY first_name HAVING COUNT(age) < 10; 
SELECT placement, AVG(capacity) AS avg_capacity FROM stadium GROUP BY placement HAVING AVG(capacity) > 5000; 
SELECT specialization, MAX(capacity) AS max_capacity FROM stadium GROUP BY specialization HAVING MIN(height) > 100; 

--SELECT JOIN
--9.1. LEFT JOIN + WHERE.
SELECT * FROM sportsman_on_competition 
LEFT JOIN stadium ON sportsman_on_competition.id_stadium = stadium.id_stadium WHERE amount > 5000;
--9.2. RIGHT JOIN 
SELECT * FROM sportsman_on_competition 
RIGHT JOIN stadium ON sportsman_on_competition.id_stadium = stadium.id_stadium ORDER BY amount ASC;
--9.3. LEFT JOIN 3 таблиц + по атрибуту WHERE с каждой таблицы.
SELECT amount, position FROM sportsman_on_competition 
LEFT JOIN stadium ON sportsman_on_competition.id_stadium = stadium.id_stadium 
LEFT JOIN competition ON sportsman_on_competition.id_sportsman_on_competition = competition.id_sportsman_on_competition
WHERE position > 10 AND start_number < 100;
--9.4. FULL OUTER JOIN 2 таблиц.
SELECT * FROM perfomance FULL OUTER JOIN stadium on perfomance.id_perfomance = stadium.id_stadium;

--ПОДЗАПРОСЫ
--Запрос с подзапросом WHERE IN.
SELECT first_name, last_name, gender, birthday FROM sportsman WHERE id_perfomance IN(SELECT id_perfomance FROM perfomance WHERE date = '2019-12-11'); 
--SELECT atr1, atr2, (подзапрос) FROM ...
SELECT date, type, (SELECT id_sportsman_on_competition FROM sportsman WHERE sportsman.id_perfomance = perfomance.id_perfomance) AS id_sportsmans_perfomance FROM perfomance;  
