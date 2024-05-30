--01
--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH PRO AS (
	SELECT PNAME 
		, ORDERS 
		FROM PROFESSOR 
		WHERE ORDERS = '정교수'
),
	NORMCOURSE AS(
	SELECT C.CNO 	
	 	 , C.CNAME 
	 	 , P.PNO 
	 	 , P.PNAME 
	 	 FROM COURSE C
	 	 JOIN PROFESSOR P
	 	 ON P.PNO = C.PNO
	 	 WHERE C.CNAME LIKE '%일반%'
)
SELECT NORMCOURSE.CNO
	 , NORMCOURSE.CNAME
	 , PRO.PNAME
	 FROM PRO
	 JOIN NORMCOURSE
	 ON NORMCOURSE.PNAME = PRO.PNAME
	 

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH OVER3000 AS (
	SELECT ENO	
	 	 , ENAME 
	 	 , SAL
	 	 FROM EMP 
	 	 WHERE SAL >= 3000
), 
	 OVER500COMM AS (
	 SELECT ENO 
	 	, ENAME 
	 	, COMM
	 	FROM EMP 
	 	WHERE COMM >= 500
	 )
SELECT OVER3000.ENO
	, OVER3000.ENAME 
	, OVER3000.SAL
	,OVER500COMM.COMM
	FROM OVER3000
	JOIN OVER500COMM
	 ON OVER3000.ENO = OVER500COMM.ENO;
	 
	 
	 
	 

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.


--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.


--02

--1) STUDENT 테이블을 참조하여 ST_TEMP 테이블을 만들고 모든 학생의 성적을 4.5만점 기준으로 수정하세요
CREATE TABLE ST_TEMP
	AS SELECT *
	FROM STUDENT;
COMMIT;

UPDATE ST_TEMP 
	 SET AVR = AVR*1.125;
COMMIT;
	 
SELECT *
	FROM ST_TEMP;
	

--2) PROFESSOR 테이블을 참조하여 PF_TEMP 테이블을 만들고 모든 교수의 부임일자를 100일 앞으로 수정하세요

CREATE TABLE PF_TEMP
	AS SELECT *
	FROM PROFESSOR;
COMMIT;

UPDATE PF_TEMP 
 	SET HIREDATE = HIREDATE - 100;
 COMMIT;
 
SELECT *
	FROM PF_TEMP;


--3) ST_TEMP 테이블에서 화학과 2학년 학생의 정보를 삭제하세요
DELETE FROM ST_TEMP 
	WHERE MAJOR = '화학'
	AND SYEAR = 2;
COMMIT;

--4) PF_TEMP 테이블에서 조교수의 정보를 삭제하세요
DELETE FROM PF_TEMP 
	WHERE ORDERS ='조교수';
COMMIT;	
	


--5) EMP 테이블을 참조하여 EMP2 테이블을 만들고 
-- DNO = 30인 사원의 보너스를 15프로 상승시킨 값으로 변경하시고
-- DNO = 10인 사원의 보너스를 5프로 상승시킨 값으로 변경, 
-- DNO = 20인 사원의 급여를 10프로 상승시킨 값으로 변경하세요.

CREATE TABLE EMP2 
 AS SELECT * 
 	FROM EMP;
 COMMIT;

SELECT *
	FROM EMP2;

UPDATE EMP2
	 SET SAL = SAL * 1.1
	 WHERE DNO = 20;
COMMIT;

UPDATE EMP2
	 SET COMM = COMM * 1.15
	 WHERE DNO = 30;
COMMIT;
	 

UPDATE EMP2
	 SET COMM = COMM * 1.05
	 WHERE DNO = 10;
COMMIT;

SELECT *
	FROM EMP2;	 

--CASE ~ WHEN
--        - CASE 컬럼명 or 조회데이터
--              WHEN 조건1 THEN 조건1이 true인 데이터 처리내용
--              WHEN 조건2 THEN 조건2가 true인 데이터 처리내용
--              .....
--              WHEN 조건n THEN 조건n이 true인 데이터 처리내용
--              ELSE 조건1~조건n까지 모두 false인 데이터 처리내용


--6) 화학과 2학년 학생중 기말고사 성적의 등급이 A, B인 정보를 갖는 테이블 SCORE_STGR을 생성하세요.

--(SNO, SNAME, MAJOR, SYEAR, RESULT, GRADE)


CREATE TABLE SCORE_STGR (SNO, SNAME, MAJOR, SYEAR, RESULT, GRADE)
	AS SELECT S.SNO
		, S.SNAME
		, S.MAJOR
		,S.SYEAR
		,SC.RESULT
		,GR.GRADE 
		FROM STUDENT S
		JOIN SCORE SC 
		ON S.SNO = SC.SNO 
		JOIN SCGRADE GR 
		ON SC.RESULT BETWEEN GR.LOSCORE AND GR.HISCORE
		WHERE GR.GRADE IN ('A','B')
		AND S.MAJOR = '화학'
		AND S.SYEAR = '2'; 

SELECT *
	FROM SCORE_STGR;


--7) 생물학과 학생중 평점이 2.7이상인 학생이 수강중인 과목의 정보를 갖는 테이블 ST_COURSEPF를 생성하세요.
-- (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
CREATE TABLE ST_COURSEPF (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR, MAJOR)
 	AS SELECT S.SNO
 	, S.SNAME
 	, C.CNO
 	, C.CNAME
 	, P.PNO
 	, P.PNAME
 	, S.AVR
 	, S.MAJOR
 	FROM STUDENT S 
 	JOIN SCORE SC
 	ON S.SNO = SC.SNO
 	JOIN COURSE C 
 	ON SC.CNO = C.CNO 
 	JOIN PROFESSOR P
 	ON P.PNO = C.PNO
 	WHERE S.MAJOR = '생물'
 	AND S.AVR >= 2.7;
 
 DROP TABLE  ST_COURSEPF;

SELECT *
	FROM ST_COURSEPF;
