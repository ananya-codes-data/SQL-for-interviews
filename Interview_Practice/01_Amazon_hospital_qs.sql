USE practice_sql;

create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


SELECT *
FROM hospital;

-- Write a sql query to find the total number of people present inside the hospital

-- Method-1:

SELECT
	emp_id,
	MAX(CASE WHEN action = 'in' THEN time END) AS intime,
	MAX(CASE WHEN action = 'out' THEN time END) AS outtime
FROM hospital
GROUP BY emp_id
HAVING 
	MAX(CASE WHEN action = 'in' THEN time END) > MAX(CASE WHEN action = 'out' THEN time END)
	OR MAX(CASE WHEN action = 'out' THEN time END) IS NULL

WITH emp_present AS
(
	SELECT
		emp_id,
		MAX(CASE WHEN action = 'in' THEN time END) AS intime,
		MAX(CASE WHEN action = 'out' THEN time END) AS outtime
	FROM hospital
	GROUP BY emp_id
)
SELECT *
FROM emp_present
WHERE 
	intime > outtime
	OR outtime IS NULL

-- Method-2:

WITH intime AS
(
SELECT
	emp_id,
	MAX(time) AS intime
FROM hospital
WHERE action = 'in'
GROUP BY emp_id
),
outtime AS
(
SELECT
	emp_id,
	MAX(time) AS outtime
FROM hospital
WHERE action = 'out'
GROUP BY emp_id
)
SELECT
	i.emp_id
FROM intime AS i
FULL JOIN outtime AS o
ON i.emp_id = o.emp_id
WHERE i.intime > o.outtime
	OR o.outtime IS NULL


-- Method-3:

WITH latest_time AS
(
SELECT
	emp_id,
	MAX(time) AS latest_time
FROM hospital
GROUP BY emp_id
),
latest_in_time AS
(
SELECT
	emp_id,
	MAX(time) AS latest_intime
FROM hospital
WHERE action = 'in'
GROUP BY emp_id
)
SELECT
	lt.emp_id
FROM latest_time AS lt
INNER JOIN latest_in_time AS lit
ON lt.emp_id = lit.emp_id
	AND lt.latest_time = lit.latest_intime