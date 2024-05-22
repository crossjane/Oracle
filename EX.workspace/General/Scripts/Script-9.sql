--1. SUB QUERY 
--1-1. 단일 행 서브쿼리 
--SELECT , FROM , JOIN , WHERE절에서 사용가능한 서브쿼리 
--송강 교수보다 부임일자가 빠른 교수들의 번호, 교수이름 조회

SELECT PNO 
	 , PNAME
	FROM PROFESSOR P
	WHERE HIREDATE < (
						SELECT HIREDATE 
							FROM PROFESSOR P
							WHERE PNAME = '송강'

			     	);

--손하늘 사원보다 급여(연봉)가 높은 사원의 사원 번호 , 사원이름, 급여 조회 

SELECT E.ENO 
	 , E.ENAME 
	 , E.SAL
	FROM EMP E 
	WHERE E.SAL > (
			SELECT SAL
				 FROM EMP 
				 WHERE ENAME = '손하늘'
		);
		
--위 쿼리를 JOIN 절로 변경 

SELECT E.ENO 
 	 , E.ENAME
 	 , E.SAL
 	 , A.SAL
 	FROM EMP E 
 	JOIN (
 		SELECT SAL 
 			FROM EMP 
 			WHERE ENAME = '손하늘'
 	
 	) A
 	ON E.SAL >A.SAL;
 	
 --공융의 일반화학 기말고사 성적보다 높은 학생의 학생번호, 학생이름, 과목번호, 과목이름 , 기말고사 성적 조회 
 

 SELECT SC.RESULT
	FROM SCORE SC
	JOIN STUDENT ST
	  ON SC.SNO = ST.SNO
	JOIN COURSE C
	  ON SC.CNO = C.CNO 
	WHERE ST.SNAME = '공융'
	  AND C.CNAME = '일반화학';

SELECT SST.SNO
	 , SST.SNAME
	 , SSC.CNO
	 , SSC.CNAME
	 , SCO.RESULT
	FROM STUDENT SST
	JOIN SCORE SCO
	  ON SST.SNO = SCO.SNO 
	JOIN COURSE SSC
	  ON SCO.CNO = SSC.CNO 
	 AND SSC.CNAME = '일반화학'
	JOIN (
		SELECT SC.RESULT
			FROM SCORE SC
			JOIN STUDENT ST
			  ON SC.SNO = ST.SNO
			JOIN COURSE C
			  ON SC.CNO = C.CNO 
			WHERE ST.SNAME = '공융'
			  AND C.CNAME = '일반화학'
	) A
	  ON SCO.RESULT > A.RESULT;
 
 --1-2. 다중행 서브쿼리 
 --서브쿼리의 결과가 여러행인 서브쿼리 
 --FROM, JOIN, WHERE 절에서 사용가능 
 --급여가 3000이상인 사원의 사원번호, 사원이름, 급여 조회 
 
 SELECT SAL 
 	FROM EMP 
 	WHERE SAL >= 3000; 
 
SELECT E.ENO
	 , E.ENAME 
	 , E.SAL
	 FROM EMP E 
	 JOIN (
	 		SELECT ENO 
	 			FROM EMP 
	 			WHERE SAL >= 3000

	 ) A
	 ON E.ENO = A.ENO;
	
--WHERE 절에서 사용
	
	--?? 뭘비교

SELECT E.ENO
	 , E.ENAME 
	 , E.SAL
	 FROM EMP E 
	 WHERE E.ENO IN (
	 
	 		SELECT ENO 
 			FROM EMP 
 			WHERE SAL >= 3000
	 )

 
 
 