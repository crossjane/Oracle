-- 1. 다중행함수(GROUP 함수)
-- 다중행 함수는 여러개의 데이터가 들어와서 여러개의 데이터가 리턴되는 함수
-- 그룹함수가 다중행 함수에 포함된다.
-- 그룹함수는 데이터들의 통계를 내는 함수들이 대부분이며 GROUP BY라는 키워드와 함께 사용된다.
-- GROUP BY는 데이터들의 통계를 내는데 어떤 컬럼을 기준으로 그룹화하여 통계를 낼건지 지정하는 구문이다.
-- 그룹함수를 사용할 때 주의할 점은 SELECT 절에 포함된 모든 컬럼들은 GROUP BY 절에 명시돼야 한다.
-- 학년별 학생들의 평점의 평균을 구하는 그룹함수
SELECT *
	FROM STUDENT
	ORDER BY SYEAR;

SELECT SYEAR
	 , SNAME 
	 , AVG(AVR)
	FROM STUDENT
	GROUP BY SYEAR, SNAME
	ORDER BY SYEAR, SNAME;

-- SELECT절에 포함된 컬럼들이 모두 GROUP BY에 명시돼야 하는 규칙때문에 데이터가 변질된다.
SELECT SYEAR
	 , MAJOR
	 , AVG(AVR)
	FROM STUDENT
	GROUP BY SYEAR, MAJOR
	ORDER BY SYEAR;

-- 원하는 통계함수 데이터를 조회하는 쿼리를 서브쿼리로 만들어서 다른 데이터들과 조인하여 사용한다.
SELECT ST.SNO
	 , ST.SNAME
	 , ST.MAJOR
	 , ST.SYEAR
	 , ST.AVR
	 , A.AVR
	FROM STUDENT ST
	JOIN (
		SELECT SYEAR
			 , AVG(AVR) AS AVR
			FROM STUDENT
			GROUP BY SYEAR
			ORDER BY SYEAR
	) A
	ON ST.SYEAR = A.SYEAR;
	
-- 1-1. MAX: 데이터들의 최고 값을 조회하는 그룹함수
-- 과목별 기말고사의 최고점 조회
SELECT CNO
	 , MAX(RESULT)
	FROM SCORE
	GROUP BY CNO;

-- 과목별 기말고사 최고점 조회하는데 과목번호, 과목이름, 점수 조회
SELECT SC.CNO
	 , C.CNAME
	 , MAX(SC.RESULT)
	FROM SCORE SC
	JOIN COURSE C
	  ON SC.CNO = C.CNO
	GROUP BY SC.CNO, C.CNAME;

-- 과목별 기말고사 최고점 조회하는데 과목번호, 과목이름, 학생번호, 학생이름, 점수 조회

SELECT A.CNO 
	 , A.CNAME 
	 , A.MAX_RESULT
	 , ST.SNO
	 , ST.SNAME 
	 FROM (
			SELECT 	C.CNO
					 , C.CNAME 
					 , MAX(SC.RESULT) AS MAX_RESULT
					 FROM COURSE C
					 JOIN SCORE SC 
					 ON C.CNO = SC.CNO 
					 GROUP BY SC.CNO, C.CNAME
					 )A
		JOIN SCORE SSC
	      ON A.CNO = SSC.CNO
	     AND A.MAX_RESULT = SSC.RESULT
		JOIN STUDENT ST					 
		  ON SSC.SNO = ST.SNO;
	    

-- 과목별 기말고사 최고점 조회하는데 과목번호, 과목이름, 학생번호, 학생이름, 점수 조회
SELECT A.CNO
	 , A.CNAME
	 , ST.SNO
	 , ST.SNAME 
	 , ST.SYEAR 
	 , ST.MAJOR
	 , A.MAX_RESULT
	FROM (
		SELECT SC.CNO
			 , C.CNAME
			 , MAX(SC.RESULT) AS MAX_RESULT
			FROM SCORE SC
			JOIN COURSE C
			  ON SC.CNO = C.CNO
			GROUP BY SC.CNO, C.CNAME
	) A
	JOIN SCORE SSC
	  ON A.CNO = SSC.CNO 
	 AND A.MAX_RESULT = SSC.RESULT 
	JOIN STUDENT ST
	  ON SSC.SNO = ST.SNO;

-- 잘못된 쿼리
SELECT SC.CNO
	 , C.CNAME
	 , ST.SNO
	 , ST.SNAME
	 , MAX(SC.RESULT) AS MAX_RESULT
	FROM SCORE SC
	JOIN COURSE C
	  ON SC.CNO = C.CNO
	JOIN STUDENT ST
	  ON SC.SNO = ST.SNO
	GROUP BY SC.CNO, C.CNAME, ST.SNO, ST.SNAME;


--데이터 전체에 대한 통계를 낼 때는 GROUP BY를 사용하지 않는다 
SELECT MAX(AVR)
	FROM STUDENT; 

--1-2. MIN  : 그룹화된 데이터중 최소값을 조회하는 함수 
--학년별 최저 평점 조회 (학년, 평점) 
SELECT SYEAR
	 , MIN(AVR)
	 FROM STUDENT
	GROUP BY SYEAR;

--부서번호, 부서별 최저 급여 조회 
 
SELECT DNO
	, MIN(SAL)
	FROM EMP
	GROUP BY DNO
	ORDER BY DNO;

--부서번호, 부서이름, 부서별 최저 급여 조회 

 
SELECT D.DNO
	, D.DNAME
	, MIN(E.SAL)
	FROM DEPT D
	JOIN EMP E 
	ON D.DNO = E.DNO
	GROUP BY D.DNO, D.DNAME ; 


--부서번호, 부서이름, 부서별 최저 급여,최저급여에 해당하는 사원번호, 사원이름 조회


--잘못된 GROUP BY
 
SELECT D.DNO
	, D.DNAME
	, MIN(E.SAL)
	, E.ENO 
	, E.ENAME
	FROM DEPT D
	JOIN EMP E 
	ON D.DNO = E.DNO
	GROUP BY D.DNO, D.DNAME, E.ENO, E.ENAME ; 

---통계함수의 값이 변질되지 않게 하려면 통계함수를 조회하는 쿼리를 서브쿼리로 작성한다.
SELECT A.DNO 
	, A.DNAME 
	, A.MIN_SAL 
	, EE.ENO 
	, EE.ENAME
	, EE.SAL 
FROM (
	SELECT D.DNO 
		, D.DNAME
	, MIN(E.SAL) AS MIN_SAL
	FROM DEPT D 
	JOIN EMP E 
	ON D.DNO = E.DNO
	GROUP BY D.DNO, D.DNAME
	ORDER BY D.DNO
		)A
JOIN EMP EE
ON A.DNO = EE.DNO
--여기까지만 하면 부서번호 같은 사람들은 다 조회가 될것이다. 
--우리가 원하는 데이터는 총무과의 최저 SAL 1명사원만 나오게 된다 그래서 
--AND절로 최저 급여 조건도 넣어 주어야 한다.
AND A.MIN_SAL = EE.SAL;



SELECT A.DNO 
	, A.DNAME 
	, A.MIN_SAL 
	, EE.ENO 
	, EE.ENAME
	, EE.SAL 
FROM EMP EE
JOIN 
(
	SELECT D.DNO 
		, D.DNAME
	, MIN(E.SAL) AS MIN_SAL
	FROM DEPT D 
	JOIN EMP E 
	ON D.DNO = E.DNO
	GROUP BY D.DNO, D.DNAME
		)A
ON A.DNO = EE.DNO
AND A.MIN_SAL = EE.SAL;


--1-3. SUM : 그룹화된 데이터의 총합을 구하는 합수 
--사원들의 업무별 보너스의 총합 

SELECT JOB
	 , SUM(NVL(COMM,0))
	 FROM EMP 
	 GROUP BY JOB;

--1-4.COUNT: 그룹화된 데이터에 대한 개수를 조회하는 함수 
--COUNT(*) : 모든 컬럼데이터에 대한 행의 개수를 리턴. 특정 컬럼에 NULL이 포함되어 있어도 개수에 포함한다. 
--COUNT(특정 컬럼명) : 특정 컬럼에 대한 모든 행의 개수를 리턴. 지정된 컬럼에 NULL 이 있으면 카운팅을 하지 않는다.
--부서별 사원수 조회
SELECT DNO 
	, COUNT(*)
	FROM EMP 
GROUP BY DNO;

--DNO이 NULL값은 카운팅 되지 않음.컬럼인 값이 NULL이면 조회 수 카운트 X
SELECT DNO
	 , COUNT(DNO)
	 FROM EMP 
	 GROUP BY DNO;
	
--1-5. AVG : 그룹화 된 테이터에 대한 평균 값을 구하는 함수 
--전공별 학년별 평균 평점 조회 
	
SELECT MAJOR 
	, SYEAR
	, AVG(AVR)
	FROM STUDENT
	GROUP BY MAJOR, SYEAR
	ORDER BY MAJOR, SYEAR;

--전공별 학년별 학생 수 조회

SELECT  MAJOR
	 , SYEAR
	 , COUNT(SNO)
	FROM STUDENT
	 GROUP BY MAJOR, SYEAR;
	
SELECT  MAJOR
	 , SYEAR
	 , COUNT(*)
	FROM STUDENT
	 GROUP BY MAJOR, SYEAR
	 ORDER BY MAJOR, SYEAR;
	
--1-6. HAVING : GROUP BY 에 명시된 컬럼에 대한 조건을 만들 수 있는 구문 
--부서번호가 10, 20, 30에 대한 평균 급여 조회

SELECT DNO 
	, AVG(SAL)
	FROM EMP 
	GROUP BY DNO 
	HAVING DNO IN ('10', '20', '30');

SELECT DNO 
	, AVG(SAL)
	FROM EMP 
	WHERE DNO IN ('10', '20', '30')
	GROUP BY DNO;
	
-- AND/ OR 여러개 조건을 작성할 수 있고 
--HAVING 절에는 통계함수에 대한 조건도 작성할 수 있다. 
	
SELECT DNO 
	, AVG(SAL)
	FROM EMP 
	GROUP BY DNO 
	HAVING DNO IN ('10', '20', '30')
 	AND AVG(SAL) >= 3000;
	
	
--HAVING 절에는 GROUP BY에 명시되지 않았거나 통계함수가 아닌 조건은 작성할 수 없다.
 --GROUP BY 의 표현식이 아니게 됨. COMM 이 명시되지 않음. 
SELECT DNO 
	, AVG(SAL)
	FROM EMP 
	GROUP BY DNO 
	HAVING COMM >= 300;
	
--WHERE 절에서는 통계함수에 대한 조건을 작성할 수 없다. 
--무조건 HAVING 절로 빼거나 . 
SELECT DNO 
	, AVG(SAL)
	FROM EMP 
	WHERE AVG(SAL) <= (
		SELECT MAX(SAL)
			FROM EMP 
	)
	GROUP BY DNO;

--통계함수에 대한 조건을 WHERE절에서 사용하려면 통계함수를 포함한 쿼리를 서브쿼리로 묶는다.

SELECT A.*
	FROM(
				SELECT DNO 
					, AVG(SAL) AS AVG_SAL
					FROM EMP 
					GROUP BY DNO 
	)A
	WHERE A.AVG_SAL <= (
							SELECT MAX(SAL)
								FROM EMP
	);
	
	
--임용년도가 2000년 이전이고 임용년도가 동일한 교수의 수 조회


SELECT TRUNC(HIREDATE, 'YYYY')
	, COUNT(*)
	FROM PROFESSOR 
	GROUP BY TRUNC(HIREDATE,'YYYY')
	HAVING TRUNC(HIREDATE, 'YYYY') < TO_DATE('2000/01/01', 'YYYY/MM/DD')
	ORDER BY TRUNC (HIREDATE, 'YYYY');


--연도만 쓰면 정확한 값이 잡히지 않는다.
SELECT  TO_DATE('2000', 'YYYY')
	FROM DUAL;

SELECT TO_CHAR(HIREDATE,'YYYY')
	 ,COUNT(*)
	 FROM PROFESSOR 
	 GROUP BY TO_CHAR(HIREDATE, 'YYYY')
	 HAVING TO_CHAR(HIREDATE,'YYYY') < '2000'
	 AND COUNT(*)> 5
	ORDER BY TO_CHAR(HIREDATE,'YYYY');

--내가 푼 것. HIREDATE를 연도로 묶지 않아서 같은년도 날짜가 분리가 된다.
SELECT COUNT(PNO)
	 , HIREDATE 
	 FROM PROFESSOR 
	 GROUP BY HIREDATE 
	 HAVING HIREDATE < ROUND(HIREDATE, 'YYYY')
	 ORDER BY HIREDATE ;
	
--	TRUNC(날짜, 날짜단위(년도, 월, 일, 시, 분, 초)) : 지정한 단위까지의 날짜를 빼서 가져오고 
--나머지 단위들은 초기화된 상태로 출력. 날짜의 상태에 따라서 버림. ex) 
--TRUNC(SYSDATE, 'yyyy') -> 20230101 00:00:00
	
	
	
--	
 
