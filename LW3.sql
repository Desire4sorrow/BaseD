--INSERT(���������) 
--1.1. ��� �������� ������ �����.
INSERT INTO stadium VALUES ('Moskow', 100, 10000, 'winter');
--1.2. � ��������� ������ �����.
INSERT INTO perfomance (price, date, duration)
VALUES ('1000', 2012-10-20,'00:01:23');
--1.3. � ������� �������� �� ������ �������.
INSERT INTO sportsman_on_competition(id_stadium) SELECT id_stadium FROM stadium;

--DELETE(�������� �������) 
--2.1. ���� �������.
DELETE stadium;
--2.2. �� �������. 
DELETE FROM perfomance WHERE price < 1000;
--2.3. �������� �������.
TRUNCATE TABLE perfomance;

--UPDATE(����������, ��������� � ��� ������������ �������)
--3.1. ���� �������.
UPDATE competition SET location = 'Moskow';
--3.2. �� ������� �������� �������.
UPDATE competition SET name = 'Championship' WHERE location = 'Kazan';
--3.3. �� ������� �������� ��������� ���������.
UPDATE competition SET name = 'Championship', location = 'Kazan' WHERE date = '2020-12-12';

--SELECT 
--4.1. � ������������ ������� ����������� ���������.
SELECT first_name, last_name, gender FROM sportsman;
--4.2. �� ����� ���������� � �������. 
SELECT * FROM sportsman;
--4.3. � �������� �� ��������. 
SELECT * FROM sportsman WHERE first_name = '����';

--SELECT ORDER BY + TOP(LIMIT)
--5.1. � ����������� �� ����������� ASC + ����������� ������ ���������� �������.
SELECT * FROM sportsman_on_competition ORDER BY amount ASC;
--5.2. � ����������� �� �������� DESC.
SELECT * FROM sportsman_on_competition ORDER BY position DESC;
--5.3. � ����������� �� ���� ��������� + ����������� ������ ���������� �������.
SELECT TOP 4 * FROM sportsman_on_competition ORDER BY amount DESC, position DESC;
--5.4. � ����������� �� ������� ��������, �� ������ �����������, ������������� �������.
SELECT * FROM sportsman_on_competition ORDER BY 1 DESC;

--������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
--6.1. WHERE �� ������� ����. 
SELECT * FROM sportsman WHERE birthday = '2000-12-12';
--6.2. ������� ������ ��� �� �������.
SELECT YEAR(birthday) FROM sportsman;

--SELECT GROUP BY � ��������� ���������.
--7.1. MINIMUM 
SELECT id_sportsman_on_competition, MIN(amount) AS min_amount FROM sportsman_on_competition GROUP BY id_sportsman_on_competition;
--7.2. MAXIMUM
SELECT id_sportsman_on_competition, MAX(position) AS max_position FROM sportsman_on_competition GROUP BY id_sportsman_on_competition;
--7.3. AVG - ������� �������� ������� � ������� 
SELECT id_stadium, AVG(capacity) AS avg_capacity FROM stadium GROUP BY id_stadium;
--7.4. SUM 
SELECT id_stadium, SUM(capacity) AS sum_capacity FROM stadium GROUP BY id_stadium;
--7.5. COUNT - ���������� ��������
SELECT specialization, COUNT(capacity) AS count_capacity FROM stadium GROUP BY specialization;

--SELECT GROUP BY + HAVING
--8.1. 3 ������� � GROUP BY + HAVING
SELECT id_stadium, COUNT(capacity) AS count_capacity FROM stadium GROUP BY id_stadium HAVING COUNT(capacity) > 5000; --����� ���������, ����������� ������� ������ 5 �����.
SELECT placement, AVG(capacity) AS avg_capacity FROM stadium GROUP BY placement HAVING AVG(capacity) = 5000; --������ ������� � ������� ������������ ��������� 5000.
SELECT placement, COUNT(placement) AS count_same_placement FROM stadium GROUP BY placement HAVING COUNT(placement) > 1; --����� ��������� � ���������� �������������.

--SELECT JOIN
--9.1. LEFT JOIN + WHERE.
SELECT * FROM stadium 
LEFT JOIN sportsman_on_competition ON stadium.id_stadium = sportsman_on_competition.id_stadium WHERE capacity > 5000;
--9.2. RIGHT JOIN 
SELECT * FROM stadium 
RIGHT JOIN sportsman_on_competition ON stadium.id_stadium = sportsman_on_competition.id_stadium;
--9.3. LEFT JOIN 3 ������ + �� �������� WHERE � ������ �������.
SELECT * FROM sportsman_on_competition 
LEFT JOIN sportsman ON sportsman_on_competition.id_sportsman_on_competition = sportsman.id_sportsman_on_competition
LEFT JOIN competition ON sportsman.id_sportsman_on_competition = competition.id_sportsman_on_competition
WHERE position > 10 AND first_name = '�������' AND id_competition > 3;
--9.4. FULL OUTER JOIN 2 ������.
SELECT * FROM perfomance FULL OUTER JOIN stadium on perfomance.id_perfomance = stadium.id_stadium;
--����������
--������ � ����������� WHERE IN.
SELECT first_name, last_name, gender, birthday FROM sportsman WHERE id_perfomance IN(SELECT id_perfomance FROM perfomance WHERE date = '2019-12-11'); --������ ����������, ������������ 11 ������� 19 ����.
--SELECT atr1, atr2, (���������) FROM ...
SELECT date, price, (SELECT id_sportsman_on_competition FROM sportsman WHERE sportsman.id_perfomance = perfomance.id_perfomance) AS id_sportsmans_perfomance FROM perfomance;  --����� ����, ���� � id ����������� ����������. 