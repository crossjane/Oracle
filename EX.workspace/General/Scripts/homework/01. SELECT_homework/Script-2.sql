---2	
--1) 각 학생의 평점을 검색하라(별칭을 사용)
SELECT SNAME 이름
	 , AVR 평점
	 FROM STUDENT;

--2) 각 과목의 학점를 검색하라(별칭을 사용)
	
SELECT CNAME 과목이름
  	 , ST_NUM 학점
  	 FROM COURSE;


--3) 각 교수의 지위를 검색하라(별칭을 사용)
  	
SELECT PNAME 교수이름
	 , ORDERS  교수직위
	 FROM PROFESSOR;

--4) 급여를 10% 인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
SELECT SAL 인상급여
	FROM EMP
	WHERE SAL = SAL+(SAL * 0.1);

SELECT ENAME
	 , SAL
	 , SAL * 1.1 + COMM AS "인상 후 급여"
	 FROM EMP;
	
	


--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
SELECT SNAME
 	 , AVR 
 	 , ((AVR /4.0) *4.5) AS "4.5점"
 	 FROM STUDENT;
 	 
