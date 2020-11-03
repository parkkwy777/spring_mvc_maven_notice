SELECT *FROM REPLE;

SELECT r.*
FROM reple r
WHERE NO=4
START WITH r_level=0
CONNECT BY PRIOR REPNO = R_LEVEL
ORDER BY r_tolist asc;

SELECT *FROM NOTICE;
UPDATE NOTICE
SET COUNTING = COUNTING+1
WHERE NO=1;

SELECT *FROM NOTICE1 n ;
DELETE FROM notice1;

SELECT *FROM reple;

	SELECT *
		FROM(
		SELECT rownum cnt, r.*
		FROM 
		(SELECT * 
		FROM reple
		WHERE NO=4
		START WITH r_level=0
		CONNECT BY PRIOR REPNO = R_LEVEL
		ORDER BY r_tolist ASC) r)
		WHERE cnt BETWEEN  2 AND 3;
	
	SELECT *FROM notice 
	WHERE NO=?;
		
	SELECT * 
		FROM reple
		WHERE NO=4
		START WITH r_level=0
		CONNECT BY PRIOR REPNO = R_LEVEL
		ORDER BY r_tolist ASC;
		
	INSERT INTO reple values(4,seq_reple.nextval,0,to_char(SYSDATE,'MM-DD'),
						'댓글작성자1',sysdate,'별루별루'	);
						
					DELETE *FROM reple 
					WHERE NO=5;