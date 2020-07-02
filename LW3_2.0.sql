--INSERT(���������)
--1.1. ��� �������� ������ �����.
INSERT INTO competition VALUES ('2019-12-12', 'Moskow', 'Championship', 'open-air');
--1.2. � ��������� ������ �����.
INSERT INTO perfomance (duration, start_position, variety) VALUES ('00:21:32.1111111', 5, 'public');
--1.3. � ������� �������� �� ������ �������.
INSERT INTO sportsman_on_competition (id_sportsman, id_competition) SELECT id_sportsman, id_competition FROM sportsman, competition;

--DELETE(�������� �������) 
--2.1. ���� �������.
DELETE stadium;
--2.2. �� �������. 
DELETE FROM perfomance WHERE variety = 'public';
--2.3. �������� �������.
TRUNCATE TABLE perfomance;


--UPDATE(����������, ��������� � ��� ������������ �������)
--3.1. ���� �������.
UPDATE competition SET city = 'Moskow';
--3.2. �� ������� �������� �������.
UPDATE competition SET name = 'Championship' WHERE city = 'Kazan';
--3.3. �� ������� �������� ��������� ���������.
UPDATE competition SET name = 'Championship', city = 'Kazan' WHERE date = '2019-12-12';
--SELECT 
--4.1. � ������������ ������� ����������� ���������.
SELECT first_name, last_name, gender FROM sportsman;
--4.2. �� ����� ���������� � �������. 
SELECT * FROM sportsman;
--4.3. � �������� �� ��������. 
SELECT * FROM sportsman WHERE first_name = '����';


--SELECT ORDER BY + TOP(LIMIT)

--5.1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������.

SELECT TOP 3 * FROM sportsman ORDER BY age ASC;

--5.2. � ����������� �� �������� DESC.

SELECT * FROM sportsman ORDER BY age DESC;

--5.3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������.

SELECT TOP 4 * FROM sportsman ORDER BY last_name, age DESC;

--5.4. � ����������� �� ������� ��������, �� ������ �����������, ������������� �������.

SELECT * FROM sportsman ORDER BY 1 DESC;



--������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.

--6.1. WHERE �� ������� ����. 

SELECT * FROM competition WHERE date = '2020-12-12';

--6.2. ������� ������ ��� �� �������.

SELECT YEAR(date) FROM competition;



--SELECT GROUP BY � ��������� ���������.

--7.1. MINIMUM 

SELECT first_name, MIN(age) AS 'min_age' FROM sportsman GROUP BY first_name;

--7.2. MAXIMUM

SELECT last_name, MAX(age) AS 'max_age' FROM sportsman GROUP BY last_name;

--7.3. AVG - ������� �������� ������� � ������� 

SELECT last_name, AVG(age) AS 'avg_age' FROM sportsman GROUP BY last_name;

--7.4. SUM 

SELECT last_name, SUM(age) AS 'sum_age' FROM sportsman GROUP BY last_name;

--7.5. COUNT - ���������� ��������

SELECT last_name, COUNT(first_name) AS 'count_first_name' FROM sportsman GROUP BY last_name;



--SELECT GROUP BY + HAVING

--8.1. 3 ������� � GROUP BY + HAVING

SELECT first_name, SUM(age) AS 'sum_age' FROM sportsman GROUP BY first_name HAVING SUM(age) < 100; 
SELECT last_name, AVG(age) AS 'avg_age' FROM sportsman GROUP BY last_name HAVING AVG(age) > 30;
SELECT specialization, MAX(capacity) AS 'max_capacity' FROM stadium GROUP BY specialization HAVING MAX(capacity) > 1000; 


--SELECT JOIN

--9.1. LEFT JOIN + WHERE.

SELECT * FROM perfomance 

LEFT JOIN sportsman ON perfomance.id_sportsman = sportsman.id_sportsman WHERE start_position > 5;

--9.2. RIGHT JOIN 

SELECT * FROM perfomance 

RIGHT JOIN sportsman ON perfomance.id_sportsman = sportsman.id_sportsman ORDER BY id_perfomance ASC;

--9.3. LEFT JOIN 3 ������ + �� �������� WHERE � ������ �������.

SELECT first_name, last_name FROM sportsman 
LEFT JOIN sportsman_on_competition ON sportsman_on_competition.id_sportsman = sportsman.id_sportsman
LEFT JOIN competition ON sportsman_on_competition.id_competition = competition.id_competition 
WHERE age < 30 AND id_sportsman_on_competition > 1 AND city = 'Moskow';

--9.4. FULL OUTER JOIN 2 ������.

SELECT * FROM perfomance FULL OUTER JOIN stadium on perfomance.id_perfomance = stadium.id_stadium;



--����������

--������ � ����������� WHERE IN.

SELECT start_position,variety FROM perfomance WHERE id_sportsman IN(SELECT id_sportsman FROM sportsman WHERE first_name = '����'); 

--SELECT atr1, atr2, (���������) FROM ...

SELECT start_position, variety, (SELECT first_name FROM sportsman WHERE perfomance.id_sportsman = sportsman.id_sportsman) AS 'first_name' FROM perfomance;