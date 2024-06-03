--1) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.
DECLARE
    CURSOR CO_SCO_CUR IS
        SELECT C.CNO
             , C.CNAME
             , ROUND(AVG(SC.RESULT), 2)
            FROM COURSE C
            JOIN SCORE SC
            ON C.CNO = SC.CNO
            GROUP BY C.CNO, C.CNAME;

    TYPE CO_SCO_REC IS RECORD(
        CNO COURSE.CNO%TYPE,
        CNAME COURSE.CNAME%TYPE,
        AVG_RES NUMBER
    );
-----
    TYPE COURSE_REC IS RECORD (
           CNO C.CNO%TYPE,
           CNAME C.CNAME%TYPE,
           AVG SC.RESULT%TYPE
    );

    
    COURSE_REC COURSE_REC_TYPE;

    TYPE COURSE_REC_ARRAY IS TABLE OF COURSE_REC INDEX BY PLS_INTEGER;
    COURSE_RECS COURSE_REC_ARRAY;    -- 배열 변수 선언
    IDX PLS_INTEGER := 1;    
----
    COURSE_REC COURSE_REC_TYPE;
    TYPE CO_SCO_REC_ARR IS TABLE OF  CO_SCO_REC
    INDEX BY PLS_INTEGER;

    COSCORECARR CO_SCO_REC_ARR;
    IDX NUMBER := 1;
BEGIN
    OPEN CO_SCO_CUR;
    
    LOOP
        FETCH CO_SCO_CUR INTO COSCORECARR(IDX);

        EXIT WHEN CO_SCO_CUR%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(COSCORECARR(IDX).CNO);
        DBMS_OUTPUT.PUT_LINE(COSCORECARR(IDX).CNAME);
        DBMS_OUTPUT.PUT_LINE(COSCORECARR(IDX).AVG_RES);

        IDX := IDX + 1;
    END LOOP;
END;
/

--2) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.
DECLARE
    CURSOR ST_RES_CUR IS
        SELECT ST.SNO
             , ST.SNAME
             , ROUND(AVG(SC.RESULT), 2)
            FROM STUDENT ST
            JOIN SCORE SC
            ON ST.SNO = SC.SNO
            GROUP BY ST.SNO, ST.SNAME;
    
    TYPE ST_RES_RES IS RECORD(
        SNO STUDENT.SNO%TYPE,
        SNAME STUDENT.SNAME%TYPE,
        AVG_RES NUMBER(5, 2)
    );

    STRESREC ST_RES_RES;
BEGIN
    OPEN ST_RES_CUR;
    
    LOOP
        FETCH ST_RES_CUR INTO STRESREC;
        
        EXIT WHEN ST_RES_CUR%NOTFOUND;
        
        INSERT INTO T_STAVGSC
        VALUES STRESREC;
        
    END LOOP;
    
    CLOSE ST_RES_CUR;
END;
/


--내가 푼것.
--1) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.

DECLARE 
    TYPE COURSE_REC IS RECORD (
           CNO C.CNO%TYPE,
           CNAME C.CNAME%TYPE,
           AVG SC.RESULT%TYPE
    );

    COURSE_REC COURSE_REC_TYPE;

    TYPE COURSE_REC_ARRAY IS TABLE OF COURSE_REC INDEX BY PLS_INTEGER;
    COURSE_RECS COURSE_REC_ARRAY;    -- 배열 변수 선언
    IDX PLS_INTEGER := 1;               -- 인덱스 변수 초기화

BEGIN 
   FOR   COURSE_REC_TYPE   IN          
   
    (C.CNO 
    ,C.CNAME 
    ,AVG(SC.RESULT) 
    FROM COURSE C 
    JOIN SCORE SC
    ON SC.CNO = C.CNO 
    GROUP BY C.CNO, C.CNAME)
    LOOP
   
 DBMS_OUTPUT.PUT_LINE


--2) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.

CREATE TABLE T_STAVGSC (
    SNO VARCHAR2(8),
    SNAME VARCHAR2(20),
    AVG_RESULT NUMBER(5, 2)
);

CREATE OR REPLACE PROCEDURE P_T_STAVGSC
    IS
    CURSOR CUR_T_STAVGSC IS     
        SELECT S.SNO  
        , S.SNAME 
        , AVG(SC.RESULT)
        FROM STUDENT S
        JOIN SCORE SC 
        ON S.SNO = SC.SNO
        GROUP BY S.SNO, S.SNAME ;

  -- 예외 처리
    ex_no_data_found EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_no_data_found, -1403);
BEGIN
    -- T_STAVGSC 테이블 데이터 삭제
    DELETE FROM T_STAVGSC;

    -- 커서를 사용하여 조회된 데이터를 T_STAVGSC 테이블에 삽입
    FOR REC IN CUR_T_STAVGSC LOOP
        INSERT INTO T_STAVGSC (SNO, SNAME, AVG_RESULT)
        VALUES (rec.SNO, rec.SNAME, rec.AVG_RESULT);
    END LOOP;

    -- 데이터 삽입 후 커밋
    COMMIT;
EXCEPTION
    WHEN ex_no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/