SELECT '1' + 1 FROM DUAL ;
-- '1' 은 숫자로 변환 가능

SELECT 직원ID, 부서ID, DECODE(부서ID, 'D001', 'OK', 'NO')
  FROM 직원 ;

SELECT COALESCE(5, NULL, NULL, 1, NULL)
  FROM DUAL;
  
SELECT 직원ID
     , 패스워드
     , NVL(나이, 20)
  FROM 직원 ;
  
SELECT 직원ID
     , 성별
     , 연봉
     , DECODE(성별, '남', '남성입니다', '여성입니다') AS 남녀확인
  FROM 직원 ; 
  
-- WHERE절 

SELECT * 
  FROM 직원
 WHERE NOT 이름 = '이현정' ;
 
SELECT *
  FROM 직원
 WHERE 이름 != '이현정' ; -- 실무에서는 != 사용 (<>도 사용할 수 있음)
 
SELECT 직원ID
     , 구분코드
     , 연락처
  FROM 직원연락처
 WHERE 구분코드 != '휴대폰' ;
 
SELECT 직원ID
     , 이름
     , 성별
     , 나이
  FROM 직원
 WHERE 나이 >= 50 ;

-- NULL 조건

SELECT *
  FROM 직원
 WHERE 나이 = NULL ; -- 나이가 NULL인 데이터만 뽑을 때 이렇게 사용 불가
                    -- NULL은 정상적인 산술, 비교 연산이 불가능하기 때문
 
SELECT *
  FROM 직원
 WHERE 나이 IS NULL ; 
 
SELECT * 
  FROM 직원
 WHERE 나이 IS NOT NULL ;
 
SELECT *
  FROM 직원
 WHERE 나이 IS NOT NULL ;
 
SELECT *
  FROM 직원
 WHERE 입사일시 IS NULL ;

-- SQL 연산자 IN / BETWEEN / LIKE

SELECT *
  FROM 직원
 WHERE 직원ID NOT IN ( 'A0001' , 'A0003' , 'A0005', NULL ) ; 
 -- NOT IN 뒤에 NULL 들어가면 출력이 안됨. 아래와 똑같이 동작하기 때문
 
SELECT *
  FROM 직원
 WHERE 직원ID != 'A0001'
   AND 직원ID != 'A0003'
   AND 직원ID != 'A0005'
   AND 직원ID != NULL ;
   
SELECT *
  FROM 직원
 WHERE 나이 >= 20
   AND 나이 < 30 ; 
   
SELECT * 
  FROM 직원
 WHERE 나이 BETWEEN 20 AND 29 ;
 
 -- 주의사항 3가지
 -- 1. 모든 자료형 가능 : 날짜형, 숫자형, 문자형 모두 쓸 수 있음 
 SELECT *
   FROM 직원
 WHERE 입사일시 BETWEEN SYSDATE - 365 AND SYSDATE ;
 
  SELECT *
   FROM 직원
 WHERE 직원ID BETWEEN 'A0001' AND 'A0003' ;
 
 -- 2. OR 가 아님 : BETWEEN __ AND __
 -- 3. ~ 이상, ~ 이하를 의미함 (초과, 미만 X)
 -- 4. 첫번째 값보다 두번째 값이 같거나 커야얌
 SELECT * 
  FROM 직원
 WHERE 나이 BETWEEN 20 AND 18 ; -- 출력안됨
 
 -- LIKE
 SELECT * FROM 직원 WHERE 이름 LIKE '강%' ;
 
 SELECT * FROM 직원 WHERE 이름 LIKE '%강%' ;
 
 SELECT * FROM 직원 WHERE 패스워드 LIKE '%123' ;
 
 -- %는 0개 이상 문자 매칭, _는 1개 문자 매칭
 
 SELECT * FROM 직원 WHERE 이름 LIKE '__수' ;
 
 SELECT * FROM 부서 WHERE 부서명 LIKE '__부' ;
 
 -- WHERE에 형변환 함수 사용하기
 
SELECT * FROM 직원 WHERE TO_CHAR(입사일시, 'YYYY') = '2015' ;

SELECT * FROM 직원 
 WHERE 입사일시 > TO_DATE('20150101')
   AND 입사일시 < TO_DATE('20160101');
   
-- 문제
   
SELECT 직원ID
     , 이름
     , 나이
  FROM 직원 
 WHERE 이름 LIKE '%철%' ;
 
SELECT *
  FROM 직원
 WHERE TO_CHAR(입사일시, 'YYYY') = '2015' 
    OR 입사일시 IS NULL ; 
 
SELECT *
  FROM 직원 
 WHERE TO_CHAR(입사일시, 'YYYY') >= '2017' ;
 
SELECT *
  FROM 직원
 WHERE 입사일시 BETWEEN TO_DATE('20170101', 'YYYYMMDD HH24MISS') AND SYSDATE ;
 
SELECT * 
  FROM 직원
 WHERE 입사일시 >= TO_DATE('20170101', 'YYYYMMDD HH24MISS') ; 

SELECT 직원ID
     , 연봉
     , 입사일시
  FROM 직원
 WHERE 연봉 BETWEEN 7000 AND 9000 ;
 
SELECT *
  FROM 직원주소
 WHERE 주소 LIKE '동구%' ; 
  
-- FROM

SELECT SERVICE.직원.직원ID
  FROM SERVICE.직원
 WHERE SERVICE.직원.직원ID = 'A0005' ;
 
SELECT 직원ID
  FROM 직원
 WHERE 직원ID = 'A0005' ;
 
SELECT *
  FROM 직원, 직원연락처 ;
  
SELECT 직원.직원ID
     , A.이름
     , A.나이
     , A.연봉
     , B.직원ID
     , B.연락처
  FROM 직원 A, 직원연락처 B -- FROM에서 별칭을 줄 때는 AS를 사용하지 않음. 
 WHERE A.직원ID = 직원연락처.직원ID ;
 
SELECT A.직원ID
     , A.이름
     , A.연봉
     , B.연락처
  FROM 직원 A
     , 직원연락처 B
 WHERE A.직원ID = B.직원ID
   AND A.직원ID = 'A0006'
   AND B.구분코드 = '휴대폰' ;