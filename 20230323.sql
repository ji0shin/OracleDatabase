SELECT * FROM 성적표 ;

SELECT 학생ID
     , COUNT(*)  -- *는 NULL을 포함한 개수 집계
     , COUNT(성적)
  FROM 성적표
 GROUP BY 학생ID ;
 
-- 직원 테이블에 데이터가 몇개있지?

SELECT COUNT(*)
  FROM 직원 ;

SELECT COUNT(*)
  FROM 직원
 GROUP BY ();  -- 그룹바이를 안쓰면 자동으로 이렇게 진행됨 
               -- 직원테이블 전체를 하나의 그룹으로 봄
               
SELECT MAX(연봉)
  FROM 직원 ;  -- 직원 테이블을 하나의 그룹으로 봄 따라서 실행이 가능함 
  
--

SELECT MAX(입사일시) FROM 직원 ;
SELECT MIN(직원ID) FROM 직원 ; 

--

SELECT 학생ID, ROUND(AVG(성적), 1)
  FROM 성적표
 GROUP BY 학생ID ;
 
-- 실습문제 
--1. 성적표 테이블에서 학생별로 평균점수 출력 (소수점 1자리 까지만)

SELECT 학생ID
     , ROUND(AVG(성적), 1) AS 평균성적
  FROM 성적표
 GROUP BY 학생ID ; 
 
--2. 직원 테이블에서 모든 직원 중 최고 연봉과 최저 연봉 출력

SELECT MAX(연봉) AS 최고연봉
     , MIN(연봉) AS 최저연봉
  FROM 직원 ;
  
SELECT 직원ID
     , MAX(연봉) AS 최고연봉
     , MIN(연봉) AS 최저연봉
  FROM 직원 
  GROUP BY ();
  
SELECT 직원ID
     , MAX(연봉) AS 최고연봉
     , MIN(연봉) AS 최저연봉
  FROM 직원 
  GROUP BY 직원ID;
  
--3. 수강생정보 테이블에서 각 소속된 반 별로 몇 명이 있는지 출력

SELECT 소속반
     , COUNT(*) AS 반별인원수
  FROM 수강생정보
 GROUP BY 소속반 ;
 
--4. 성적표 테이블에서 학생별로 국어와 영어 성적의 평균을 출력 
-- (과목이 수학인 데이터 제외)

SELECT 학생ID
     , AVG(성적) AS 수학제외한평균
  FROM 성적표
 WHERE 과목 IN ('국어', '영어') 
GROUP BY 학생ID ; -- WHERE 조건 처리 후 GROUP BY 진행

--5. 직원 테이블에서 부서별로 연봉의 합계 출력

SELECT 부서ID
     , SUM(연봉) AS 부서별연봉합계
  FROM 직원 
 GROUP BY 부서ID ;
 
--6. 직원 테이블과 직원 연락처 테이블일 이용하여 직원별로 연락처 정보가 몇 개 있는지 출력
-- 직원 테이블을 기준으로 A0001 ~ A0011의 모든 직원을 보여주되,
-- 연락처가 없는 대상도 0건으로 출력 (조인시 오라클 방식 조인 활용)

SELECT A.직원ID
     , COUNT(B.연락처) AS 연락처개수
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID (+)
 GROUP BY A.직원ID ;  
 
-- HAVING

SELECT 학생ID, ROUND(AVG(성적), 1) AS 평균성적
  FROM 성적표
WHERE AVG(성적) <= 75
 GROUP BY 학생ID
  ;
    
-- 실습문제 
--1. 수강생정보 테이블에서 소속반 별 인원수가 3명이상인 튜플만 출력

SELECT 소속반
     , COUNT(*) AS 인원수
  FROM 수강생정보
 GROUP BY 소속반
 HAVING COUNT(*) >= 3 ;
 
--2. 직원 테이블에서 부서별 최고연봉이 7500인 튜플만 출력

SELECT 부서ID
     , MAX(연봉) AS 최고연봉
  FROM 직원
 GROUP BY 부서ID
 HAVING MAX(연봉) = 7500 ;
 
--3. 성적표 테이블에서 학생별 평균성적을 구하되, 평균값이 NULL이 아닌 값만 출력
SELECT 학생ID
     , ROUND(AVG(성적) , 1) AS 평균성적
  FROM 성적표
 GROUP BY 학생ID 
 HAVING AVG(성적) IS NOT NULL ; 
 
-- ORDER BY 

SELECT *
  FROM 직원
 ORDER BY 이름 DESC ;
 
SELECT *
  FROM 직원
 ORDER BY 부서ID, 이름 DESC ;  
 -- 부서ID를 기준으로 오름차순 정렬하되 똑같은 부서가 있으면 이름 기준으로 내림차순 정렬
 
SELECT 직원ID
     , 이름
     , 연봉 AS 직원들의연봉
     , 연봉 * 0.1 AS 보너스
  FROM 직원
 ORDER BY 3 ;  -- 직원들의연봉을 기준으로 오름차순 정렬
 
SELECT 직원ID
     , 이름
     , 연봉 AS 직원들의연봉
     , 연봉 * 0.1 AS 보너스
  FROM 직원
 ORDER BY 직원들의연봉 ;
 
-- DML INSERT

INSERT INTO 직원 (
       직원ID
     , 패스워드
     , 이름
     , 성별
     , 나이
     , 입사일시
     , 주민등록번호
     , 부서ID
) VALUES (
         'A0013'
       , 'pass1234'
       , '강감찬'
       , '남'
       , '30'
       , SYSDATE
       , '930911-1255231'
--       , 'D001'
) ;

SELECT * FROM 직원 ;

INSERT INTO 직원
VALUES (
'A0014' 
, 'hipasswd'
, '공손한'
, '여'
, 50
, sysdate
, '740922-2555111'
, 7000
, 'D002'
) ;

COMMIT;

UPDATE 직원 
   SET 연봉 = 9999 ; -- 직원 테이블의 모든 연봉이 9999로 바뀜
  
ROLLBACK ; -- 방금 입력한 문법이 되돌려짐

UPDATE 직원
   SET 연봉 = 9999
 WHERE 직원ID = 'A0001' ;
 
COMMIT;

SELECT * FROM 직원 ;