--select id from example GROUP BY parent_id HAVING count(*) <= 3 ORDER BY count_pid ASC;
BEGIN TRANSACTION;

CREATE TABLE example
( id int,
parent_id int,
count_pid int)
COMMIT;

INSERT INTO example (id, parent_id, count_pid)
VALUES (1, null, 123);
INSERT INTO example (id, parent_id, count_pid)
VALUES (2, 1, 123);
INSERT INTO example (id, parent_id, count_pid)
VALUES (3, 1, 123);
INSERT INTO example (id, parent_id, count_pid)
VALUES (4, 2, 123);
INSERT INTO example (id, parent_id, count_pid)
VALUES (5, 3, 123);
INSERT INTO example (id, parent_id, count_pid)
VALUES (6, null, 1);
INSERT INTO example (id, parent_id, count_pid)
VALUES (7, 1, 34);
INSERT INTO example (id, parent_id, count_pid)
VALUES (8, 1, 23);
INSERT INTO example (id, parent_id, count_pid)
VALUES (9, 2, 12);
INSERT INTO example (id, parent_id, count_pid)
VALUES (10, 3, 754);

