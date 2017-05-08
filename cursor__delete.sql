DECLARE @PARENT_ID INT;
DECLARE @COUNT_TOTAL INT;
DECLARE @CURSOR CURSOR;
DECLARE @TableToDelete TABLE(  
    parent_id int not null,  
    countToDelete int not null
	);
INSERT INTO @TableToDelete SELECT DISTINCT parent_id, countToDelete FROM example, (SELECT p_id, (Count - 3) AS countToDelete FROM(SELECT parent_id AS p_id, COUNT(*) AS Count
				FROM example GROUP BY parent_id HAVING parent_id is not null) AS table2 WHERE table2.Count > 3) AS table3
     			WHERE parent_id = table3.p_id;

SET @CURSOR = CURSOR SCROLL
FOR SELECT * FROM @TableToDelete;
OPEN @CURSOR;
   FETCH NEXT FROM @CURSOR INTO @PARENT_ID, @COUNT_TOTAL
	WHILE @@FETCH_STATUS = 0
	BEGIN
	       WITH T
	        	AS (SELECT TOP(@COUNT_TOTAL) * FROM example WHERE parent_id=@PARENT_ID ORDER BY id, count_pid ASC)
			DELETE FROM T
      FETCH NEXT FROM @CURSOR INTO @PARENT_ID, @COUNT_TOTAL
    END
CLOSE @CURSOR
DEALLOCATE @CURSOR