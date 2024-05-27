--8

--1) 평점이 3.0에서 4.0사이의 학생을 검색하라(between and)

SELECT SNAME 
  	 , AVR
 	FROM STUDENT 
 	WHERE AVR BETWEEN 3.0 AND 4.0;
 	


--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라(between and)
 
 SELECT PNAME
 	    ,HIREDATE 
 	FROM PROFESSOR
 	WHERE HIREDATE BETWEEN TO_DATE('19940101 00:00:00', 'yyyyMMdd HH24:mi:ss') AND TO_DATE('19951231 00:00:00', 'yyyyMMdd HH24:mi:ss');
 


--3) 화학과와 물리학과, 생물학과 학생을 검색하라(in)

 SELECT SNAME
 	    ,MAJOR 
 	    FROM STUDENT 
 	    WHERE MAJOR IN ('화학', '물리', '생물');

--4) 정교수와 조교수를 검색하라(in)
 	   
SELECT  PNAME
	  , ORDERS
	   FROM PROFESSOR
	   WHERE ORDERS IN ('정교수','조교수');


--5) 학점수가 1학점, 2학점인 과목을 검색하라(in)
SELECT  CNAME
	  , ST_NUM
	   FROM COURSE
	   WHERE ST_NUM IN ('1','2');

--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라(between and)
SELECT  SNAME
	  , SYEAR
	  , AVR
	   FROM STUDENT
	   WHERE AVR BETWEEN 2.0 AND 3.0;

--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라(in)
SELECT  SNAME
	  , SYEAR
	  , AVR
	   FROM STUDENT
	   WHERE MAJOR IN ('화학','물리')
	   AND SYEAR IN (1, 2)
	  ORDER BY AVR DESC;

--8) 부임일이 1995년 이전인 정교수를 검색하라(to_date)
SELECT PNAME 
	 , ORDERS 
	 , HIREDATE 
	 FROM PROFESSOR
	 WHERE HIREDATE < TO_DATE('19950101 00:00:00', 'yyyyMMdd HH24:mi:ss')
	 AND ORDERS = '정교수';
	 
	 

--9

--1) 송강 교수가 강의하는 과목을 검색한다
	
SELECT SECTION
	 , PNAME 
	FROM PROFESSOR
	WHERE PNAME = '송강';


--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT PNAME 
	 , SECTION
	FROM PROFESSOR
	WHERE SECTION ='화학';
--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다

SELECT P.PNAME 
	 , C.ST_NUM 
	 , C.CNAME
	 FROM PROFESSOR P
	 JOIN COURSE C 
	   ON P.PNO = C.PNO
	 WHERE ST_NUM = 2;

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT C.CNAME 
	 , P.PNAME 
	 , P.SECTION 
	 FROM PROFESSOR P
	 JOIN COURSE C
	   ON P.PNO = C.PNO 
	WHERE P.SECTION = '화학';
	

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT S.SNAME 
	 , S.SYEAR
	 , S.MAJOR 
	 , SC.RESULT 
	 FROM STUDENT S
	 JOIN SCORE SC 
	   ON SC.SNO = S.SNO
	  WHERE S.SYEAR =1;

--6) 일반화학 과목의 기말고사 점수를 검색한다
	 
SELECT C.CNAME
	 , SC.RESULT 
	 FROM COURSE C
	 JOIN SCORE SC 
	   ON SC.CNO = C.CNO
	  WHERE C.CNAME ='일반화학';


--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다

SELECT S.SNAME 
	 , S.SYEAR
	 , S.MAJOR
	 , C.CNAME
	 , SC.RESULT 
	 FROM STUDENT S
	 JOIN SCORE SC 
	   ON SC.SNO = S.SNO
	 JOIN COURSE C  
	   ON C.CNO = SC.CNO
	WHERE S.SYEAR =1
	  AND S.MAJOR ='화학'
	  AND C.CNAME = '일반화학';
	
--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
	 
SELECT S.SNAME 
	 , S.SYEAR
	 , S.MAJOR
	 , C.CNAME
	 FROM STUDENT S
	 JOIN SCORE SC 
	   ON SC.SNO = S.SNO
	 JOIN COURSE C  
	   ON C.CNO = SC.CNO
	WHERE S.SYEAR =1
	  AND S.MAJOR ='화학';	 
	 
--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다

SELECT C.CNAME 
	 , S.SNAME 
	 , SC.RESULT
	 , GR.GRADE 
	 FROM STUDENT S
	 JOIN SCORE SC  
	   ON SC.SNO = S.SNO
	 JOIN COURSE C
	   ON SC.CNO = C.CNO
	 JOIN SCGRADE GR  
	   ON SC.RESULT BETWEEN GR.LOSCORE AND GR.HISCORE 
	WHERE C.CNAME = '유기화학'
      AND GR.GRADE ='F';
	   

--10

--1) 학생중에 동명이인을 검색한다 (셀프조인)이름이 SNO은 달라. 

 SELECT S.SNAME
 		,ST.SNAME
 	    ,ST.SNO
 	   FROM STUDENT S
 	   JOIN STUDENT ST 
 	     ON S.SNAME = ST.SNAME
 	    AND ST.SNO != S.SNO;
 	    

 	   
 	  

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다

SELECT P.PNAME 
	 , P.SECTION 
	 , C.CNAME
	 FROM PROFESSOR P
	 LEFT JOIN COURSE C
	 ON C.PNO = P.PNO

	 ORDER BY SECTION ;
	 

--3) 이번 학기 등록된 모든 과목(COURSE)과 담당 교수의 학점 순으로 검색한다
SELECT C.CNAME 
	, P.PNAME
	, P.SECTION
	, SC.RESULT 
	FROM COURSE C 
	JOIN PROFESSOR P 
	  ON C.PNO = P.PNO 
	JOIN SCORE SC  
	  ON SC.CNO = C.CNO 
	ORDER BY SC.RESULT DESC;

--11

--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNAME 
	,  P.PNAME 
	FROM PROFESSOR P
	JOIN COURSE C
	  ON P.PNO = C.PNO;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT SNAME 
	  , AVR 
	  , MAJOR
	  FROM STUDENT  
	  WHERE MAJOR = '화학';

--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT  SNAME 
	   ,AVR
	   ,MAJOR
	   FROM STUDENT 
	   WHERE MAJOR ='유기화학';

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT A.SNAME 
	, A.MAJOR 
	, B.PNAME 
	, B .CNAME
	FROM (
		 --학생 _ 성적 
			SELECT SC.CNO
				   ,S.MAJOR
				   ,S.SNAME
				FROM STUDENT S
				JOIN SCORE SC 
				  ON SC.SNO = S.SNO
	)A
	JOIN (--과목 교수
		SELECT C.CNO
			 , P.PNAME
			 , C.CNAME
			FROM COURSE C
			JOIN PROFESSOR P
			  ON C.PNO = P.PNO
	)B
	ON A.CNO = B.CNO
	WHERE A.MAJOR ='화학'; 
	  

--5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT P.PNAME
	, C.CNAME
	 FROM PROFESSOR P
	 LEFT JOIN COURSE C 
	 ON P.PNO = C.PNO;

--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT P.PNAME
	, P.SECTION
	, C.CNAME
	 FROM PROFESSOR P
	 FULL JOIN COURSE C
	 ON C.PNO = P.PNO;

