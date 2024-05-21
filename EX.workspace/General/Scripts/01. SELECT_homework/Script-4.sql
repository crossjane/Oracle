---4

--1) 성적순으로 학생의 이름을 검색하라
SELECT SNAME
	 , AVR 
	FROM STUDENT
	ORDER BY AVR DESC;

--2) 학과별 성적순으로 학생의 정보를 검색하라
SELECT SNO
 	 , SNAME
 	 , SEX
 	 , SYEAR
 	 , MAJOR
 	 , AVR
 	 FROM STUDENT
 	 ORDER BY MAJOR, AVR DESC;

--3) 학년별 성적순으로 학생의 정보를 검색하라
SELECT SNO
 	 , SNAME
 	 , SEX
 	 , SYEAR
 	 , MAJOR
 	 , AVR
 	 FROM STUDENT
 	 ORDER BY SYEAR, AVR DESC;


--4) 학과별 학년별로 학생의 정보를 성적순으로 검색하라
 	
 SELECT SNO
 	 , SNAME
 	 , SEX
 	 , SYEAR
 	 , MAJOR
 	 , AVR
 	 FROM STUDENT
 	 ORDER BY MAJOR, SYEAR, AVR DESC;



--5) 학점순으로 과목 이름을 검색하라
 	 SELECT MAJOR
 		 , AVR
 	 FROM STUDENT
 	 ORDER BY AVR DESC;


--6) 각 학과별로 교수의 정보를 검색하라
SELECT PNAME
	 , PNO
	 , SECTION
	 , ORDERS 
	 , HIREDATE 
	 FROM PROFESSOR
	 ORDER BY SECTION;


--7) 지위별로 교수의 정보를 검색하라
SELECT PNAME
	 , PNO
	 , SECTION
	 , ORDERS 
	 , HIREDATE 
	 FROM PROFESSOR
	 ORDER BY ORDERS DESC;


--8) 각 학과별로 교수의 정보를 부임일자 순으로 검색하라
SELECT PNAME
	 , PNO
	 , SECTION
	 , ORDERS 
	 , HIREDATE 
	 FROM PROFESSOR
	 ORDER BY HIREDATE;	
