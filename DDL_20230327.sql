COMMENT ON TABLE QUIZ_TABLE IS '퀴즈 정보가 들어간 테이블' ;
COMMENT ON COLUMN QUIZ_TABLE.Q_ID IS '퀴즈ID' ;

-- 1. DELETE 
DELETE FROM 성적표 ; -- 데이터 모두 날아감
-- 롤백이 가능

-- 2. TRUNCATE
TRUNCATE TABLE 성적표 ; -- 뒤에 WHERE절 쓰지 않음 
-- 롤백이 불가능

-- 3. DROP
DROP TABLE 성적표 ; 
-- 롤백이 불가능

SELECT * FROM 성적표 ;

ROLLBACK;

CREATE SEQUENCE 직원ID_SEQ
       INCREMENT BY 1  -- 증가할 시퀀스값
       START WITH 1    -- 시작할 시퀀스값
       MINVALUE 1      -- 최소 사용할 시퀀스 값은 1 
       MAXVALUE 9999 ; -- 최대 사용할 시퀀스 값은 9999
       
SELECT 직원ID_SEQ.NEXTVAL FROM DUAL ;

INSERT INTO 직원 (
직원ID
, 비밀번호
, 이름
, 성별
, 나이
, 입사일시
, 주민등록번호
, 연봉
, 부서ID
) VALUES ( 
'A' || LPAD( 직원ID_SEQ.NEXTVAL , 4 , '0' ) 
, '비밀번호123' 
, '새직원'
, '여'
, 30
, SYSDATE 
, '930711-2441223' 
, 5000 
, 'D006' 
);

SELECT LPAD( 직원ID_SEQ.NEXTVAL, 4, '0') FROM DUAL;

DROP SEQUENCE 직원ID_SEQ;

-- 뷰를 이용하여 자주 사용하는 쿼리를 따로 저장할 수 있음
CREATE VIEW 부서별최고연봉_VIEW AS -- AS 뒤에 자주 사용하는 쿼리 작성
SELECT 부서ID
     , MAX(연봉) AS 부서별최고연봉
  FROM 직원
 GROUP BY 부서ID 
 ORDER BY 부서ID ;
 
SELECT * FROM 부서별최고연봉_VIEW ;

-- 서브쿼리 : 쿼리 안에 쿼리를 작성하는 기술
-- 서브쿼리 기술 중 하나가 인라인뷰
-- FROM 절에 쿼리를 작성해 가상의 테이블처럼 사용하는 방식
SELECT A.이름
     , A.연봉
     , B.부서별최고연봉
  FROM 직원 A
     , (
     SELECT 부서ID
          , MAX(연봉) AS 부서별최고연봉
       FROM 직원
      GROUP BY 부서ID 
      ORDER BY 부서ID
     ) B
 WHERE A.부서ID = B.부서ID
   AND A.연봉 = B.부서별최고연봉 ;
   
CREATE VIEW 직원_민감정보제외 AS
SELECT 직원ID
     , 이름
     , 부서ID
 FROM 직원 ;
 
SELECT * FROM 직원_민감정보제외 ;

-- 직원ID가 A0005인 대상의 연봉을 1000만원 인상한다.
UPDATE 직원
   SET 연봉 = 연봉 + 1000
 WHERE 직원ID = 'A0005' ;
 
SELECT 직원ID, 이름, 연봉 FROM 직원 ;

COMMIT ;

UPDATE 직원 
   SET 연봉 = 9999
 WHERE 직원ID = 'A0003' ; 
 
ROLLBACK;