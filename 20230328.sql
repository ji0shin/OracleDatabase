-- ROWNUM
SELECT *
  FROM (
        SELECT ROWNUM AS RN  -- ROWNUM이 이미 표에 있는 값인 것처럼(인라인뷰)
            , 직원ID
            , 이름
            , 연봉
            , 부서ID
         FROM 직원
    )
 WHERE RN = 2;  -- ROWNUM = 2인 대상만 뽑기
 
-- TOP-N
SELECT *
  FROM (
        SELECT *
          FROM 직원
         WHERE 연봉 IS NOT NULL
         ORDER BY 연봉 DESC  -- 정렬을 미리한 테이블로 가공
         )
 WHERE ROWNUM <= 5 ; -- 밖에서 ROWNUM 사용
 
-- TOP-N 실습
--1. 직원 중에 연봉이 낮은 하위 3명의 모든 정보 출력
SELECT *
  FROM (
        SELECT *
          FROM 직원
         WHERE 연봉 IS NOT NULL 
         ORDER BY 연봉
         )
 WHERE ROWNUM <= 3 ;

--2. 직원 중에 가장 최근에 입사한 3명의 모든 정보 출력 (입사일시 NULL 제외)
SELECT *
  FROM (
        SELECT *
          FROM 직원 
         WHERE 입사일시 IS NOT NULL
         ORDER BY 입사일시 DESC
         )
 WHERE ROWNUM <= 3 ;
 
CREATE TABLE 게시판 ( 
게시판번호 NUMBER(9) PRIMARY KEY , 
작성자 VARCHAR2(50) NOT NULL , 
게시물내용 VARCHAR2(4000) NOT NULL , 
작성일시 DATE NOT NULL 
) ;
INSERT INTO 게시판
SELECT LEVEL -- 게시판번호
, '아이디' || MOD(LEVEL , 10000) -- 작성자
, '아이디' || 
MOD(LEVEL , 10000) || 
'님이 작성하신 게시물입니다. 이 게시물은 게시판 번호가 ' 
|| LEVEL 
|| '입니다' -- 게시물내용
, TO_DATE('20000101') + LEVEL --2022년 1월1일부터 하루씩 게시물이 입력되는 것
FROM DUAL
CONNECT BY LEVEL <=1000000; --100만건의 데이터 입력
COMMIT;

SELECT * FROM 게시판 ;
  -- 한 번에 100만개의 데이터를 보여주지 않음
  -- 처음에 50개만 보여주고, 드래그를 하면 50개씩 추가로 보여줌

-- 가장 최근에 게시된 게시물 20개를 뽑아 모든 컬럼 정보 출력
SELECT *
  FROM (
        SELECT *
          FROM 게시판
         ORDER BY 작성일시 DESC
         )
 WHERE ROWNUM <= 20 ;
 
-- 상위 40개까지 뽑는다. 
-- 그 중에서 21번째부터 뽑는다. 
SELECT *
  FROM (
        SELECT ROWNUM AS RN, A.*
          FROM (
                SELECT *
                  FROM 게시판
                 ORDER BY 작성일시 DESC
                 ) A
         WHERE ROWNUM <= 40
         )
 WHERE RN >= 21 ;
 
-- 페이징 기술 구현
SELECT *
  FROM (
        SELECT ROWNUM AS RN, A.*
          FROM (
                SELECT *
                  FROM 게시판
                 ORDER BY 작성일시 DESC
                 ) A
         WHERE ROWNUM <= 20 * N  -- N은 선택한 페이지, 20은 한 페이지에 보여줄 게시글 수
         )
 WHERE RN >= 20*(N -1) + 1 ;
 
-- 게시판 테이블에서 가장 최근에 작성된 게시물을 기준으로 31~60번째 데이터만 보이도록 쿼리를 작성
SELECT *
  FROM (
        SELECT ROWNUM AS RN
             , A.*
          FROM (
                SELECT * 
                  FROM 게시판
                 ORDER BY 작성일시 DESC
                 ) A
         WHERE ROWNUM <= 60
         )
 WHERE RN >= 31 ;
 
--AS 관련 문제 -> 컬럼명 테이블명은 대소문자 구분 X
SELECT 직원ID AS hello
  FROM 직원 ;
  
-- "" 안에 문자열을 넣으면 그대로 들어간다
SELECT 직원ID AS "hello"
     , 연봉 AS " 1 2 3 4 "
 FROM 직원 ;
 
ALTER TABLE 직원 MODIFY (부서ID NULL) ;
UPDATE 직원 SET 부서ID = NULL WHERE 직원ID = 'A0005' ;
COMMIT;

SELECT A.직원ID
     , A.연봉
     , A.부서ID
     , (
        SELECT 부서명, 부서ID
          FROM 부서
         WHERE 부서ID = B.부서ID ) AS 부서명 -- A.부서ID가 NULL이면 비교 불가능 ->  이때는 NULL값 출력
  FROM 직원 A
 WHERE 직원ID BETWEEN 'A0001' AND 'A0006' ; -- 직원ID 테이블에서 WHERE해당하는 조건의 수 만큼 SELECT 실행
 
-- 조인으로 결과 가져오기
SELECT A.직원ID
     , A.연봉
     , A.부서ID
     , B.부서명
  FROM 직원 A
     , 부서 B
 WHERE A.부서ID = B.부서ID (+)  -- 서브쿼리 사용시 직원 테이블에서 WHERE절에 해당하는 조건을 모두 가져왔으므로 
                               -- 아우터 조인으로 직원 테이블을 기준으로 모든 튜플 출력 
   AND A.직원ID BETWEEN 'A0001' AND 'A0006' ;

SELECT A.직원ID
     , A.연봉
     , A.부서ID
     , B.부서명
  FROM 직원 A LEFT OUTER JOIN 부서 B
    ON (A.부서ID = B.부서ID)
 WHERE A.직원ID BETWEEN 'A0001' AND 'A0006' ;
 
-- 스칼라 서브쿼리 문제 
--1. 직원 테이블에서 직원 A0001부터 A0006까지의 직원ID, 연봉, 부서ID를 출력하고
-- 부서ID에 대한 부서명도 함께 출력 
SELECT 직원ID
     , 연봉
     , 부서ID
     , (
         SELECT 부서명
           FROM 부서
          WHERE 부서ID = 직원.부서ID
          ) AS 부서명
  FROM 직원
 WHERE 직원ID BETWEEN 'A0001' AND 'A0006' ;
 
-- 조인방식
SELECT A.직원ID
     , A.연봉
     , A.부서ID
     , B.부서명
  FROM 직원 A
     , 부서 B
 WHERE A.부서ID = B.부서ID (+)
   AND A.직원ID BETWEEN 'A0001' AND 'A0006' ;
 
--2. 직원 테이블에서 직원 A0006부터 A0010까지의 직원ID, 이름, 주민등록번호를 출력
-- 휴대폰번호도 함께 출력
SELECT 직원ID
     , 이름
     , 주민등록번호
     , (
         SELECT 연락처
           FROM 직원연락처
          WHERE 구분코드 = '휴대폰'
            AND 직원ID = 직원.직원ID
        ) AS 휴대폰번호
  FROM 직원
 WHERE 직원ID BETWEEN 'A0006' AND 'A0010' ;
 
-- 조인방식
SELECT A.직원ID 
     , A.이름
     , A.주민등록번호
     , B.연락처
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID (+)
   AND A.직원ID BETWEEN 'A0006' AND 'A0010'
   AND B.구분코드 (+) = '휴대폰'; 


--3. 2번 문제의 쿼리를 그대로 사용하되 스칼라서브쿼리를 한번 더 사용하여 
-- A0006~A0010 까지의 직원에 대한 집주소도 함께 출력
SELECT 직원ID
     , 이름
     , 주민등록번호
     , (
         SELECT 연락처
           FROM 직원연락처
          WHERE 구분코드 = '휴대폰'
            AND 직원ID = 직원.직원ID
        ) AS 휴대폰번호
     , (
         SELECT 주소
           FROM 직원주소
          WHERE 직원ID = 직원.직원ID
            AND 구분코드 = '집'
        ) AS 집주소
  FROM 직원
 WHERE 직원ID BETWEEN 'A0006' AND 'A0010' ;
 
 -- 조인 
SELECT A.직원ID
     , A.이름
     , A.주민등록번호 
     , B.연락처 AS 휴대폰번호
     , C.주소 AS 집주소
  FROM 직원 A
     , 직원연락처 B
     , 직원주소 C
 WHERE A.직원ID = B.직원ID (+)
   AND A.직원ID = C.직원ID (+)
   AND A.직원ID BETWEEN 'A0006' AND 'A0010'
   AND B.구분코드 (+) = '휴대폰' -- 구분코드 NULLL이면 = 비교 불가 -> 출력안됨
   AND C.구분코드 (+) = '집'; 
   
-- 인라인뷰
SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.부서별최고연봉
  FROM 직원 A
     , (
         SELECT 부서ID, MAX(연봉) AS 부서별최고연봉
           FROM 직원
          WHERE 부서ID IS NOT NULL
          GROUP BY 부서ID
        ) B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최고연봉 ;
   
-- 인라인뷰 문제
--1. 부서별로 가장 낮은 연봉을 가진 직원들의 모든 정보 출력 (부서ID가 NULL인 직원 제외)
SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.부서별최저연봉
  FROM 직원 A
     , (
        SELECT MIN(연봉) AS 부서별최저연봉
          FROM 직원
         GROUP BY 부서ID 
         ) B
 WHERE A.연봉 = B.부서별최저연봉
   AND A.부서ID IS NOT NULL ;

SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.부서별최저연봉
  FROM 직원 A
     ,  (
        SELECT 부서ID
             , MIN(연봉) AS 부서별최저연봉
          FROM 직원
         WHERE 부서ID IS NOT NULL
         GROUP BY 부서ID
        ) B
 WHERE A.연봉 = B.부서별최저연봉
;

--2. 나이가 어린 직원 3명의 모든 정보를 출력
SELECT *
  FROM (
        SELECT * 
          FROM 직원
         WHERE 나이 IS NOT NULL
         ORDER BY 나이
         )
 WHERE ROWNUM <= 3 ;
 
-- 중첩 서브쿼리
SELECT *
  FROM 직원
 WHERE 연봉 >= ( SELECT AVG(연봉)
                  FROM 직원
                ) ; -- 전체 직원의 평균 연봉보다 크거나 같은 직원의 모든 정보 출력