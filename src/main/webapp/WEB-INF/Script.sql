/*ALTER TABLE notice 
MODIFY today varchar2(100);*/
DROP TABLE notice; 


CREATE TABLE notice(
	NO NUMBER,
	header varchar2(50),
	title varchar(150),
	writer varchar(150),
	today varchar(150),
	tolist DATE,
	counting NUMBER,
	upPoint NUMBER,
	etc varchar2(500),
	--답글 처리를 위해 상위글번호 
	refno number
);
/*
ALTER TABLE notice
ADD refno number;
*/

ALTER TABLE notice
ADD CONSTRAINT PK_notice
	PRIMARY KEY(
		NO
	);
--reple 테이블 생성
DROP TABLE reple;
DELETE FROM reple;
DROP SEQUENCE seq_reple;
ALTER TABLE reple 
DROP CONSTRAINT FK_notice_to_reple;
DROP TABLE reple CASCADE constraints;
CREATE TABLE reple(
	NO NUMBER,
	repno NUMBER,
	r_level NUMBER,
	r_today varchar(150),
	r_writer varchar(150),
	r_tolist DATE,
	r_etc varchar(200)
);
ALTER TABLE reple
ADD CONSTRAINT FK_notice_to_reple
FOREIGN KEY(no)
REFERENCES notice(no) ON DELETE CASCADE;

CREATE SEQUENCE seq_reple
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999
	CYCLE;
ALTER SEQUENCE seq_reple nocache;
-- no를 참조키로 설정하고 부모는 notice테이블의 no로 설정




CREATE TABLE noticefile(
	NO NUMBER,
	fname varchar(500),
	credte DATE,
	uptdte DATE,
	etc varchar2(500)
);

DROP SEQUENCE NOTICE_SEQ;
CREATE SEQUENCE notice_seq
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 999
	CYCLE;
ALTER SEQUENCE notice_seq nocache;
/*	title varchar(150),
	writer varchar(150),
	today DATE,
	counting NUMBER,
	upPoint NUMBER,
	etc varchar2(500)*/
/*alter user C##park default tablespace users quota unlimited on users;*/
select NOTICE_SEQ.currval from dual;
select NOTICE_SEQ.nextval from dual;

DELETE FROM NOTICE 
WHERE NO>=7;
/* 게시판글 추가 */
INSERT INTO notice values(notice_seq.nextval,'잡담','제목1','렌고쿠쿄쥬로',to_char(SYSDATE,'MM-DD'),sysdate,0, 0,'안녕하세요',0);
INSERT INTO notice values(notice_seq.nextval,'잡담','제목2','기유',to_char(SYSDATE,'MM-DD'),sysdate,0, 0,'안녕하세요2',0);
INSERT INTO notice values(notice_seq.nextval,'잡담','제목3','시노부',to_char(SYSDATE,'MM-DD'),sysdate,0, 0,'안녕하세요3',0);
INSERT INTO notice values(notice_seq.nextval,'잡담','제목4','탄지로',to_char(SYSDATE,'MM-DD'),sysdate,0, 0,'안녕하세요4',0);
INSERT INTO notice values(notice_seq.nextval,'잡담','제목5','무이치로',to_char(SYSDATE,'MM-DD'),sysdate,0, 0,'안녕하세요5',0);

SELECT *FROM notice;
UPDATE notice
SET refno =0;

/* 댓글 추가 
 * 	NO NUMBER,
	repno NUMBER,
	r_today varchar(150),
	r_writer varchar(150),
	r_tolist DATE,
	r_etc varchar(200)
 * 
 * */
DELETE reple;
INSERT INTO reple values(4,seq_reple.nextval,0,to_char(SYSDATE,'MM-DD'),
						'댓글작성자1',sysdate,'별루별루'	);
INSERT INTO reple values(4,seq_reple.nextval,1,to_char(SYSDATE,'MM-DD'),
						'댓글에댓글작성자1',sysdate,'왜 별로야?'	);
INSERT INTO reple values(4,seq_reple.nextval,2,to_char(SYSDATE,'MM-DD'),
						'댓댓댓글작성자',sysdate,'별로니까 별로지'	);

SELECT *FROM REPLE r ;

/* 댓글 게시판 */ 
SELECT r.*
FROM reple r
START WITH r_level=0
CONNECT BY PRIOR REPNO = R_LEVEL
ORDER BY r.R_TOLIST DESC;


SELECT r.*
FROM reple r
START WITH r_level=0
CONNECT BY PRIOR REPNO = R_LEVEL
ORDER BY r_tolist desc;


	select rownum cnt, notice.* 
	from notice
	where 1=1;

	
CREATE TABLE notice1
AS SELECT *FROM reple;
SELECT *FROM reple;
CREATE TABLE reple2
AS SELECT NO,repno,R_LEVEL,R_TODAY ,R_WRITER,R_TOLIST ,R_ETC FROM reple1;
CREATE TABLE notice2
AS SELECT * FROM notice1;


SELECT *
FROM(
	SELECT rownum cnt, n.*
	FROM (SELECT * 
		  FROM notice n
		  ORDER BY TOLIST DESC) n)
WHERE cnt BETWEEN 2 AND 5
AND WRITER LIKE '%'||'탄지로'||'%';

ORDER BY TOLIST desc; 


	SELECT *
	FROM(
		SELECT rownum cnt, n.*
		FROM (SELECT *
			  FROM notice n
			  ORDER BY TOLIST DESC) n)
			WHERE cnt BETWEEN 1 AND 3;
		
SELECT *FROM(	
	SELECT *
		FROM(
		SELECT rownum cnt, r.*
		FROM 
		(SELECT * 
		FROM reple
		WHERE NO=3
		--r_level 0인것만 1~10개
		AND r_level =0
		ORDER BY R_TOLIST desc) r)
		WHERE cnt BETWEEN 1 AND 10
		and R_LEVEL =0
		UNION
		--댓글 합치기위해
		SELECT rownum cnt, r.* FROM 
		reple r
		WHERE R_LEVEL >1
		)
		--관계형으로 설정 r_level 0의 하위로 들어가게 처리
		START WITH r_level=0
		CONNECT BY PRIOR REPNO = R_LEVEL;
