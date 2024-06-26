---5

--1) 화학과 학생을 검색하라
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , AVR
	 , MAJOR
	 FROM STUDENT
	 WHERE MAJOR LIKE '화학';


--2) 평점이 2.0 미만인 학생을 검색하라
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , AVR
	 , MAJOR
	 FROM STUDENT
	 WHERE AVR < 2.0;

--3) 관우 학생의 평점을 검색하라
	SELECT SNAME
		 , AVR
	 FROM STUDENT
	 WHERE SNAME LIKE '관우';


--4) 정교수 명단을 검색하라
SELECT PNAME
 	 , ORDERS 
	FROM PROFESSOR
	WHERE ORDERS LIKE '정교수';

--5) 화학과 소속 교수의 명단을 검색하라
SELECT PNAME
 	 , SECTION
	FROM PROFESSOR
	WHERE SECTION LIKE '화학';


--6) 송강 교수의 정보를 검색하라
SELECT PNAME
 	 , PNO
 	 , ORDERS
 	 , HIREDATE 
 	 , SECTION
	FROM PROFESSOR
	WHERE PNAME LIKE '송강';

--7) 학년별로 화학과 학생의 성적을 검색하라
SELECT SNAME
	 , MAJOR
	 , AVR
	 , SYEAR
	FROM STUDENT
	WHERE MAJOR LIKE '화학'
	ORDER BY SYEAR; 

--8) 2000년 이전에 부임한 교수의 정보를 부임일순으로 검색하라

SELECT PNAME
 	 , PNO
 	 , ORDERS
 	 , HIREDATE 
 	 , SECTION
	FROM PROFESSOR
	WHERE HIREDATE
		BETWEEN TO_DATE('00010101 00:00:00', 'yyyyMMdd hh24:mi:ss')
	 	    AND TO_DATE('20000101 00:00:00', 'yyyyMMdd hh24:mi:ss')
	ORDER BY HIREDATE;


--9) 담당 교수가 없는 과목의 정보를 검색하라
SELECT CNO
 	 , CNAME
 	 , ST_NUM
 	 , PNO 
	FROM COURSE
	WHERE PNO IS NULL;
	
