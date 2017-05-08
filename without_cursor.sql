DECLARE @TableToDelete TABLE(  
    parent_id int not null,  
    countToDelete int not null
	);
DECLARE @COUNT_ROWS int;
DECLARE @pid int;
DECLARE @cPid int;
INSERT INTO @TableToDelete SELECT DISTINCT parent_id, countToDelete FROM example, (SELECT p_id, (Count - 3) AS countToDelete FROM(SELECT parent_id AS p_id, COUNT(*) AS Count
				FROM example GROUP BY parent_id HAVING parent_id is not null) AS table2 WHERE table2.Count > 3) AS table3
     			WHERE parent_id = table3.p_id;
SET @COUNT_ROWS = (SELECT COUNT(*) FROM @TableToDelete);
WHILE (@COUNT_ROWS > 0)
BEGIN
SET @pid  = (SELECT parent_id FROM (
             SELECT ROW_NUMBER() OVER(ORDER BY parent_id, countToDelete ASC) AS Row1,
		     parent_id, countToDelete FROM @TableToDelete) AS table1 WHERE table1.Row1 = @COUNT_ROWS);

SET @cPid = (SELECT countToDelete FROM (
             SELECT ROW_NUMBER() OVER(ORDER BY parent_id, countToDelete ASC) AS Row1,
		     parent_id, countToDelete FROM @TableToDelete) AS table1 WHERE table1.Row1 = @COUNT_ROWS);

WITH T
    AS (SELECT TOP(@cPid) * FROM example WHERE parent_id=@pid ORDER BY id,count_pid ASC)
DELETE FROM T
SET @COUNT_ROWS = @COUNT_ROWS - 1;
END