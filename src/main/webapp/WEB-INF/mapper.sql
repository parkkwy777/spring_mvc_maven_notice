SELECT count(no)
FROM notice;
SELECT *
	FROM(
		SELECT rownum cnt, n.*
		FROM (SELECT *
			  FROM notice n
			  ORDER BY TOLIST DESC) n)
			WHERE cnt BETWEEN 1 AND 3;