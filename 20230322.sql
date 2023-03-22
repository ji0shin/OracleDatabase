/* 테스트 데이터를 만들어봅시다 */ 
CREATE TABLE 고객 (
고객번호 VARCHAR2(5) PRIMARY KEY , 
고객명 VARCHAR2(50) NOT NULL 
) ; 
CREATE TABLE 고객전화번호 ( 
고객번호 VARCHAR2(5) ,
전화구분코드 VARCHAR2(10) ,
전화번호 VARCHAR(15) NOT NULL 
) ; 
ALTER TABLE 고객전화번호 ADD CONSTRAINT PK_고객전화번호 PRIMARY KEY(고객번호 , 전화구분코드) ; 
INSERT INTO 고객 VALUES ( '0001' , '동동일' ) ; 
INSERT INTO 고객 VALUES ( '0002' , '동동이' ) ; 
INSERT INTO 고객 VALUES ( '0003' , '동동삼' ) ; 
INSERT INTO 고객전화번호 VALUES ( '0001' , '집전화' , '062-111-1111') ; 
INSERT INTO 고객전화번호 VALUES ( '0001' , '휴대폰' , '010-1111-1111') ; 
INSERT INTO 고객전화번호 VALUES ( '0002' , '휴대폰' , '010-2222-2222') ; 
INSERT INTO 고객전화번호 VALUES ( '0004' , '휴대폰' , '010-4444-4444') ; 
COMMIT;

-- 카티션조인 : 테이블이 FROM에 2개 이상 입력된 상태

SELECT * FROM 고객 ;

-- 고객번호 컬럼으로 연결 (조인조건)
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A, 고객전화번호 B
 WHERE A.고객번호 = B.고객번호(+);  -- 고객 테이블에 대한 실패한 튜플도 출력

SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A, 고객전화번호 B
 WHERE A.고객번호 (+) = B.고객번호 ;  -- 고객전화번호 테이블에 대한 실패한 튜플도 출력

 
 SELECT *
  FROM 고객 A, 고객전화번호 B
 WHERE A.고객번호 <= B.고객번호;  -- 비동등조인

-- 고객번호가 0001인 고객 (일반조건) 
SELECT A.고객번호
     , A.고객명
     , B.전화번호
  FROM 고객 A, 고객전화번호 B
 WHERE A.고객번호 = B.고객번호
   AND A.고객번호 = '0001' 
   AND B.전화구분코드 = '집전화' ;

-- 똑같은 이름의 컬럼이 있으면 안됨. 따라서 같은 이름일 경우 이름을 변경하여 보여줌
SELECT A.고객번호, B.고객번호
  FROM 고객 A, 고객전화번호 B ;

-- 실습
-- 1.
SELECT C.직원ID AS 직원_직원ID
     , C.성별
     , C.나이
     , D.직원ID AS 주소_직원ID
     , D.구분코드
     , D.주소
  FROM 직원 C, 직원주소 D
 WHERE C.직원ID = D.직원ID ;

-- 2.
SELECT C.직원ID
     , C.성별
     , C.나이
     , D.직원ID
     , D.구분코드
     , D.주소
  FROM 직원 C, 직원주소 D
 WHERE C.직원ID = D.직원ID 
   AND C.직원ID = 'A0007' ;

-- 3. 직원주소 테이블에 없는 = 직원 테이블에서 실패한 -> 직원 테이블 기준
SELECT C.직원ID AS 직원_직원ID
     , C.이름
     , C.연봉
     , D.직원ID AS 주소_직원ID
     , D.구분코드
     , D.주소
  FROM 직원 C, 직원주소 D
 WHERE C.직원ID = D.직원ID (+) ;
 
 SELECT * FROM 직원 ;
 SELECT * FROM 직원주소;
 
-- 4. 자주 사용되는 CASE 
SELECT C.직원ID
     , C.이름
     , C.연봉
     , D.직원ID
     , D.구분코드
     , D.주소
  FROM 직원 C, 직원주소 D
 WHERE C.직원ID = D.직원ID (+)
   AND D.주소 IS NULL;
   
-- 5. 
SELECT C.직원ID
     , C.이름
     , C.나이
     , D.주소
     , E.연락처
  FROM 직원 C, 직원주소 D, 직원연락처 E
 WHERE C.직원ID = D.직원ID
   AND C.직원ID = E.직원ID; -- 조인조건 최소 개수 = 테이블 개수 - 1
   
-- 6.
SELECT A.직원ID
     , A.이름
     , A.입사일시
     , B.연락처
  FROM 직원 A, 직원연락처 B
 WHERE A.직원ID = B.직원ID 
   AND A.직원ID IN ( 'A0001', 'A0002', 'A0003')
   AND B.구분코드 = '휴대폰';
   
-- 7. 
SELECT A.직원ID
     , A.이름
     , B.부서ID
     , B.부서명
  FROM 직원 A, 부서 B
 WHERE A.부서ID = B.부서ID ;

SELECT * FROM 부서 ;

-- 오라클 조인 -> ANSI 변경

SELECT *
  FROM 고객 A, 고객전화번호 B
 WHERE A.고객번호 = B.고객번호 (+) ;

SELECT *
  FROM 고객 A LEFT OUTER JOIN 고객전화번호 B
    ON (A.고객번호 = B.고객번호);

-- 실습
-- 1. 
SELECT A.직원ID
     , A.이름
     , B.주소
  FROM 직원 A LEFT OUTER JOIN 직원주소 B
    ON (A.직원ID = B.직원ID)
 WHERE A.직원ID IN ( 'A0005', 'A0008') ;
 
--2. 
SELECT B.직원ID
     , B.이름
     , A.주소
  FROM 직원주소 A RIGHT OUTER JOIN 직원 B
    ON (A.직원ID = B.직원ID) ;

--3. 
SELECT A.직원ID
     , A.이름
     , A.나이
     , B.연락처
  FROM 직원 A INNER JOIN 직원연락처 B
    ON (A.직원ID = B.직원ID);
    
-- 테이블 3개 조인하는 법
-- 2개씩만 조인 가능

SELECT A.직원ID
     , A.이름
     , B.연락처
     , C.주소
  FROM 직원 A
     , 직원연락처 B
     , 직원주소 C
 WHERE A.직원ID = B.직원ID
   AND B.직원ID = C.직원ID ; 

SELECT A.직원ID
     , A.이름
     , B.연락처
     , C.주소
  FROM 직원 A INNER JOIN 직원연락처 B ON (A.직원ID = B.직원ID)
              INNER JOIN 직원주소 C ON (B.직원ID = C.직원ID) ;

-- GROUP BY

DROP TABLE 학생인적사항 ;
쿼리 생성
DROP TABLE 수강생정보 ; 
DROP TABLE 성적표 ; 
CREATE TABLE 수강생정보 (
학생ID VARCHAR2(9) PRIMARY KEY , 
학생이름 VARCHAR2(50) NOT NULL , 
소속반 VARCHAR2(5) 
); 
CREATE TABLE 성적표 ( 
학생ID VARCHAR2(9) , 
과목 VARCHAR2(30) , 
성적 NUMBER , 
CONSTRAINT PK_성적표 PRIMARY KEY(학생ID , 과목) , 
CONSTRAINT FK_성적표 FOREIGN KEY(학생ID) REFERENCES 수강생정보(학생ID) 
) ; 
INSERT INTO 수강생정보 VALUES ('S0001' , '김현철' , 'A') ; 
INSERT INTO 수강생정보 VALUES ('S0002' , '문현중' , 'A') ; 
INSERT INTO 수강생정보 VALUES ('S0003' , '강문치' , 'B') ; 
INSERT INTO 수강생정보 VALUES ('S0004' , '박나선' , 'B') ; 
INSERT INTO 수강생정보 VALUES ('S0005' , '신태강' , 'B') ; 
INSERT INTO 수강생정보 VALUES ('S0006' , '물고기' , 'C') ; 
INSERT INTO 수강생정보 VALUES ('S0007' , '자라니' , 'C') ; 
INSERT INTO 수강생정보 VALUES ('S0008' , '공팔두' , 'C') ; 
INSERT INTO 수강생정보 VALUES ('S0009' , '최팔현' , 'C') ; 
INSERT INTO 성적표 VALUES('S0001' ,'국어' , 90); 
INSERT INTO 성적표 VALUES('S0001' ,'수학' , 85); 
INSERT INTO 성적표 VALUES('S0001' ,'영어' , 100); 
INSERT INTO 성적표 VALUES('S0002' ,'국어' , 100); 
INSERT INTO 성적표 VALUES('S0002' ,'수학' , 100); 
INSERT INTO 성적표 VALUES('S0002' ,'영어' , 20); 
INSERT INTO 성적표 VALUES('S0003' ,'국어' , 100); 
INSERT INTO 성적표 VALUES('S0003' ,'수학' , 100); 
INSERT INTO 성적표 VALUES('S0003' ,'영어' , 20); 
INSERT INTO 성적표 VALUES('S0004' ,'국어' , 85); 
INSERT INTO 성적표 VALUES('S0004' ,'수학' , 40); 
INSERT INTO 성적표 VALUES('S0004' ,'영어' , 60); 
INSERT INTO 성적표 VALUES('S0005' ,'국어' , 100); 
INSERT INTO 성적표 VALUES('S0005' ,'수학' , 100); 
INSERT INTO 성적표 VALUES('S0005' ,'영어' , 100); 
INSERT INTO 성적표 VALUES ( 'S0006' , '국어' , NULL ) ; 
INSERT INTO 성적표 VALUES ( 'S0006' , '수학' , NULL ) ; 
INSERT INTO 성적표 VALUES ( 'S0006' , '영어' , NULL ) ; 
COMMIT; 

SELECT * FROM 수강생정보 ;
SELECT * FROM 성적표 ;

SELECT 소속반, COUNT(*) AS 반별인원수
  FROM 수강생정보
 GROUP BY 소속반 ;
 
SELECT 소속반, 학생이름
  FROM 수강생정보
 GROUP BY 소속반 ;
 
SELECT 소속반, COUNT(*)
  FROM 수강생정보
 GROUP BY 소속반 ;
 
SELECT 학생ID, AVG(성적)
  FROM 성적표
 GROUP BY 학생ID ;

SELECT 학생ID, SUM(성적)
  FROM 성적표
 GROUP BY 학생ID ;

SELECT 학생ID, MAX(성적), MIN(성적)
  FROM 성적표
 GROUP BY 학생ID ;